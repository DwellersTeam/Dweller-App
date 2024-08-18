import 'dart:developer';
import 'package:dweller/model/listing/property_model.dart';
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








//EDIT LISTING
class EditListingPage extends StatefulWidget {
  const EditListingPage({super.key, required this.model, required this.onRefresh});
  final PropertyModel model;
  final VoidCallback onRefresh;
  

  @override
  State<EditListingPage> createState() => _EditListingPageState();
}

class _EditListingPageState extends State<EditListingPage> {



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
              //SizedBox(height: 20.h,),    
              //appbar
              DwellerAppBar(
                actionIcon: SvgPicture.asset('assets/svg/settings_icon.svg'),
              ),
            
              SizedBox(height: size.height * 0.01,),
              
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
                              text: "Edit Property Information",
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
                      
                      //property location
                      Text(
                        "Property location",
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),               
                      Text(
                        "Your address",
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
        
                      SizedBox(height: size.height * 0.015,),
                      ProfileTextField2(
                        onChanged: (p0) async{
                          //listingController.propertyLocationControllerEdit.text = p0;
                          await locationService.fetchPlacesEndpoint(
                            context: context,
                            input: p0,
                            apiKey: kGoogleApiKey,
                            suggestions: locationService.suggestionsList
                          );
                        },
                        hintText: '',
                        keyboardType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        //initialValue: '10 Abimbola Cole, Ikoyi Lagos',
                        onFieldSubmitted: (p0) {
                          locationService.suggestionsList.clear();
                        },
                        textController: listingController.propertyLocationControllerEdit,
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
                                  listingController.propertyLocationControllerEdit.text = locationService.suggestionsList[index].description;
                                  locationService.placeId.value = locationService.suggestionsList[index].placeId;
                                  log('address: ${listingController.propertyLocationControllerEdit.text}');
                                  log('placeId: ${locationService.placeId.value}');
                                  locationService.suggestionsList.clear();
              
                                },
                              );
                            },
                          );
                        }
                      ),

                      SizedBox(height: size.height * 0.04,),
        
                      //building type      
                      Text(
                        "Building type",
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),
                                        
                      Obx(
                        () {
                          return SelectorButton(
                            buttonColor: AppColor.whiteColor,
                            dropdownOverlay: DropdownButton<String>(
                              style: GoogleFonts.inter(
                                color: AppColor.blackColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500
                              ),
                              elevation: 1,
                              dropdownColor: AppColor.pureLightGreyColor,
                              underline: const SizedBox(),
                              borderRadius: BorderRadius.circular(10.r),
                              //iconEnabledColor: AppColor.bgColor,
                              icon: const SizedBox(),
                              //iconSize: 20.r,
                              enableFeedback: true,
                              //padding: EdgeInsets.symmetric(horizontal: 10.w),
                              value: listingController.selectedBuildingTypeValue.value,
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
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }
                      ),
                      SizedBox(height: size.height * 0.04,),
        
                      //property size
                      Text(
                        "Property size",
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),               

                      ProfileTextField3(
                        onChanged: (p0) {
                          listingController.propertySizeControllerEdit.text = p0;
                        },
                        hintText: '',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        initialValue: '${widget.model.size}',
                      ),
                      SizedBox(height: size.height * 0.04,),
        
                      //apartment rent
                      Text(
                        "Rent",
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),               
                      ProfileTextField3(
                        onChanged: (p0) {
                          listingController.rentControllerEdit.text = p0;
                        },
                        hintText: '',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        initialValue: '${widget.model.rent}',
                      ),
        
                      SizedBox(height: size.height * 0.04,),
        
                      //floors
                      Text(
                        "Floors in the building",
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),               
                      ProfileTextField3(
                        onChanged: (p0) {
                          listingController.floorsControllerEdit.text = p0;
                        },
                        hintText: '',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        initialValue: '${widget.model.floors}',
                      ),
                      SizedBox(height: size.height * 0.04,),
        
                      //rooms
                      Text(
                        "Number of rooms",
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),               
                      ProfileTextField3(
                        onChanged: (p0) {
                          listingController.roomsControllerEdit.text = p0;
                        },
                        hintText: '',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        initialValue: '${widget.model.rooms}',
                      ),
                      SizedBox(height: size.height * 0.04,),

                      //Apartment Facilities
                      Text(
                        "Facilities",
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),
                      //next widget here
                      const PropertyFacilities(),

                      /////controller.selectedFacilitiesList

                      SizedBox(height: size.height * 0.04,),
        
                      //upload pictures of the property   
                      Text(
                        "Upload pictures of the property",
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ImageButton1(),
                          SizedBox(width: 20.w,),
                          ImageButton2(),
                          SizedBox(width: 20.w,),
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
                                           
                      SizedBox(height: size.height * 0.10,),
                            
                      //NEXT BUTTON
                      Obx(
                        () {
                          return profileService.isLoadingAdd.value ? const Loader2() : CustomNextButton(
                            text: 'Save Changes',
                            textColor: AppColor.whiteColor,
                            buttonColor: listingController.isPropImage3Selected.value ? AppColor.darkPurpleColor : AppColor.darkPurpleColor.withOpacity(0.4),
                            onPressed: listingController.isPropImage3Selected.value 
                            ? () async{
                              await profileService.updatePropertyEndpoint(
                                context: context, 
                                location: {
                                  'address': listingController.propertyLocationControllerEdit.text.isNotEmpty ? listingController.propertyLocationControllerEdit.text : widget.model.location.address,
                                  'placeId': locationService.placeId.value.isNotEmpty ? locationService.placeId.value : widget.model.location.placeId,
                                  'longitude': locationService.longitudeValue.value != 0.0 ? locationService.longitudeValue.value : widget.model.location.longitude,
                                  'latitude': locationService.latitudeValue.value != 0.0 ? locationService.latitudeValue.value : widget.model.location.latitude,
                                },

                                buildingType: listingController.selectedBuildingTypeValue.value,
                                rooms: listingController.roomsControllerEdit.text.isNotEmpty ? int.parse(listingController.roomsControllerEdit.text) : widget.model.rooms.toInt(),
                                floors: listingController.floorsControllerEdit.text.isNotEmpty ? int.parse(listingController.floorsControllerEdit.text) : widget.model.floors.toInt(),
                                size: listingController.propertySizeControllerEdit.text.isNotEmpty ? int.parse(listingController.propertySizeControllerEdit.text) : widget.model.size.toInt(),
                                rent: listingController.rentControllerEdit.text.isNotEmpty ? int.parse(listingController.rentControllerEdit.text) : widget.model.rent.toInt(),
                                facilitiesList: listingController.selectedFacilitiesList.isNotEmpty ? listingController.selectedFacilitiesList.map((e) => e.name as dynamic).toList() : widget.model.facilities,
                                propertyPicList: listingController.propImage1.text.isNotEmpty && listingController.propImage2.text.isNotEmpty && listingController.propImage3.text.isNotEmpty ? [
                                  listingController.propImage1.text,
                                  listingController.propImage2.text,
                                  listingController.propImage3.text,
                                ] : widget.model.propertyPics,
                                onSuccess: () {
                                  locationService.longitudeValue.value = 0.0;
                                  locationService.latitudeValue.value = 0.0;
                                  locationService.placeId.value = '';
                                  listingController.propImage1.clear();
                                  listingController.propImage2.clear();
                                  listingController.propImage3.clear();
                                  
                                  listingController.selectedFacilitiesList.clear();
                                  listingController.propertyLocationControllerEdit.clear();
                                  listingController.roomsControllerEdit.clear();
                                  listingController.floorsControllerEdit.clear();
                                  listingController.propertySizeControllerEdit.clear();
                                  listingController.rentControllerEdit.clear();

                                  Get.back();
                                  widget.onRefresh();
                                  successBottomsheet(
                                    context: context,
                                    title: "You've successfully updated your listing"
                                  );
                                }
                              );
                            }
                            : () {
                              debugPrint("nothing. select last image");
                              //Get.off(() => HostPhase3Page());
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



