import 'dart:developer';

import 'package:dweller/model/profile/jwt_response.dart';
import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/services/controller/search/searchpage_controller.dart';
import 'package:dweller/services/repository/create_profile_service/create_profile_service.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/components/shader_mask_text.dart';
import 'package:dweller/utils/invention/use_stripe_for_subscription.dart';
import 'package:dweller/view/home/widget/notification/notification_sheet.dart';
import 'package:dweller/view/search/widget/filter_bottomsheet.dart';
import 'package:dweller/view/search/widget/search_field.dart';
import 'package:dweller/view/settings/page/profile_type/profile_settings_host.dart';
import 'package:dweller/view/settings/page/profile_type/profile_settings_seeker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';







class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final controller = Get.put(SearchPageController());
  
  final profileService = Get.put(CreateProfileService());

  final subscriptionService = StripeSubscriptionClass();

  //get dweller kind
  final String dwellerKind = LocalStorage.getDwellerType();


  late Future<JwtModel> profileFuture;

  @override
  void initState() {
    profileFuture = _refresh();
    super.initState();
  }


  //REFRESH FUNCTIONALITY
  Future<JwtModel> _refresh() async{
    await Future.delayed(const Duration(seconds: 2));
    final profileFuture = await profileService.fetchUserDetailFromJWT(context);
    return profileFuture;
  }


  Future<void> _handleRefresh() async{
    setState(() {
      profileFuture = _refresh();
    });
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        //wrap with profile GET request FutureBuilder
        child: CustomPaint(
          painter: TopRedSectionPainter(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h,),    
              //HEADER
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => notificationBottomsheet(context: context),    
                      child: SvgPicture.asset('assets/svg/noti_icon.svg')
                    ),


                    FutureBuilder<JwtModel>(
                      future: profileFuture,
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            //backgroundImage: const AssetImage("assets/images/lionel.jpg"),
                            //child: LoaderS()
                          );
                        }
                        if(snapshot.hasError){
                          log("snapshot err: ${snapshot.error}");
                          return CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            //backgroundImage: const AssetImage("assets/images/lionel.jpg"),
                            //child: LoaderS()
                          );
                        }
                        if(!snapshot.hasData) {
                          log("snapshot err: ${snapshot.error}");
                          return CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            //backgroundImage: const AssetImage("assets/images/lionel.jpg"),
                            //child: LoaderS()
                          );
                        }
                        final data = snapshot.data!;
                        return InkWell(
                          onTap: () {
                            if(data.dwellerKind == 'seeker') {
                              Get.to(() => ProfileSettingSeeker(
                                context: context,
                              ));
                            }
                            else {
                              Get.to(() => ProfilePageHost(
                                property: data.property,
                                userId: data.id,
                              ));
                            }
                          },
                          child: data.displayPicture.isEmpty ? CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            //backgroundImage: const AssetImage("assets/images/lionel.jpg"),
                            child: Text(
                              getFirstLetter(data.firstname),
                              style: GoogleFonts.poppins(
                                color: AppColor.blackColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          )
                          :CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            backgroundImage: NetworkImage(data.displayPicture),
                          ),
                        );
                      }
                    ),


                  ],
                ),
              ),
            
              SizedBox(height: size.height * 0.01,),
                  
              //main body(wrap with Swipes GET Futurebuilder)
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GradientText(
                          text: 'Enhanced Search',
                          style: GoogleFonts.bricolageGrotesque(
                            color: AppColor.blackColor,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          gradient: const LinearGradient(
                            colors: [
                             AppColor.blueColorGradient2,
                              AppColor.blueColorGradient1,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                      SvgPicture.asset(
                        'assets/svg/enhanced_filter.svg',
                        height: 250.h, //MediaQuery.of(context).size.height * 0.25,
                        //width:  250.w
                      ),
                      SizedBox(height: 20.h,),
                      Text(
                        'Find the perfect Dweller with ease',
                        style: GoogleFonts.bricolageGrotesque(
                          color: AppColor.darkPurpleColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Text(
                          'precise searching, limitless dwellers',
                          style: GoogleFonts.poppins(
                            color: AppColor.darkPurpleColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                      //button
                      SizedBox(
                        height: 60.h,
                        width: double.infinity,
                        child: GradientElevatedButton(
                          onPressed: () {
                            //check if user is on dweller pro before allowance
                            //check if the user is on dweller pro before showing the appropriate bottomsheet
                            dwellerKind == 'seeker'
                            ?enhancedSearchBottomsheetHost(
                              context: context,
                              settingsController: controller,
                              subscriptionService: subscriptionService
                            )
                            :enhancedSearchBottomsheetSeeker(
                              context: context,
                              settingsController: controller,
                              subscriptionService: subscriptionService
                            );
                          },
                          style: GradientElevatedButton.styleFrom(
                            gradient: const LinearGradient(
                              colors: [
                              AppColor.blueColorGradient2,
                              AppColor.blueColorGradient1,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Text(
                            'Input filters',
                            style: GoogleFonts.bricolageGrotesque(
                              color: AppColor.whiteColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          )
                        )
                      ),
                    
                    ],
                  )
                ),
              ), 
                   
            ],
          ),
        ),
      ),
    );
  }
}