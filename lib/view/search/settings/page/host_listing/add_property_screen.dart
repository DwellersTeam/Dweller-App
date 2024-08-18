import 'dart:developer';

import 'package:dweller/model/listing/facility_model.dart';
import 'package:dweller/services/controller/home/listing/listing_controller.dart';
import 'package:dweller/services/repository/create_profile_service/create_profile_service.dart';
import 'package:dweller/services/repository/location_service/location_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_appbar.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/constants/google_map_apikey.dart';
import 'package:dweller/view/create_profile/widget/listing/facilities.dart';
import 'package:dweller/view/create_profile/widget/phase_1/textfield.dart';
import 'package:dweller/view/create_profile/widget/listing/property_image_selector.dart';
import 'package:dweller/view/create_profile/widget/listing/selector_button.dart';
import 'package:dweller/view/create_profile/widget/select_dweller/next_button.dart';
import 'package:dweller/view/search/settings/widget/general/success_sheet_acc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';











//UPLOAD LISTING

class AddListingPage extends StatefulWidget {
  const AddListingPage({super.key});

  @override
  State<AddListingPage> createState() => _AddListingPageState();
}

class _AddListingPageState extends State<AddListingPage> {

  final listingController = Get.put(ListingController());
  final locationService = Get.put(LocationService());
  final profileService = Get.put(CreateProfileService());

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //main body
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Add Property Information",
                              style: GoogleFonts.bricolageGrotesque(
                                  color: AppColor.blackColor,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ])),

                      SizedBox(
                        height: size.height * 0.03,
                      ),

                      //property location
                      Text(
                        "Property location",
                        style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Text(
                        "Your address",
                        style: GoogleFonts.poppins(
                            color: AppColor.semiDarkGreyColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),

                      SizedBox(
                        height: size.height * 0.015,
                      ),

                      ProfileTextField2(
                        onFieldSubmitted: (p0) {
                          locationService.suggestionsList.clear();
                        },
                        onChanged: (val) async {
                          await locationService.fetchPlacesEndpoint(
                              context: context,
                              input: val,
                              apiKey: kGoogleApiKey,
                              suggestions: locationService.suggestionsList);
                        },
                        hintText: '',
                        keyboardType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        textController:
                            listingController.propertyLocationController,
                      ),
                      Obx(() {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: locationService.suggestionsList.length,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return locationService.isLoading.value
                                ? const Loader2()
                                : ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 15.h),
                                    tileColor: AppColor.whiteColor,
                                    enableFeedback: true,
                                    leading: Icon(
                                      size: 24.r,
                                      color: AppColor.darkGreyColor,
                                      CupertinoIcons.placemark,
                                    ),
                                    title: Text(
                                        locationService
                                            .suggestionsList[index].description,
                                        style: GoogleFonts.poppins(
                                            color: AppColor.semiDarkGreyColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400)),
                                    onTap: () {
                                      locationService
                                          .fetchPlaceDetails(
                                              context: context,
                                              placeId: locationService
                                                  .suggestionsList[index]
                                                  .placeId,
                                              apiKey: kGoogleApiKey)
                                          .whenComplete(() {
                                        log('latitude: ${locationService.latitudeValue.value}');
                                        log('longitude: ${locationService.longitudeValue.value}');
                                      });

                                      //set the text controller value
                                      listingController
                                              .propertyLocationController.text =
                                          locationService.suggestionsList[index]
                                              .description;
                                      locationService.placeId.value =
                                          locationService
                                              .suggestionsList[index].placeId;
                                      log('address: ${listingController.propertyLocationController.text}');
                                      log('placeId: ${locationService.placeId.value}');
                                      locationService.suggestionsList.clear();
                                    },
                                  );
                          },
                        );
                      }),

                      SizedBox(
                        height: size.height * 0.04,
                      ),

                      //building type
                      Text(
                        "Building type",
                        style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Text(
                        "What type of building is it?",
                        style: GoogleFonts.poppins(
                            color: AppColor.semiDarkGreyColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),

                      Obx(() {
                        return SelectorButton(
                          buttonColor: AppColor.whiteColor,
                          dropdownOverlay: DropdownButton<String>(
                            style: GoogleFonts.inter(
                                color: AppColor.blackColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),
                            elevation: 1,
                            dropdownColor: AppColor.pureLightGreyColor,
                            underline: const SizedBox(),
                            borderRadius: BorderRadius.circular(10.r),
                            //iconEnabledColor: AppColor.bgColor,
                            icon: const SizedBox(),
                            //iconSize: 20.r,
                            enableFeedback: true,
                            //padding: EdgeInsets.symmetric(horizontal: 10.w),
                            value: listingController
                                .selectedBuildingTypeValue.value,
                            onChanged: (newValue) {
                              // When the user selects an option, update the selectedValue
                              listingController.toggleBuildingType(newValue);
                            },
                            items: listingController.items.map((item) {
                              return DropdownMenuItem(
                                onTap: () {
                                  debugPrint("drop down menu tapped!!");
                                },
                                value: item,
                                child: Text(
                                  item,
                                  style: GoogleFonts.inter(
                                      color: AppColor.blackColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }),
                      SizedBox(
                        height: size.height * 0.04,
                      ),

                      //property size
                      Text(
                        "Property size",
                        style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Text(
                        "What's the size of the property (in m2)?",
                        style: GoogleFonts.poppins(
                            color: AppColor.semiDarkGreyColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),

                      SizedBox(
                        height: size.height * 0.015,
                      ),

                      ProfileTextField2(
                        onChanged: (p0) {},
                        hintText: '',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        textController:
                            listingController.propertySizeController,
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),

                      //apartment rent
                      Text(
                        "Rent",
                        style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Text(
                        "Property rent",
                        style: GoogleFonts.poppins(
                            color: AppColor.semiDarkGreyColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),

                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      ProfileTextField2(
                        onChanged: (p0) {},
                        hintText: '',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        textController: listingController.rentController,
                      ),

                      SizedBox(
                        height: size.height * 0.04,
                      ),

                      //floors
                      Text(
                        "Floors in the building",
                        style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Text(
                        "How many floors are in the building?",
                        style: GoogleFonts.poppins(
                            color: AppColor.semiDarkGreyColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),

                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      ProfileTextField2(
                        onChanged: (p0) {},
                        hintText: '',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        textController: listingController.floorsController,
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),

                      //rooms
                      Text(
                        "Number of rooms",
                        style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Text(
                        "How many rooms are in the apartment?",
                        style: GoogleFonts.poppins(
                            color: AppColor.semiDarkGreyColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),

                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      ProfileTextField2(
                        onChanged: (p0) {},
                        hintText: '',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        textController: listingController.roomsController,
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),

                      //Apartment Facilities
                      Text(
                        "Facilities",
                        style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      //next widget here
                      const PropertyFacilities(),

                      SizedBox(
                        height: size.height * 0.04,
                      ),

                      //upload pictures of the property
                      Text(
                        "Upload pictures of the property",
                        style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ImageButton1(),
                          SizedBox(
                            width: 20.w,
                          ),
                          ImageButton2(),
                          SizedBox(
                            width: 20.w,
                          ),
                          ImageButton3(),
                        ],
                      ),

                      Obx(
                        () {
                          return listingController.isLoading.value ? SizedBox(height: size.height * 0.10,) : const SizedBox.shrink();
                        }
                      ),  

                      Obx(
                        () {
                          return listingController.isLoading.value ? const Loader2() : const SizedBox.shrink();
                        }
                      ), 

                      SizedBox(
                        height: size.height * 0.10,
                      ),

                      //NEXT BUTTON
                      Obx(() {
                        return profileService.isLoadingAdd.value 
                        ? const Loader2()
                        : CustomNextButton(
                          text: 'Upload Listing',
                          textColor: AppColor.whiteColor,
                          buttonColor:
                              listingController.isPropImage3Selected.value
                                  ? AppColor.darkPurpleColor
                                  : AppColor.darkPurpleColor.withOpacity(0.4),
                          onPressed: listingController
                                  .isPropImage3Selected.value
                              ? () async {
                                  await profileService.createPropertyEndpoint(
                                      context: context,
                                      location: {
                                        'address': listingController
                                            .propertyLocationController.text,
                                        'placeId':
                                            locationService.placeId.value,
                                        'longitude': locationService
                                            .longitudeValue.value,
                                        'latitude':
                                            locationService.latitudeValue.value,
                                      },
                                      buildingType: listingController
                                          .selectedBuildingTypeValue.value,
                                      rooms: int.parse(listingController
                                          .roomsController.text),
                                      floors: int.parse(listingController
                                          .floorsController.text),
                                      size: int.parse(listingController
                                          .propertySizeController.text),
                                      rent: int.parse(listingController
                                          .rentController.text),
                                      facilitiesList: listingController
                                          .selectedFacilitiesList
                                          .map((e) => e.name as dynamic)
                                          .toList(),
                                      propertyPicList: [
                                        listingController.propImage1.text,
                                        listingController.propImage2.text,
                                        listingController.propImage3.text,
                                      ],
                                      onSuccess: () {
                                        locationService.longitudeValue.value =
                                            0.0;
                                        locationService.latitudeValue.value =
                                            0.0;
                                        locationService.placeId.value = '';

                                        listingController.propImage1.clear();
                                        listingController.propImage2.clear();
                                        listingController.propImage3.clear();

                                        listingController
                                            .propertyLocationController
                                            .clear();
                                        listingController.roomsController
                                            .clear();
                                        listingController.floorsController
                                            .clear();
                                        listingController.propertySizeController
                                            .clear();
                                        listingController.rentController
                                            .clear();

                                        //Get.back();
                                        successBottomsheet(
                                            context: context,
                                            title:
                                                "You've successfully created your listing");
                                      });
                                }
                              : () {
                                  debugPrint("nothing. select last image");
                                },
                        );
                      }),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
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
