import 'dart:developer';

import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/services/controller/main_page/mainpage_controller.dart';
import 'package:dweller/services/repository/create_profile_service/create_profile_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/view/create_profile/page/intro/select_dweller_type.dart';
import 'package:dweller/view/create_profile/widget/welcome_page/elevated_button.dart';
import 'package:dweller/view/create_profile/widget/welcome_page/text_button.dart';
import 'package:dweller/view/home/widget/notification/notification_sheet.dart';
import 'package:dweller/view/main/mainpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  
  final MainPageController controller = Get.put(MainPageController());
  final CreateProfileService profileService = Get.put(CreateProfileService());
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: CustomPaint(
          painter: RedSectionPainter(),
          //WRAP WITH FUTURE BUILDER
          child: FutureBuilder<UserModel>(
            future: profileService.getCurrentUserEndpoint(context),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Loader();
              }
              if(snapshot.hasError) {
                log('snapshot err: ${snapshot.error}');
                return Center(
                  child: Text(
                    'something went wrong',
                    style: GoogleFonts.poppins(
                      color: AppColor.darkPurpleColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                );
              }
              if(!snapshot.hasData) {
                log('snapshot data: ${snapshot.error}');
                return Center(
                  child: Text(
                    'no data found',
                    style: GoogleFonts.poppins(
                      color: AppColor.darkPurpleColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                );
              }

              final data = snapshot.data!;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h,),    
                    //HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      
                        InkWell(
                          onTap: () {
                            notificationBottomsheet(context: context);  
                          },
                          child: SvgPicture.asset('assets/svg/noti_icon.svg')
                        ),
                        CircleAvatar(
                          radius: 24.r,
                          backgroundColor: Colors.grey.withOpacity(0.1),
                          //backgroundImage: const AssetImage("assets/images/lionel.jpg"),
                          child: Text(
                            getFirstLetter(data.firstname,),
                            style: GoogleFonts.poppins(
                              color: AppColor.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ],
                    ),
                  
                    SizedBox(height: size.height * 0.12,),
                  
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Hello there ${data.firstname} ",
                            style: GoogleFonts.bricolageGrotesque(
                              color: AppColor.darkPurpleColor,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          TextSpan(
                            text: "👋 ",
                            style: GoogleFonts.bricolageGrotesque(
                              color: AppColor.darkPurpleColor,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          TextSpan(
                            text: "\nWelcome to Dweller",
                            style: GoogleFonts.bricolageGrotesque(
                              color: AppColor.darkPurpleColor,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ]
                      )
                    ),
                    //Stacked Avatar List,
                    SizedBox(height: size.height * 0.03,),
                    Image.asset('assets/images/dwellers.png'),
                    SizedBox(height: size.height * 0.03,),
                      
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'The perfect roomate for you is just a few ',
                            style: GoogleFonts.poppins(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          TextSpan(
                            text: 'swipes away',
                            style: GoogleFonts.poppins(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                              
                        ]
                      )
                    ),
                      
                    SizedBox(height: size.height * 0.05,),
                        
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "It's time to set up your profile",
                            style: GoogleFonts.bricolageGrotesque(
                              color: AppColor.blackColor,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                              
                        ]
              
                      )
                    ),
                      
                    SizedBox(height: size.height * 0.05,),
                    CustomElevatedButton(
                      buttonColor: AppColor.darkPurpleColor,
                      textColor: AppColor.whiteColor,
                      text: 'Go!',
                      onPressed: () {
                        Get.offAll(() => SelectDwellerPage(
                          firstname: data.firstname, 
                          authProvider: data.authProvider,
                        ));
                      },
                    ),
                    SizedBox(height: size.height * 0.02,),
                    CustomTextButton(
                      onPressed: () {
                        if(data.dwellerKind.isEmpty || data.dwellerKind == null) {
                          showMessagePopup(
                            title: 'Uh oh', 
                            message: 'please set up your profile so we can know the type of Dweller you are', 
                            buttonText: 'Okay', 
                          );
                        }
                        else{
                          Get.offAll(() => MainPage());
                        }
                        //controller.navigateToMainpageAtIndex(index: 3, mainpage: MainPage());
                      }, 
                      text: "View Dwellers", 
                      textColor: AppColor.semiDarkGreyColor
                    )
                        
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}



