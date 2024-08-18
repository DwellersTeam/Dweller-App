import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/services/controller/settings/settings_controller.dart';
import 'package:dweller/services/repository/create_profile_service/create_profile_service.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/country_code_widget.dart';
import 'package:dweller/utils/components/custom_appbar.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/search/settings/page/change_mobile_number.dart';
import 'package:dweller/view/search/settings/page/change_password.dart';
import 'package:dweller/view/search/settings/page/verify_email.dart';
import 'package:dweller/view/search/settings/widget/general/change_button.dart';
import 'package:dweller/view/search/settings/widget/general/mock_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key, required this.userId});
  final String userId;

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  
  final controller = Get.put(SettingsController());
  final profileService = Get.put(CreateProfileService());
  final String userLocalId = LocalStorage.getUserID();

  late Future<UserModel> profileFuture;

  @override
  void initState() {
    profileFuture = _refresh();
    super.initState();
  }


  //REFRESH FUNCTIONALITY
  Future<UserModel> _refresh() async{
    await Future.delayed(const Duration(seconds: 2));
    final profileFuture = await profileService.getUserByIdEndpoint(
      context: context, 
      id: widget.userId
    );
    return profileFuture;
  }


  Future<void> _handleRefresh() async{
    setState(() {
      profileFuture = _refresh();
    });
  }

  //fetch user profile by id
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: CustomPaint(
          painter: TopRedSectionPainter(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //appbar
              DwellerAppBar(
                actionIcon: SvgPicture.asset('assets/svg/settings_icon.svg'),
              ),
              //SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Account Settings',
                  style: GoogleFonts.bricolageGrotesque(
                    color: AppColor.darkPurpleColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              Expanded(
                child: FutureBuilder<UserModel>(
                  future: profileFuture,
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const LoaderS();
                    }
                    if(snapshot.hasError){
                      log("snapshot err: ${snapshot.error}");
                      return Center(
                        child: Text(
                          'An error occured.',
                          style: GoogleFonts.bricolageGrotesque(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      );
                    }
                    if(!snapshot.hasData) {
                      log("snapshot has data?: ${snapshot.hasData}");
                      return Center(
                        child: Text(
                          'No data found.',
                          style: GoogleFonts.bricolageGrotesque(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      );
                    }

                    final data = snapshot.data!;

                    return RefreshIndicator.adaptive(
                      color: AppColor.whiteColor,
                      backgroundColor: AppColor.darkPurpleColor,
                      onRefresh: () => _handleRefresh(),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email and Password management',
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.blackColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                      
                            //1
                            SizedBox(height: 20.h,),
                            Text(
                              'Your Email',
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.semiDarkGreyColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(height: 10.h,),
                            MockField(
                              text: data.email,
                            ),
                            SizedBox(height: 10.h,),
                            ChangeButton(
                              onPressed: () {
                                Get.to(() => VerifyEmailPage(
                                  email: data.email,  //replaceFirst('ebelechukwu', '*****'),
                                ));
                              },
                              text: 'Verify',
                              width: 60.w,
                            ),
                            
                            //2
                            SizedBox(height: 30.h,),
                            Text(
                              'Your Password',
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.semiDarkGreyColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(height: 10.h,),
                            const MockField(
                              text: '*********',
                            ),
                            SizedBox(height: 10.h,),
                            ChangeButton(
                              onPressed: () {
                                Get.to(() => ChangePasswordPage(
                                  onRefresh: () => _handleRefresh(),
                                ));
                              },
                              text: 'Change',
                              width: 75.w,
                            ),
                      
                            //3
                            SizedBox(height: 30.h,),
                            Text(
                              'Your Phone Number',
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.semiDarkGreyColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(height: 10.h,),
                            MockField(
                              text: data.phone,
                            ),
                            SizedBox(height: 10.h,),
                            ChangeButton(
                              onPressed: () {
                                Get.to(() => ChangeMobileNumberPage(
                                  onRefresh: () => _handleRefresh(),
                                  phone: data.phone,
                                ));
                              },
                              text: 'Change',
                              width: 75.w,
                            )               
                          ]
                        ),
                      ),
                    );
                  }
                ),
              ),
              
              //Update Button
              /*Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ConfirmButton(
                  backgroundColor: AppColor.blackColorOp, 
                  textColor: AppColor.whiteColor,
                  text: 'Update',
                  onPressed: () {
                    Get.back();
                    successBottomsheet(
                      context: context,
                      title: 'Update Successful'
                    );
                  },
                ),
              ),*/
          
            ]
          ),
        )
      )
    );
  }
}