import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dweller/model/listing/property_model.dart';
import 'package:dweller/services/controller/home/listing/listing_controller.dart';
import 'package:dweller/services/repository/create_profile_service/create_profile_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_appbar.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/create_profile/widget/listing/selector_button.dart';
import 'package:dweller/view/create_profile/widget/select_dweller/next_button.dart';
import 'package:dweller/view/settings/page/host_listing/edit_property_screeen.dart';
import 'package:dweller/view/settings/widget/general/mock_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








//VIEW LISTING
class ViewListingPage extends StatefulWidget {
  const ViewListingPage({super.key, required this.propertyId});
  final String propertyId;

  @override
  State<ViewListingPage> createState() => _ViewListingPageState();
}

class _ViewListingPageState extends State<ViewListingPage> {


  final listingController = Get.put(ListingController());
  final profileService = Get.put(CreateProfileService());


  late Future<PropertyModel> propertyFuture;

  //REFRESH FUNCTIONALITY
  Future<PropertyModel> _refresh() async{
    await Future.delayed(const Duration(seconds: 2));
    final propertyFuture = await profileService.getPropertiesByIdEndpoint(context: context, id: widget.propertyId);
    return propertyFuture;
  }

  @override
  void initState() {
    // TODO: implement initState
    propertyFuture = _refresh();
    super.initState();
  }

  Future<void> _handleRefresh() async{
    setState(() {
      propertyFuture = _refresh();
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
        child: CustomPaint(
          painter: TopRedSectionPainter(),
          child: FutureBuilder<PropertyModel>(
            future: propertyFuture,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              if(snapshot.hasError) {
                log("snapshot err: ${snapshot.error}");
                return Center(
                  child: Text(
                    'something went wrong',
                    style: GoogleFonts.poppins(
                      color: AppColor.darkPurpleColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              if(!snapshot.hasData) {
                log("snapshot err: ${snapshot.error}");
                return Center(
                  child: Text(
                    'no data found',
                    style: GoogleFonts.poppins(
                      color: AppColor.darkPurpleColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              final data = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //main body
                  Expanded(
                    child: RefreshIndicator.adaptive(
                      color: AppColor.whiteColor,
                      backgroundColor: AppColor.darkPurpleColor,
                      onRefresh: () =>  _handleRefresh(),  //_refresh(),
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
                                    text: "Property Information",
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
                            MockField(
                              text: "${data.location.address}",
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
                            MockField(
                              text: "${data.buildingType}",
                            ),
                                              
                            /*Obx(
                              () {
                                return SelectorButton(
                                  buttonColor: AppColor.greyColor,
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
                            ),*/
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
                                    
                            MockField(
                              text: "${data.size}",
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
                             MockField(
                              text: "${data.rent}",
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
                            MockField(
                              text: "${data.floors}",
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
                            MockField(
                              text: "${data.rooms}",
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
                                    
                            //next widget here (vertical list of facilities)
                            ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data.facilities.length,
                              separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                                  decoration: BoxDecoration(
                                    color: AppColor.whiteColor,
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(color: AppColor.greyColor, width: 2),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      //SvgPicture.asset(data.facilities[index].icon),
                                      SizedBox(width: 20.h,),
                                      Text(
                                        data.facilities[index],
                                        style: GoogleFonts.poppins(
                                          color: AppColor.blackColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600
                                        ),
                                      )
                          
                                    ],
                                  ),
                                );
                              },
                            ),
                            
                                    
                            SizedBox(height: size.height * 0.04,),
                        
                            //upload pictures of the property   
                            Text(
                              "Property Pictures",
                              style: GoogleFonts.poppins(
                                color: AppColor.blackColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(height: size.height * 0.02,),
                            //next widget here (vertical list of property pictures) 
                            SizedBox(
                              //margin: EdgeInsets.symmetric(vertical: 20.0),
                              height: 280.h, // Height of the horizontal list view
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: data.propertyPics.length,
                                separatorBuilder: (context, index) => SizedBox(width: 20.w,),
                                itemBuilder: (context, index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r)
                                    ),
                                    //margin: EdgeInsets.all(10.0),
                                    elevation: 2,
                                    child: CachedNetworkImage(
                                      imageUrl: data.propertyPics[index],
                                      //width: 400.0.w, // Set a width for the image
                                      fit: BoxFit.contain, // Ensure the image fits well in the card
                                    ),
                                       
                                  );
                                },
                              ),
                            ),               
                                                 
                            SizedBox(height: size.height * 0.10,),
                                  
                                   
                          ],
                        ),
                      ),
                    ),
                  ), 
                       
                ],
              );
            }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        tooltip: 'Edit',
        elevation: 3,
        backgroundColor: AppColor.darkPurpleColor,
        foregroundColor: AppColor.darkPurpleColor,
        shape: const CircleBorder(),
        onPressed: () async{
          final model = await propertyFuture;
          Get.to(() => EditListingPage(
            onRefresh: () => _refresh(),
            model: model,
          ));
        },
        child: Icon(
          size: 24.r,
          color: AppColor.whiteColor,
          Icons.edit,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}



