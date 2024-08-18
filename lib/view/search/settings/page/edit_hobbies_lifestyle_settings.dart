import 'package:dweller/services/controller/create_profile/create_profile_controller.dart';
import 'package:dweller/services/repository/create_profile_service/create_profile_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/create_profile/widget/phase_1/textfield.dart';
import 'package:dweller/view/create_profile/widget/phase_3/alcohol_intake_list.dart';
import 'package:dweller/view/create_profile/widget/phase_3/guest_intake_list.dart';
import 'package:dweller/view/create_profile/widget/phase_3/livelihood_list.dart';
import 'package:dweller/view/create_profile/widget/phase_3/main_hobbies_list.dart';
import 'package:dweller/view/create_profile/widget/phase_3/noise_level_list.dart';
import 'package:dweller/view/create_profile/widget/phase_3/pet_list.dart';
import 'package:dweller/view/create_profile/widget/phase_3/sleep_schedule_list.dart';
import 'package:dweller/view/create_profile/widget/phase_3/work_study_schedule_list.dart';
import 'package:dweller/view/create_profile/widget/select_dweller/next_button.dart';
import 'package:dweller/view/search/settings/widget/general/success_sheet_acc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class EditLifestylePage extends StatelessWidget {
  EditLifestylePage({super.key, 
  //required this.job, 
  required this.noiseLevel, 
  required this.alcohol, 
  required this.smoke, 
  required this.sleepSchedule, 
  required this.workSchedule, 
  required this.visitors, 
  required this.pets, 
  required this.interests, 
  required this.livelihood, required this.onRefresh,
  });
  //final String job;
  final String noiseLevel;
  final String alcohol;
  final String smoke;
  final String sleepSchedule;
  final String workSchedule;
  final String visitors;
  final List<dynamic> pets;
  final List<dynamic> interests;
  final List<dynamic> livelihood;
  final VoidCallback onRefresh;

  final createProfileController = Get.put(CreateProfileController());
  final profileService = Get.put(CreateProfileService());

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
          child: Obx(
            () {
              return profileService.isLoading.value ? const Loader() : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),    
                  //HEADER
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              CupertinoIcons.placemark_fill,
                              //Icons.location_pin,
                              color: AppColor.blackColor,
                              size: 30.r,
                            ),
                            SizedBox(width: 5.w,),
                            Text(
                              'Tallin, Estonia',
                              style: GoogleFonts.poppins(
                                color: AppColor.blackColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),*/
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset("assets/svg/arrow_back.svg")
                        ),
                        InkWell(
                          onTap: () {},
                          child: SvgPicture.asset('assets/svg/settings_icon.svg')
                        ),
                      ],
                    ),
                  ),
                
                  SizedBox(height: size.height * 0.04,),
                  
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
                                    text: "Edit Lifestyle and Hobbies",
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
                          /*Padding(
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
                          SizedBox(height: size.height * 0.035,),*/
                      
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
                                  text: 'Save Changes',
                                  textColor: AppColor.whiteColor,
                                  buttonColor: createProfileController.showNextBotton.value ? AppColor.darkPurpleColor : AppColor.darkPurpleColor.withOpacity(0.4),
                                  onPressed: createProfileController.showNextBotton.value ?
                                  () {
                                    profileService.updateUserPreferenceEndpoint(
                                      context: context, 
                                      //job: createProfileController.selectedLivelihoodController.text.isEmpty ? job : createProfileController.selectedLivelihoodController.text == 'More' ? createProfileController.moreLivelihoodController.text : createProfileController.selectedLivelihoodController.text,
                                      noiseLevel: createProfileController.selectedNoiseLevelController.text.isNotEmpty ? createProfileController.selectedNoiseLevelController.text : noiseLevel, 
                                      smoke: smoke, 
                                      alchohol: createProfileController.selectedAlcoholIntakeController.text.isNotEmpty ? createProfileController.selectedAlcoholIntakeController.text : alcohol, 
                                      sleepSchedule: createProfileController.selectedSleepScheduleController.text.isNotEmpty ? createProfileController.selectedSleepScheduleController.text : sleepSchedule, 
                                      workStudySchedule: createProfileController.selectedWorkScheduleController.text.isNotEmpty ? createProfileController.selectedWorkScheduleController.text : workSchedule, 
                                      visitors: createProfileController.selectedGuestIntakeController.text.isNotEmpty ? createProfileController.selectedGuestIntakeController.text : visitors, 
                                      interests: createProfileController.selectedMainHobbiesList.isEmpty ? interests : createProfileController.selectedMainHobbiesList, 
                                      pets: createProfileController.selectedPetsController.text.isEmpty ? pets : createProfileController.selectedPetsController.text == 'More' ? [createProfileController.morePetsController.text] : [createProfileController.selectedPetsController.text],
                                      livelihood: createProfileController.selectedLivelihoodController.text.isEmpty ?  livelihood : createProfileController.selectedLivelihoodController.text == 'More' ? [createProfileController.moreLivelihoodController.text] : [createProfileController.selectedLivelihoodController.text],
                                      onSuccess: () {
                                        createProfileController.selectedLivelihoodController.clear();
                                        createProfileController.moreLivelihoodController.clear();
                                        createProfileController.selectedNoiseLevelController.clear();
                                        createProfileController.selectedAlcoholIntakeController.clear();
                                        createProfileController.selectedSleepScheduleController.clear();
                                        createProfileController.selectedWorkScheduleController.clear();
                                        createProfileController.selectedGuestIntakeController.clear();
                                        createProfileController.selectedMainHobbiesList.clear();
                                        createProfileController.selectedPetsController.clear();
                                        createProfileController.morePetsController.clear();
                          
                                        //call the refresh function
                                        onRefresh();
                                        Get.back();
                                        successBottomsheet(
                                          context: context,
                                          title: 'Update Successful'
                                        );
                                      }
                                    );
                                    
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
              );
            }
          ),
        ),
      ),
    );
  }
}