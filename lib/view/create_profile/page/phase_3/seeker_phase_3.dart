import 'package:dweller/services/controller/create_profile/create_profile_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/view/create_profile/page/phase_4/seeker_phase_4.dart';
import 'package:dweller/view/create_profile/widget/phase_1/textfield.dart';
import 'package:dweller/view/create_profile/widget/phase_3/alcohol_intake_list.dart';
import 'package:dweller/view/create_profile/widget/phase_3/guest_intake_list.dart';
import 'package:dweller/view/create_profile/widget/phase_3/livelihood_list.dart';
import 'package:dweller/view/create_profile/widget/phase_3/main_hobbies_list.dart';
import 'package:dweller/view/create_profile/widget/phase_3/noise_level_list.dart';
import 'package:dweller/view/create_profile/widget/phase_3/pet_list.dart';
import 'package:dweller/view/create_profile/widget/phase_3/sexual_orientation_list.dart';
import 'package:dweller/view/create_profile/widget/phase_3/sleep_schedule_list.dart';
import 'package:dweller/view/create_profile/widget/phase_3/work_study_schedule_list.dart';
import 'package:dweller/view/create_profile/widget/phase_3/zodiac_sign_list.dart';
import 'package:dweller/view/create_profile/widget/select_dweller/next_button.dart';
import 'package:dweller/view/home/widget/notification/notification_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class SeekerPhase3Page extends StatelessWidget {
  SeekerPhase3Page({super.key, required this.firstname, required this.authProvider});
  final String firstname;
  final String authProvider;

  final createProfileController = Get.put(CreateProfileController());

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
                        getFirstLetter(firstname),
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            
              SizedBox(height: size.height * 0.04,),
        
              LinearProgressIndicator(
                backgroundColor: AppColor.blueColor.withOpacity(0.3), // Background color of the progress indicator
                valueColor: const AlwaysStoppedAnimation<Color>(AppColor.purpleColor), // Color of the progress indicator
                value: 0.50, // Value between 0.0 and 1.0 indicating the progress
                minHeight: 2.5,
                borderRadius: BorderRadius.horizontal(right: Radius.circular(10.r)),
              ),
        
              SizedBox(height: size.height * 0.025,),
              
              //main body
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.025,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Lifestyle and Hobbies",
                                style: GoogleFonts.bricolageGrotesque(
                                  color: AppColor.blackColor,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              
                            ]
                          )
                        ),
                      ),
                      
                      SizedBox(height: size.height * 0.03,),
                      
                      //Livelihood
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                        child: Text(
                          "Livelihood",
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),               
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                        child: Text(
                          "select all that apply",
                          style: GoogleFonts.poppins(
                            color: AppColor.semiDarkGreyColor,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
        
                      SizedBox(height: size.height * 0.015,),
                      //Horizontal List
                      const LivelihoodList(),
                      SizedBox(height: size.height * 0.04,),
                      Obx(
                        () {
                          return createProfileController.showMoreLivelihood.value ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                            child: ProfileTextField(
                              icon: Icons.more_horiz_rounded,
                              onChanged: (val) {}, 
                              hintText: 'Type it here', 
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next, 
                              textController: createProfileController.moreLivelihoodController 
                            ),
                          )
                          : const SizedBox();
                        }
                      ),
                      SizedBox(height: size.height * 0.025,),
        
                      //main hobbies and interest
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                        child: Text(
                          "What are your main hobbies and interests?",
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),
                      const MainHobbiesList(),
                      SizedBox(height: size.height * 0.065,),
        
                      //noise level
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                        child: Text(
                          "What level of noise do you prefer in your living environment?",
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),
                      const NoiseLevelList(),
                      SizedBox(height: size.height * 0.065,),

                      //Zodiac sign
                      /*Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                        child: Text(
                          "Zodiac Sign",
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),
                      const ZodiacSignList(),
                      SizedBox(height: size.height * 0.065,),*/
        
                      //sexual orientation
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                        child: Text(
                          "Sexual Orientation",
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),
                      const SexualOrientationList(),
                      SizedBox(height: size.height * 0.025,),
                      Obx(
                        () {
                          return createProfileController.showMoreSexualOrientation.value ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                            child: ProfileTextField(
                              icon: Icons.more_horiz_rounded,
                              onChanged: (val) {}, 
                              hintText: 'Type it here', 
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next, 
                              textController: createProfileController.moreSexualOrientationController 
                            ),
                          )
                          : const SizedBox();
                        }
                      ),
                      SizedBox(height: size.height * 0.035,),
        
                      //alcohol intake
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                        child: Text(
                          "How often do you drink alcohol?",
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),
                      const AlcoholIntakeList(),
                      SizedBox(height: size.height * 0.065,),
        
                      //Pets
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                        child: Text(
                          "Pets?",
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),               
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                        child: Text(
                          "select all that apply",
                          style: GoogleFonts.poppins(
                            color: AppColor.semiDarkGreyColor,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.015,),
                      //Pets List
                      const PetsList(),
                      SizedBox(height: size.height * 0.025,),
                      Obx(
                        () {
                          return createProfileController.showMorePets.value
                          ?Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                            child: ProfileTextField(
                              icon: Icons.more_horiz_rounded,
                              onChanged: (val) {}, 
                              hintText: 'Type it here', 
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next, 
                              textController: createProfileController.morePetsController 
                            ),
                          )
                          : const SizedBox();
                        }
                      ),
                      SizedBox(height: size.height * 0.035,),
        
                      //preferred sleepschedule
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                        child: Text(
                          "What is your preferred sleep schedule?",
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),
                      const SleepScheduleList(),
                      SizedBox(height: size.height * 0.065,),
        
                      //preferred sleepschedule
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                        child: Text(
                          "What is your typical work or study schedule?",
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),
                      const WorkScheduleList(),
                      SizedBox(height: size.height * 0.065,),
        
                      //preferred sleepschedule
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                        child: Text(
                          "How often do you like to have guests over?",
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),
                      const GuestIntakeList(),
                      
                                    
                      SizedBox(height: size.height * 0.10,),
                            
                      //NEXT BUTTON
                      Obx(
                        () {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                            child: CustomNextButton(
                              text: 'Next',
                              textColor: AppColor.whiteColor,
                              buttonColor: createProfileController.showNextBotton.value ? AppColor.darkPurpleColor : AppColor.darkPurpleColor.withOpacity(0.4),
                              onPressed: createProfileController.showNextBotton.value ?
                              () {
                                Get.to(()=> SeekerPhase4Page(firstname: firstname, authProvider: authProvider,));
                              }
                              :() {
                                debugPrint("nothing");
                              },
                            ),
                          );
                        }
                      ),
                      SizedBox(height: size.height * 0.03,),
                             
                    ],
                  ),
                ),
              ), 
         
            ],
          ),
        ),
      ),
    );
  }
}