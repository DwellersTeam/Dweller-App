import 'package:dweller/services/controller/create_profile/create_profile_controller.dart';
import 'package:dweller/services/repository/create_profile_service/create_profile_service.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/services/repository/location_service/location_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/view/create_profile/page/phase_5/seeker_phase_5.dart';
import 'package:dweller/view/create_profile/widget/phase_4/about_textfield.dart';
import 'package:dweller/view/create_profile/widget/phase_4/photo_bottomsheet.dart';
import 'package:dweller/view/create_profile/widget/phase_4/profile_image_selector.dart';
import 'package:dweller/view/create_profile/widget/phase_4/upload_profile_pic.dart';
import 'package:dweller/view/create_profile/widget/select_dweller/next_button.dart';
import 'package:dweller/view/home/widget/notification/notification_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class SeekerPhase4Page  extends StatefulWidget {
  const SeekerPhase4Page({super.key, required this.firstname, required this.authProvider});
  final String firstname;
  final String authProvider;

  @override
  State<SeekerPhase4Page> createState() => _SeekerPhase4PageState();
}

class _SeekerPhase4PageState extends State<SeekerPhase4Page> {

  final createProfileController = Get.put(CreateProfileController());
  final service = Get.put(CreateProfileService());
  final locationService = Get.put(LocationService());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: CustomPaint(
          painter: TopRedSectionPainter(),
          child: Obx(
            () {
              return service.isLoading.value ? const Loader() : Column(
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
                            getFirstLetter(widget.firstname),
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
                    value: 0.75, // Value between 0.0 and 1.0 indicating the progress
                    minHeight: 2.5,
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(10.r)),
                  ),
                
                  SizedBox(height: size.height * 0.025,),
                  
                  //main body
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.025,),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Looking good! Now let's enhance your profile",
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
                          Text(
                            "Upload a profile picture",
                            style: GoogleFonts.poppins(
                              color: AppColor.blackColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: size.height * 0.02,),
                          ProfileAvatar(
                            onCameraTapped: () {
                              uploadPhotoBottomsheet(context: context, service: createProfileController);
                            },
                          ),
                
                          SizedBox(height: size.height * 0.05,),
                          Text(
                            "Add a Bio",
                            style: GoogleFonts.poppins(
                              color: AppColor.blackColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: size.height * 0.02,),
                          Text(
                            "What would you like your potential roommates to know about you?",
                            style: GoogleFonts.poppins(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: size.height * 0.02,),
                          AboutTextField(
                            onChanged: (val) {},
                            hintText: '',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            textController: createProfileController.aboutUserController,
                            icon: Icons.edit,
                          ),
                
                          SizedBox(height: size.height * 0.05,),
                          Text(
                            "Your display pictures",
                            style: GoogleFonts.poppins(
                              color: AppColor.blackColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: size.height * 0.02,),
                          Text(
                            "These are the pictures people will see when swiping right/left.",
                            style: GoogleFonts.poppins(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: size.height * 0.02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ImageSelector1(),
                              SizedBox(width: 20.w,),
                              ImageSelector2(),
                            ],
                          ),
                                  
                                        
                          SizedBox(height: size.height * 0.02,),

                          Obx(
                            () {
                              return createProfileController.isCloudinaryImageLoading.value ? const Loader2() : const SizedBox.shrink();
                            },
                          ),

                          SizedBox(height: size.height * 0.10,),
                                
                          //NEXT BUTTON
                          Obx(
                            () {
                              return CustomNextButton(
                                text: 'Next',
                                textColor: AppColor.whiteColor,
                                buttonColor: createProfileController.isSubImage2Selected.value ? AppColor.darkPurpleColor : AppColor.darkPurpleColor.withOpacity(0.4),
                                onPressed: createProfileController.isSubImage2Selected.value 
                                ? () {
                                  if(createProfileController.displayPicturesList.isNotEmpty && createProfileController.isCloudinaryImageLoading.value == false) {  
                                    service.addToMap(
                                      noiseLevel: createProfileController.selectedNoiseLevelController.text, 
                                      smoke: 'nil', 
                                      alchohol: createProfileController.selectedAlcoholIntakeController.text, 
                                      sleepSchedule: createProfileController.selectedSleepScheduleController.text, 
                                      workStudySchedule: createProfileController.selectedWorkScheduleController.text, 
                                      visitors: createProfileController.selectedGuestIntakeController.text, 
                                      interests: createProfileController.selectedMainHobbiesList, 
                                      pets: createProfileController.overallPets,
                                      livelihood: createProfileController.overallLivelihood,
                                    ).whenComplete((){
                                      service.updateUserEndpoint(
                                        context: context, 
                                        gender: createProfileController.selectedSexualOrientationController.text == 'More' ? createProfileController.moreSexualOrientationController.text : createProfileController.selectedSexualOrientationController.text, 
                                        dateOfBirth: createProfileController.birthdayController.value, 
                                        dwellerKind: createProfileController.selectedDwellerType.text.toLowerCase(), 
                                        bio: createProfileController.aboutUserController.text, 
                                        preferences: service.myPreferenceMap,
                                        job: createProfileController.occupationController.text, 
                                        school: createProfileController.schoolController.text, 
                                        kyc_doc_type: '', 
                                        kyc_doc_url: '', 
                                        display_picture: createProfileController.imageUrlController.text, 
                                        pictures: createProfileController.displayPicturesList, 
                                        //location: createProfileController.currentMobileLocationController.text, 
                                        location: {
                                          'address': createProfileController.currentMobileLocationController.text,
                                          'placeId': locationService.placeId.value,
                                          'longitude': locationService.longitudeValue.value,
                                          'latitude': locationService.latitudeValue.value,
                                        },
                                      
                                      phoneNumber: "${createProfileController.phone_code.value} ${createProfileController.phoneNumberController.text}",
                                      authProvider: widget.authProvider,
                                      //clear all controllers and navigate to the next page
                                      onSuccess: () {
                                        LocalStorage.saveDwellerType(createProfileController.selectedDwellerType.text.toLowerCase());
                                        createProfileController.birthdayController.value = '';
                                        createProfileController.selectedSexualOrientationController.clear();
                                        createProfileController.moreSexualOrientationController.clear();
                                        createProfileController.selectedDwellerType.clear();
                                        createProfileController.aboutUserController.clear();
                                        createProfileController.selectedNoiseLevelController.clear();
                                        createProfileController.selectedAlcoholIntakeController.clear();
                                        createProfileController.selectedSleepScheduleController.clear();
                                        createProfileController.selectedWorkScheduleController.clear();
                                        createProfileController.selectedGuestIntakeController.clear(); 
                                        createProfileController.occupationController.clear();
                                        createProfileController.schoolController.clear();
                                        //createProfileController.imageUrlController.clear();
                                        createProfileController.selectedLivelihoodController.clear();
                                        createProfileController.moreLivelihoodController.clear();
                                        createProfileController.displayPicturesList.clear();
                                        createProfileController.currentMobileLocationController.clear();
                                        createProfileController.selectedMainHobbiesList.clear();
                                        createProfileController.selectedPetsController.clear();
                                        createProfileController.morePetsController.clear();
                                        createProfileController.firstSubImageController.clear();
                                        createProfileController.secondSubImageController.clear();
              
                                          createProfileController.phoneNumberController.clear();
                                          
                                          Get.offAll(() => SeekerPhase5Page(firstname: widget.firstname,));
                                        },
                                      );
                                    });

                                  }
                                  else{
                                    showMessagePopup(
                                      title: 'Uh oh', 
                                      message: 'please upload both display pictures and wait for processing', 
                                      buttonText: 'Okay', 
                                      context: context
                                    );
                                  }
                                      
                                }
                                : () {
                                  debugPrint("nothing. select last image");
                                },
                              );
                            }
                          ),

                          SizedBox(height: size.height * 0.02,),
                                 
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



