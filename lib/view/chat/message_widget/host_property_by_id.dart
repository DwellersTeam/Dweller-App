import 'dart:developer';

import 'package:dweller/main.dart';
import 'package:dweller/model/listing/property_model.dart';
import 'package:dweller/services/repository/home_service/home_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/home/widget/property/host_property_facilities.dart';
import 'package:dweller/view/home/widget/property/host_property_gallery.dart';
import 'package:dweller/view/home/widget/property/property_fee.dart';
import 'package:dweller/view/home/widget/property/view_property_on_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';






class HostPropertyInfoById extends StatefulWidget {
  const HostPropertyInfoById({super.key, required this.userId});
  //final PropertyHostModel model;
  final String userId;

  @override
  State<HostPropertyInfoById> createState() => _HostPropertyInfoByIdState();
}

class _HostPropertyInfoByIdState extends State<HostPropertyInfoById> {

  final service = Get.put(HomeService());

  late Future<PropertyHostModel> propertyFuture;

  @override
  void initState() {

    propertyFuture = _refresh();
    super.initState();
  }


  //REFRESH FUNCTIONALITY
  Future<PropertyHostModel> _refresh() async{
    await Future.delayed(const Duration(seconds: 2));
    final propertyFuture = await service.getHostPropertyById(context: context,userId: widget.userId);
    return propertyFuture;
  }


  Future<void> _handleRefresh() async{
    setState(() {
      propertyFuture = _refresh();
    });
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PropertyHostModel>(
      future: propertyFuture,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: const LoaderS());
        }
        if(snapshot.hasError){
          log("snapshot err: ${snapshot.error}");
          return Center(
            child: Text(
              "An error occurred",
              style: GoogleFonts.poppins(
                color: AppColor.darkPurpleColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600
              )
            ),
          );
        }
        if(!snapshot.hasData){
          log("snapshot has data?: ${snapshot.hasData}");
          return Center(
            child: Text(
              "Property not found",
              style: GoogleFonts.poppins(
                color: AppColor.darkPurpleColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600
              )
            ),
          );
        }
              
        final data = snapshot.data!;
        return RefreshIndicator.adaptive(
          color: AppColor.whiteColor,
          backgroundColor: AppColor.darkPurpleColor,
          onRefresh: () => _handleRefresh(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColor.whiteColor,
                /*borderRadius: BorderRadius.circular(50.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.semiDarkGreyColor.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],*/
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        style: GoogleFonts.bricolageGrotesque(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                      SizedBox(width: 10.w),
                      //SvgPicture.asset("assets/svg/location.svg"),
                      Icon(
                        CupertinoIcons.location_solid,
                        color: AppColor.blackColor,
                        size: 24.r
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          data.location.address,
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      SizedBox(width: 20.w,),
                      GestureDetector(
                        onTap:() {
                          Get.to(() => ViewPropertyOnMap(
                            lat: data.location.latitude.toDouble(),
                            long: data.location.latitude.toDouble(),
                          ));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                          alignment: Alignment.center,
                          //height: 50.h,
                          decoration: BoxDecoration(
                            color: AppColor.blackColor,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/svg/map.svg", height: 26.h, width: 26.w,),
                              SizedBox(width: 10.w,),
                              Text(
                                "View on Map",
                                style: GoogleFonts.poppins(
                                  color: AppColor.whiteColor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                
                    ]
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Facilities",
                        style: GoogleFonts.bricolageGrotesque(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                      SizedBox(width: 10.w),
                      //SvgPicture.asset("assets/svg/facility.svg"),
                      Icon(
                        CupertinoIcons.lightbulb_fill,
                        color: AppColor.blackColor,
                        size: 24.r
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                  FacilitiesList(facilities: data.facilities),
            
                  SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Apartment Gallery",
                        style: GoogleFonts.bricolageGrotesque(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                      //SizedBox(width: 10.w),
                      //Icon(
                        //CupertinoIcons.lightbulb_fill,
                        //color: AppColor.blackColor,
                        //size: 24.r
                      //)
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                  HostApartmentGallery(pictures: data.propertyPics),
              
                  SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Fees",
                        style: GoogleFonts.bricolageGrotesque(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                      SizedBox(width: 10.w),
                      //SvgPicture.asset("assets/svg/fee.svg"),
                      Icon(
                        CupertinoIcons.money_euro_circle_fill,
                        color: AppColor.blackColor,
                        size: 24.r
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                  PropertyFee(
                    fee: "${currency(context).currencySymbol} ${data.rent}",
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}