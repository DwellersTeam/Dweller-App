import 'package:dweller/services/controller/home/homepage_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class FacilitiesList extends StatelessWidget {
  const FacilitiesList({super.key, required this.facilities});
  final List<dynamic> facilities;

  //final controller = Get.put(HomePageController());
  // Define a map to link facility types with icons
  static const Map<String, String> facilityIcons = {
    'Wifi': "assets/svg/wifi.svg",
    'Gym': "assets/svg/gym.svg",
    'Parking': "assets/svg/parking.svg", //park
    'Storage': "assets/svg/storage.svg",
    'EV Charging': "assets/svg/ev_charger.svg", //ev
    'Kids Park': "assets/svg/kids.svg",
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 210.h, //200.h
      height: MediaQuery.of(context).size.height * 0.35, //0.45
      //width: double.infinity,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 30, //10,
          mainAxisSpacing: 30, //10,
          childAspectRatio: 1.0, //0.35 Adjust this ratio as needed to control the item size
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: facilities.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        //padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemBuilder: (context, index) {

          final data =  facilities[index];
          final icon = facilityIcons[data]; // Look up the icon by facility name

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: AppColor.semiDarkGreyColor.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                SvgPicture.asset(
                  icon ?? "assets/svg/wifi.svg", 
                  height: 26.h, 
                  width: 26.w,
                ),
                SizedBox(height: 30.h,),

                Text(
                  data,
                  style: GoogleFonts.poppins(
                    color: AppColor.blackColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          );
        }
      )
    );
  }
}