import 'dart:developer';
import 'package:dweller/main.dart';
import 'package:dweller/services/controller/main_page/mainpage_controller.dart';
import 'package:dweller/services/controller/search/searchpage_controller.dart';
import 'package:dweller/services/controller/settings/settings_controller.dart';
import 'package:dweller/services/repository/location_service/location_service.dart';
import 'package:dweller/services/repository/settings_service/settings_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/utils/components/range_slider_widget.dart';
import 'package:dweller/utils/constants/google_map_apikey.dart';
import 'package:dweller/view/create_profile/widget/phase_1/textfield.dart';
import 'package:dweller/view/main/mainpage.dart';
import 'package:dweller/view/search/widget/facilities_filter.dart';
import 'package:dweller/view/search/widget/gender_filter.dart';
import 'package:dweller/view/search/widget/header.dart';
import 'package:dweller/view/search/widget/hobbies_filter.dart';
import 'package:dweller/view/search/widget/pets_filter.dart';
import 'package:dweller/view/subscription/widget/subscription_bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';










final SettingService service = Get.put(SettingService());
final SettingsController settingsControl = Get.put(SettingsController());
final LocationService locationService = Get.put(LocationService());
final MainPageController mainController = Get.put(MainPageController());


Future<void> enhancedSearchBottomsheetSeeker({
  required BuildContext context,
  required SearchPageController settingsController,
  }) async{

  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    useSafeArea: true,
    backgroundColor: AppColor.whiteColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.r)
      )
    ),
    context: context, 
    builder: (context) {
      final size = MediaQuery.of(context).size;
      return Wrap(
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.95, //0.75,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: AppColor.whiteColor, //AppColor.whiteColorForSubSheet, //whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 7.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: AppColor.greyColor,
                      borderRadius: BorderRadius.circular(15.r)
                    ),
                  ),
                ), 

                SizedBox(height: 20.h),

                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      size: 24.r,
                      color: AppColor.semiDarkGreyColor,
                      CupertinoIcons.xmark,
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),

                ///Scrollable
                Expanded(
                  child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        
                            Text(
                              'Location',
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.darkPurpleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                            SizedBox(height: size.height * 0.015,),
                            ProfileTextField2(
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
                              hintText: 'Preferred city or state',
                              keyboardType: TextInputType.streetAddress,
                              textInputAction: TextInputAction.next,
                              textController: settingsController.locationController,
                            ),

                            Obx(
                              () {
                                return locationService.suggestionsList.isNotEmpty ? SizedBox(height: size.height * 0.015,) : const SizedBox.shrink();
                              }
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
                                        settingsController.locationController.text = locationService.suggestionsList[index].description;
                                        locationService.placeId.value = locationService.suggestionsList[index].placeId;
                                        log('address: ${settingsController.locationController.text}');
                                        log('placeId: ${locationService.placeId.value}');
                                        locationService.suggestionsList.clear();

                                      },
                                    );
                                  },
                                );
                              }
                            ),

                          
                            SizedBox(height: size.height * 0.02,),
                            Obx(
                              () {
                                return FilterHeader(
                                  leftText: 'Maximum Distance',
                                  rightText: '${settingsController.lowervalueDS.value}km',
                                );
                              }
                            ),
                            SizedBox(height: size.height * 0.015,),
                            SingleRangeSliderWidget(
                              maximumRange: 900,
                              lowervalue: settingsController.lowervalueDS,
                              uppervalue: settingsController.uppervalueDS,
                            ),
                      
                            SizedBox(height: size.height * 0.02,),
                            Obx(
                              () {
                                return FilterHeader(
                                  leftText: 'Age Range',
                                  rightText: '${settingsController.lowervalueAge.value}yrs - ${settingsController.uppervalueAge.value}yrs',
                                );
                              }
                            ),
                            SizedBox(height: size.height * 0.015,),
                            RangeSliderWidget(
                              maximumRange: 40,
                              lowervalue: settingsController.lowervalueAge,
                              uppervalue: settingsController.uppervalueAge,
                            ),
                      
                            
                      
                            SizedBox(height: size.height * 0.02),
                            Text(
                              'Interests and Hobbies',
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.darkPurpleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                            SizedBox(height: size.height * 0.02,),
                            const FilterHobbiesList(),
                      
                            SizedBox(height: size.height * 0.02),
                            Text(
                              'Pets',
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.darkPurpleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                            SizedBox(height: size.height * 0.02,),
                            const FilterPetsList(),
                      
                            SizedBox(height: size.height * 0.02),
                            Text(
                              'Gender',
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.darkPurpleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                            SizedBox(height: size.height * 0.02,),
                            const FilterGenderList(),
                      
                            SizedBox(height: size.height * 0.05),
                      
                            //filter gradient button
                            SizedBox(
                              height: 60.h,
                              width: double.infinity,
                              child: GradientElevatedButton(
                                onPressed: () async{
                                  //call the filter api to filter the users home page
                                  await service.advancedSeacrchForSeekers(
                                    context: context,
                                    address: settingsController.locationController.text,
                                    placeId: locationService.placeId.value,
                                    longitude: locationService.longitudeValue.value,
                                    latitude: locationService.latitudeValue.value,
                                    
                                    minAge: settingsController.lowervalueAge.value.toInt(),
                                    maxAge: settingsController.uppervalueAge.value.toInt(),
                                    
                                    distance: settingsController.lowervalueDS.value.toInt(),
                                    facilities: settingsController.selectedFacilitiesList,
                                    interests: settingsController.selectedMainHobbiesList,
                                    pets: settingsController.selectedPetController.text.isNotEmpty ? [settingsController.selectedPetController.text] : [],
                                    genders: settingsController.selectedGenderList,
                                    onSuccess: () {
                                      //clear all the clearables
                                      locationService.longitudeValue.value = 0.0;
                                      locationService.latitudeValue.value = 0.0;
                                      locationService.placeId.value = '';
                                      settingsController.locationController.clear();
                                      settingsController.selectedPetController.clear();
                                      settingsController.roomsController.clear();
                                      settingsController.selectedFacilitiesList.clear();
                                      settingsController.selectedMainHobbiesList.clear();
                                      settingsController.selectedGenderList.clear();
                                      settingsController.locationController.clear();

                                      Get.back();
                                      mainController.navigateToMainpageAtIndex(page: const MainPage(), index: 0);
                                      showMySnackBar(
                                        context: context, 
                                        message: "filter applied successfully", 
                                        backgroundColor: AppColor.darkPurpleColor
                                      );
                                    },
                                    onFailure: () {
                                      Get.back();
                                      subscriptionBottomsheet(
                                        context: context,
                                        settingsController: settingsControl
                                      );
                                    },
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
                                child: Obx(
                                  () {
                                    return service.isLoading.value 
                                    ? const CircularProgressIndicator.adaptive(
                                      strokeCap: StrokeCap.round,
                                      strokeWidth: 2.0,
                                      backgroundColor: AppColor.whiteColor,
                                    )
                                    : Text(
                                      'Filter',
                                      style: GoogleFonts.bricolageGrotesque(
                                        color: AppColor.whiteColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    );
                                  }
                                )
                              )
                            ),
                      
                            SizedBox(height: 10.h,),  
                        
                      
                          ],
                        ),
                      )
                    
                  
                ), 
               
                
              ],
            ),
          ),
        ],
      );
    }
  );
}

















Future<void> enhancedSearchBottomsheetHost({
  required BuildContext context,
  required SearchPageController settingsController,
  }) async{

  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    useSafeArea: true,
    backgroundColor: AppColor.whiteColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.r)
      )
    ),
    context: context, 
    builder: (context) {
      final size = MediaQuery.of(context).size;
      return Wrap(
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.95, //0.75,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: AppColor.whiteColor, //AppColor.whiteColorForSubSheet, //whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 7.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: AppColor.greyColor,
                      borderRadius: BorderRadius.circular(15.r)
                    ),
                  ),
                ), 

                SizedBox(height: 20.h),

                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      size: 24.r,
                      color: AppColor.semiDarkGreyColor,
                      CupertinoIcons.xmark,
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),

                ///Scrollable
                Expanded(
                  child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        
                            Text(
                              'Location',
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.darkPurpleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                            SizedBox(height: size.height * 0.015,),
                            ProfileTextField2(
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
                              hintText: 'Preferred city or state',
                              keyboardType: TextInputType.streetAddress,
                              textInputAction: TextInputAction.next,
                              textController: settingsController.locationController,
                            ),

                            Obx(
                              () {
                                return locationService.suggestionsList.isNotEmpty ? SizedBox(height: size.height * 0.015,) : const SizedBox.shrink();
                              }
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
                                        settingsController.locationController.text = locationService.suggestionsList[index].description;
                                        locationService.placeId.value = locationService.suggestionsList[index].placeId;
                                        log('address: ${settingsController.locationController.text}');
                                        log('placeId: ${locationService.placeId.value}');
                                        locationService.suggestionsList.clear();

                                      },
                                    );
                                  },
                                );
                              }
                            ),

                            SizedBox(height: size.height * 0.02,),
                            Text(
                              'Number of rooms',
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.darkPurpleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                            SizedBox(height: size.height * 0.015,),
                            ProfileTextField2(
                              onChanged: (p0) {},
                              hintText: 'Preferred no. of rooms',
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              textController: settingsController.roomsController,
                            ),
                      
                            SizedBox(height: size.height * 0.02,),
                            Obx(
                              () {
                                return FilterHeader(
                                  leftText: 'Room Size',
                                  rightText: '${settingsController.lowervalueRM.value}m2 - ${settingsController.uppervalueRM.value}m2',
                                );
                              }
                            ),
                            SizedBox(height: size.height * 0.015,),
                            RangeSliderWidget(
                              maximumRange: 500,
                              lowervalue: settingsController.lowervalueRM,
                              uppervalue: settingsController.uppervalueRM,
                            ),
                      
                            SizedBox(height: size.height * 0.02,),
                            Obx(
                              () {
                                return FilterHeader(
                                  leftText: 'Price',
                                  rightText: '${currency(context).currencySymbol}${settingsController.lowervaluePR.value} - ${currency(context).currencySymbol}${settingsController.uppervaluePR.value}',
                                );
                              }
                            ),
                            SizedBox(height: size.height * 0.015,),
                            RangeSliderWidget(
                              maximumRange: 3000,
                              lowervalue: settingsController.lowervaluePR,
                              uppervalue: settingsController.uppervaluePR,
                            ),
                      
                            SizedBox(height: size.height * 0.02,),
                            Obx(
                              () {
                                return FilterHeader(
                                  leftText: 'Maximum Distance',
                                  rightText: '${settingsController.lowervalueDS.value}km',
                                );
                              }
                            ),
                            SizedBox(height: size.height * 0.015,),
                            SingleRangeSliderWidget(
                              maximumRange: 900,
                              lowervalue: settingsController.lowervalueDS,
                              uppervalue: settingsController.uppervalueDS,
                            ),
                      
                            SizedBox(height: size.height * 0.02,),
                            Obx(
                              () {
                                return FilterHeader(
                                  leftText: 'Age Range',
                                  rightText: '${settingsController.lowervalueAge.value}yrs - ${settingsController.uppervalueAge.value}yrs',
                                );
                              }
                            ),
                            SizedBox(height: size.height * 0.015,),
                            RangeSliderWidget(
                              maximumRange: 40,
                              lowervalue: settingsController.lowervalueAge,
                              uppervalue: settingsController.uppervalueAge,
                            ),
                      
                            SizedBox(height: size.height * 0.015,),
                            Text(
                              'Facilities',
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.darkPurpleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                            SizedBox(height: size.height * 0.02,),
                            const FilterFacilitiesList(),
                      
                            SizedBox(height: size.height * 0.02),
                            Text(
                              'Interests and Hobbies',
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.darkPurpleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                            SizedBox(height: size.height * 0.02,),
                            const FilterHobbiesList(),
                      
                            SizedBox(height: size.height * 0.02),
                            Text(
                              'Pets',
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.darkPurpleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                            SizedBox(height: size.height * 0.02,),
                            const FilterPetsList(),
                      
                            SizedBox(height: size.height * 0.02),
                            Text(
                              'Gender',
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.darkPurpleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                            SizedBox(height: size.height * 0.02,),
                            const FilterGenderList(),
                      
                            SizedBox(height: size.height * 0.05),
                      
                            //filter gradient button
                            SizedBox(
                              height: 60.h,
                              width: double.infinity,
                              child: GradientElevatedButton(
                                onPressed: () async{
                                  //call the filter api to filter the users home page
                                  await service.advancedSeacrch(
                                    context: context,
                                    address: settingsController.locationController.text,
                                    placeId: locationService.placeId.value,
                                    longitude: locationService.longitudeValue.value,
                                    latitude: locationService.latitudeValue.value,
                                    minRoomSize: settingsController.lowervalueRM.value.toInt(),
                                    maxRoomSize: settingsController.uppervalueRM.value.toInt(),
                                    minRent: settingsController.lowervaluePR.value.toInt(),
                                    maxRent: settingsController.uppervaluePR.value.toInt(),
                                    minAge: settingsController.lowervalueAge.value.toInt(),
                                    maxAge: settingsController.uppervalueAge.value.toInt(),
                                    maximumNumberOfRooms: settingsController.roomsController.text.isNotEmpty ? int.parse(settingsController.roomsController.text) : 0,
                                    distance: settingsController.lowervalueDS.value.toInt(),
                                    facilities: settingsController.selectedFacilitiesList,
                                    interests: settingsController.selectedMainHobbiesList,
                                    pets: settingsController.selectedPetController.text.isNotEmpty ? [settingsController.selectedPetController.text] : [],
                                    genders: settingsController.selectedGenderList,
                                    onSuccess: () {
                                      //clear all the clearables
                                      locationService.longitudeValue.value = 0.0;
                                      locationService.latitudeValue.value = 0.0;
                                      locationService.placeId.value = '';
                                      settingsController.locationController.clear();
                                      settingsController.selectedPetController.clear();
                                      settingsController.roomsController.clear();
                                      settingsController.selectedFacilitiesList.clear();
                                      settingsController.selectedMainHobbiesList.clear();
                                      settingsController.selectedGenderList.clear();
                                      settingsController.locationController.clear();

                                      Get.back();
                                      mainController.navigateToMainpageAtIndex(page: const MainPage(), index: 0);
                                      showMySnackBar(
                                        context: context, 
                                        message: "filter applied successfully", 
                                        backgroundColor: AppColor.darkPurpleColor
                                      );
                                    },
                                    onFailure: () {
                                      Get.back();
                                      subscriptionBottomsheet(
                                        context: context,
                                        settingsController: settingsControl
                                      );
                                    },
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
                                child: Obx(
                                  () {
                                    return service.isLoading.value 
                                    ? const CircularProgressIndicator.adaptive(
                                      strokeCap: StrokeCap.round,
                                      strokeWidth: 2.0,
                                      backgroundColor: AppColor.whiteColor,
                                    )
                                    : Text(
                                      'Filter',
                                      style: GoogleFonts.bricolageGrotesque(
                                        color: AppColor.whiteColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    );
                                  }
                                )
                              )
                            ),
                      
                            SizedBox(height: 10.h,),  
                        
                      
                          ],
                        ),
                      )
                    
                  
                ), 
               
                
              ],
            ),
          ),
        ],
      );
    }
  );
}

