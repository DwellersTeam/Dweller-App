import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dweller/model/location/places.dart';
import 'package:dweller/services/controller/create_profile/create_profile_controller.dart';
import 'package:dweller/services/repository/location_service/location_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/buttons.dart';
import 'package:dweller/utils/components/converters.dart';
import 'package:dweller/utils/components/country_code_widget.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/date_picker.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/constants/google_map_apikey.dart';
import 'package:dweller/view/create_profile/page/phase_3/seeker_phase_3.dart';
import 'package:dweller/view/create_profile/widget/phase_1/textfield.dart';
import 'package:dweller/view/create_profile/widget/select_dweller/next_button.dart';
import 'package:dweller/view/home/widget/notification/notification_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';









class SeekerPhase1Page extends StatefulWidget {
  const SeekerPhase1Page({super.key, required this.firstname, required this.authProvider});
  final String firstname;
  final String authProvider;

  @override
  State<SeekerPhase1Page> createState() => _SeekerPhase1PageState();
}

class _SeekerPhase1PageState extends State<SeekerPhase1Page> {

  final createProfileController = Get.put(CreateProfileController());
  final locationService = Get.put(LocationService());

  @override
  void initState() {
    // TODO: implement initState
    createProfileController.occupationController.addListener(() {
      setState(() {
        createProfileController.isPhase1ButtonEnabledH.value = createProfileController.occupationController.text.isNotEmpty;
      });
    });
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
                value: 0.25, // Value between 0.0 and 1.0 indicating the progress
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
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Let's get through the basics",
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.blackColor,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            
                          ]
                        )
                      ),
                      
                      SizedBox(height: size.height * 0.03,),
                                    
                      Text(
                        "Your birthday",
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.015,),
                      /*ProfileTextField(
                        onChanged: (p0) {},
                        hintText: 'dd/mm/yyyy',
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        textController: createProfileController.birthdayController,
                        icon: CupertinoIcons.calendar_today,
                      ),*/
                      //selectDate //convertDateStringToDate
                      Obx(
                        () {
                          return CustomBorderButton(
                            backgroundColor: AppColor.whiteColor, 
                            height: 65.h, 
                            width: double.infinity, 
                            borderRadiusGeometry: BorderRadius.circular(10.r), 
                            borderColor: AppColor.lightGreyColor,
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                            onPressed: () => selectDate(context: context, selectedDate: createProfileController.birthdayController),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  CupertinoIcons.calendar_today,
                                  size: 24.r,
                                  color: AppColor.darkGreyColor,
                                ),
                                SizedBox(width: 10.w,),
                                Text(
                                  createProfileController.birthdayController.value.isNotEmpty ? createProfileController.birthdayController.value : "dd/mm/yyyy",
                                  style: GoogleFonts.poppins(
                                    color: AppColor.blackColor, 
                                    fontSize: 14.sp, 
                                    fontWeight: FontWeight.w400
                                  ),             
                                ),
                              ],
                            ), 
                          );
                        }
                      ),
                      SizedBox(height: size.height * 0.04,),
                                    
                      Text(
                        "Occupation/Business",
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.015,),
                      ProfileTextField(
                        onChanged: (p0) {
                          createProfileController.occupationController.text = p0;
                          print(createProfileController.occupationController.text);
                        },
                        hintText: 'what do you do?',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textController: createProfileController.occupationController,
                        icon: Icons.timelapse_rounded,
                      ),
                      SizedBox(height: size.height * 0.04,),
        
                      Text(
                        "School",
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.015,),
                      ProfileTextField(
                        onChanged: (p0) {
                          createProfileController.schoolController.text = p0;
                          print(createProfileController.schoolController.text);
                        },
                        hintText: 'where do you school? (optional)',
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        textController: createProfileController.schoolController,
                        icon: Icons.school_rounded,
                      ),
                      widget.authProvider == 'google' ? SizedBox(height: size.height * 0.04,) : const SizedBox.shrink(),
                      
                      //(OPTIONAL)make visible only if user came in from google//
                      widget.authProvider == 'google' ? Text(
                        "Phone number",
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ) : const SizedBox.shrink(),
                      widget.authProvider == 'google' ? SizedBox(height: size.height * 0.015,) : const SizedBox.shrink(),
                      widget.authProvider == 'google' ? ProfilePhoneNumberTextField(
                        onChanged: (p0) {
                          createProfileController.phoneNumberController.text = p0;
                          print(createProfileController.phoneNumberController.text);
                        },
                        hintText: 'your phone number',
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        textController: createProfileController.phoneNumberController,
                        icon: CountryCodeWidget(
                          onCountryChanged: (CountryCode val) {
                            createProfileController.onCountryChange(val);
                          }
                        ) ,
                      ) : const SizedBox.shrink(),
                      SizedBox(height: size.height * 0.04,),
                      /////////////////////////////////////////////////
                      ///
                      Text(
                        "Desired Location",
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.015,),
                      
                      ProfileTextField(
                        onChanged: (val) async{
                          await locationService.fetchPlacesEndpoint(
                            context: context, 
                            input: val, 
                            apiKey: kGoogleApiKey, 
                            suggestions: locationService.suggestionsList
                          );
                        },
                        onFieldSubmitted: (p0) {
                          locationService.suggestionsList.clear();
                        },
                        onTap: () {},
                        hintText: "enter your desired location where you'd like to find a roomie",
                        keyboardType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.done,
                        textController: createProfileController.currentMobileLocationController,
                        icon: CupertinoIcons.placemark_fill,
                      ),

                      SizedBox(height: size.height * 0.015,),   

                      Obx(
                        () {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: locationService.suggestionsList.length,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return locationService.isLoading.value ? const Loader2() : ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r)
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                                tileColor: AppColor.whiteColor,
                                enableFeedback: true,
                                leading: Icon(
                                  size: 24.r,
                                  color: AppColor.darkGreyColor,
                                  CupertinoIcons.placemark,
                                ),
                                title: Text(
                                  locationService.suggestionsList[index].description,
                                  style: GoogleFonts.poppins(
                                    color: AppColor.semiDarkGreyColor, 
                                    fontSize: 14.sp, 
                                    fontWeight: FontWeight.w400
                                  )
                                ),
                                onTap: () {
                                  locationService.fetchPlaceDetails(
                                    context: context,
                                    placeId: locationService.suggestionsList[index].placeId,
                                    apiKey: kGoogleApiKey
                                  ).whenComplete(() {
                                    log('latitude: ${locationService.latitudeValue.value}');
                                    log('longitude: ${locationService.longitudeValue.value}');
                                  });
                                  //set the text controller value
                                  createProfileController.currentMobileLocationController.text = locationService.suggestionsList[index].description;
                                  locationService.placeId.value = locationService.suggestionsList[index].placeId;
                                  log('address: ${createProfileController.currentMobileLocationController.text}');
                                  log('placeId: ${locationService.placeId.value}');
                                  locationService.suggestionsList.clear();

                                },
                              );
                            },
                          );
                        }
                      ),

                      /*TypeAheadField<Prediction>(
  
                        suggestionsCallback: (pattern) async {
                          return await getSuggestions(pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion.description!),
                          );
                        },
                        onSelected: (suggestion) {
                          displayPrediction(suggestion, createProfileController.currentMobileLocationController.text);
                        },
                      ),*/          
                                    
                                    
                                    
                      SizedBox(height: size.height * 0.10,),
                            
                      //NEXT BUTTON
                      Obx(
                        () {
                          return CustomNextButton(
                            text: 'Next',
                            textColor: AppColor.whiteColor,
                            buttonColor: createProfileController.isPhase1ButtonEnabledH.value ? AppColor.darkPurpleColor : AppColor.darkPurpleColor.withOpacity(0.4),
                            onPressed: createProfileController.isPhase1ButtonEnabledH.value ? () {
                              Get.to(() => SeekerPhase3Page(firstname: widget.firstname, authProvider: widget.authProvider,));
                            }
                            : () {
                              print("nothing");
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
          ),
        ),
      ),
    );
  }
}



