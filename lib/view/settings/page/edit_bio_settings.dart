import 'dart:developer';
import 'package:dweller/services/controller/settings/settings_controller.dart';
import 'package:dweller/services/repository/create_profile_service/create_profile_service.dart';
import 'package:dweller/services/repository/location_service/location_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_appbar.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/constants/google_map_apikey.dart';
import 'package:dweller/view/settings/page/profile_type/profile_settings_host.dart';
import 'package:dweller/view/settings/page/profile_type/profile_settings_seeker.dart';
import 'package:dweller/view/settings/widget/general/all_buttons.dart';
import 'package:dweller/view/settings/widget/general/settings_textfield.dart';
import 'package:dweller/view/settings/widget/general/success_sheet_acc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class EditBioSettings extends StatefulWidget {
  const EditBioSettings({super.key, required this.bio, required this.address, required this.job, required this.placeId, required this.longitude, required this.latitude, required this.dwellerKind, required this.onRefresh});
  final String bio;
  final String address;
  final String placeId;
  final num longitude;
  final num latitude;
  final String job;
  final String dwellerKind;
  final VoidCallback onRefresh;

  @override
  State<EditBioSettings> createState() => _EditBioSettingsState();
}

class _EditBioSettingsState extends State<EditBioSettings> {
  
  final controller = Get.put(SettingsController());
  final profileService = Get.put(CreateProfileService());
  final locationService = Get.put(LocationService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: CustomPaint(
          painter: TopRedSectionPainter(),
          child: Obx(
            () {
              return profileService.isLoading.value ? Loader() : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //appbar
                  DwellerAppBar(
                    actionIcon: SvgPicture.asset('assets/svg/settings_icon.svg'),
                  ),
                  
                  SizedBox(height: 20.h,),
              
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //1
                          Text(
                            'Location',
                            style: GoogleFonts.bricolageGrotesque(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          SizedBox(height: 10.h,),
                          SettingsTextfield2(
                            onChanged: (val) async{
                              /*controller.profileLocationController.text = val;
                              log(controller.profileLocationController.text);*/
                              await locationService.fetchPlacesEndpoint(
                                context: context, 
                                input: val, 
                                apiKey: kGoogleApiKey, 
                                suggestions: locationService.suggestionsList
                              );
                            },
                            onFieldSubmitted: (val) {
                              locationService.suggestionsList.clear();
                            },
                            hintText: 'your location',
                            keyboardType: TextInputType.streetAddress,
                            textInputAction: TextInputAction.done,
                            textController: controller.profileLocationController,
                            //initialValue: controller.profileLocationController.text.isNotEmpty ? controller.profileLocationController.text : widget.address,
                          ),
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
              
                                      controller.profileLocationController.text = locationService.suggestionsList[index].description;
                                      locationService.placeId.value = locationService.suggestionsList[index].placeId;
                                      log('address: ${controller.profileLocationController.text}');
                                      log('placeId: ${locationService.placeId.value}');
                                      locationService.suggestionsList.clear();
              
                                    },
                                  );
                                },
                              );
                            }
                          ),
                    
                          SizedBox(height: 30.h,),
              
                          //2
                          Text(
                            'Occupation',
                            style: GoogleFonts.bricolageGrotesque(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          SettingsTextfield (
                            onChanged: (val) {
                              controller.profilejobController.text = val;
                            },
                            onFieldSubmitted: (val) {},
                            hintText: 'your occupation',
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.done,
                            initialValue: widget.job,
                          ),
              
                          SizedBox(height: 30.h,),
                          //3
                          Text(
                            'Biography',
                            style: GoogleFonts.bricolageGrotesque(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          SettingsTextfield (
                            onChanged: (val) {
                              controller.profilebioController.text = val;
                            },
                            onFieldSubmitted: (val) {},
                            hintText: 'biography',
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.done,
                            initialValue: widget.bio,
                          ),
              
                          SizedBox(height: MediaQuery.of(context).size.height * 0.30,),
                        
                          ConfirmButton(
                            backgroundColor: AppColor.blackColorOp, 
                            textColor: AppColor.whiteColor,
                            text: 'Save Changes',
                            onPressed: () {
                              profileService.updateBioEndpoint(
                                context: context, 
                                location: {
                                  'address': controller.profileLocationController.text.isNotEmpty ? controller.profileLocationController.text : widget.address, 
                                  'placeId': locationService.placeId.value.isNotEmpty ? locationService.placeId.value  : widget.placeId,
                                  'longitude': locationService.longitudeValue.value != 0.0 ? locationService.longitudeValue.value : widget.longitude,
                                  'latitude': locationService.latitudeValue.value != 0.0 ? locationService.latitudeValue.value : widget.latitude,
                                },
                                job: controller.profilejobController.text.isNotEmpty ? controller.profilejobController.text : widget.job, 
                                bio: controller.profilebioController.text.isNotEmpty ? controller.profilebioController.text : widget.bio, 
                                onSuccess: () {
                                  locationService.longitudeValue.value = 0.0;
                                  locationService.latitudeValue.value = 0.0;
                                  locationService.placeId.value = '';
                                  controller.profileLocationController.clear();
                                  controller.profilebioController.clear();
                                  controller.profilejobController.clear();
                                  //call the refresh function
                                  widget.onRefresh();
                                  Get.back();
                                  successBottomsheet(
                                    context: context,
                                    title: 'Update Successful'
                                  );
    
                                }
                              );
                              
                            },
                          ),     

                          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                  
                        ]
                      ),
                    ),
                  ),
                  
              
                ]
              );
            }
          ),
        )
      )
    );
  }
}