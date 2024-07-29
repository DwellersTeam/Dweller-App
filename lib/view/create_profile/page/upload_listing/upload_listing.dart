import 'package:dweller/services/controller/home/listing/listing_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/view/create_profile/page/phase_3/host_phase_3.dart';
import 'package:dweller/view/create_profile/widget/listing/facilities.dart';
import 'package:dweller/view/create_profile/widget/phase_1/textfield.dart';
import 'package:dweller/view/create_profile/widget/listing/property_image_selector.dart';
import 'package:dweller/view/create_profile/widget/listing/selector_button.dart';
import 'package:dweller/view/create_profile/widget/select_dweller/next_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








//UPLOAD LISTING

class UploadListingPage extends StatefulWidget {
  const UploadListingPage({super.key});

  @override
  State<UploadListingPage> createState() => _UploadListingPageState();
}

class _UploadListingPageState extends State<UploadListingPage> {


  final createProfileController = Get.put(ListingController());


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
                      onTap: () {},
                      child: SvgPicture.asset('assets/svg/noti_icon.svg')
                    ),
                    CircleAvatar(
                      radius: 24.r,
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      backgroundImage: const AssetImage("assets/images/lionel.jpg"),
                      /*child: Text(
                        'J',
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),*/
                    ),
                  ],
                ),
              ),
            
              SizedBox(height: size.height * 0.04,),
        
              /*LinearProgressIndicator(
                backgroundColor: AppColor.blueColor.withOpacity(0.3), // Background color of the progress indicator
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.purpleColor), // Color of the progress indicator
                value: 0.40, // Value between 0.0 and 1.0 indicating the progress
                minHeight: 2.5,
                borderRadius: BorderRadius.horizontal(right: Radius.circular(10.r)),
              ),
        
              SizedBox(height: size.height * 0.025,),*/
              
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
                        "Type in your address",
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
        
                      SizedBox(height: size.height * 0.015,),
                      ProfileTextField2(
                        onChanged: (p0) {},
                        hintText: '',
                        keyboardType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        textController: createProfileController.propertyLocationController,
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
                                    
                      Text(
                        "What type of building is it?",
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.015,),
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
                              underline: SizedBox(),
                              borderRadius: BorderRadius.circular(10.r),
                              //iconEnabledColor: AppColor.bgColor,
                              icon: SizedBox(),
                              //iconSize: 20.r,
                              enableFeedback: true,
                              //padding: EdgeInsets.symmetric(horizontal: 10.w),
                              value: createProfileController.selectedBuildingTypeValue.value,
                              onChanged: (newValue) { 
                                // When the user selects an option, update the selectedValue
                                createProfileController.toggleBuildingType(newValue);
                              },
                              items: createProfileController.items.map((item) {
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
                      Text(
                        "What's the size of the property (in m2)",
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
        
                      SizedBox(height: size.height * 0.015,),
                      ProfileTextField2(
                        onChanged: (p0) {},
                        hintText: '',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        textController: createProfileController.propertySizeController,
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
                      Text(
                        "Property rent",
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
        
                      SizedBox(height: size.height * 0.015,),
                      ProfileTextField2(
                        onChanged: (p0) {},
                        hintText: '',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textController: createProfileController.rentController,
                      ),
                      SizedBox(height: size.height * 0.04,),
        
                      //parking lot     
                      Text(
                        "Parking",
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),                  
                      Text(
                        "Is there parking available?",
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.015,),
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
                              underline: SizedBox(),
                              borderRadius: BorderRadius.circular(10.r),
                              //iconEnabledColor: AppColor.bgColor,
                              icon: SizedBox(),
                              //iconSize: 20.r,
                              enableFeedback: true,
                              //padding: EdgeInsets.symmetric(horizontal: 10.w),
                              value: createProfileController.selectedParkingLotValue.value,
                              onChanged: (newValue) { 
                                // When the user selects an option, update the selectedValue
                                createProfileController.toggleParkingLot(newValue);
                              },
                              items: createProfileController.itemsParking.map((item) {
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
        
                      //floors
                      Text(
                        "Floors",
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),               
                      Text(
                        "How many floors are in the building?",
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
        
                      SizedBox(height: size.height * 0.015,),
                      ProfileTextField2(
                        onChanged: (p0) {},
                        hintText: '',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        textController: createProfileController.floorsController,
                      ),
                      SizedBox(height: size.height * 0.04,),
        
                      //rooms
                      Text(
                        "Rooms",
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),               
                      Text(
                        "How many rooms are in the apartment?",
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
        
                      SizedBox(height: size.height * 0.015,),
                      ProfileTextField2(
                        onChanged: (p0) {},
                        hintText: '',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        textController: createProfileController.roomsController,
                      ),
                      SizedBox(height: size.height * 0.04,),
        
                      //storage space    
                      Text(
                        "Storage",
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.025,),                  
                      Text(
                        "Is there ample storage in the apartment?",
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: size.height * 0.015,),
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
                              underline: SizedBox(),
                              borderRadius: BorderRadius.circular(10.r),
                              //iconEnabledColor: AppColor.bgColor,
                              icon: SizedBox(),
                              //iconSize: 20.r,
                              enableFeedback: true,
                              //padding: EdgeInsets.symmetric(horizontal: 10.w),
                              value: createProfileController.selectedAmpleStorageValue.value,
                              onChanged: (newValue) { 
                                // When the user selects an option, update the selectedValue
                                createProfileController.toggleAmpleStorage(newValue);
                              },
                              items: createProfileController.itemsStorage.map((item) {
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
                      PropertyFacilities(),


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
                              
                                    
                      SizedBox(height: size.height * 0.10,),
                            
                      //NEXT BUTTON
                      Obx(
                        () {
                          return CustomNextButton(
                            text: 'Next',
                            textColor: AppColor.whiteColor,
                            buttonColor: createProfileController.isPropImage3Selected.value ? AppColor.darkPurpleColor : AppColor.darkPurpleColor.withOpacity(0.4),
                            onPressed: createProfileController.isPropImage3Selected.value 
                            ? () {
                              //Get.off(() => HostPhase3Page());
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



