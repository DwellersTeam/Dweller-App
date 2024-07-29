import 'package:dweller/services/controller/home/homepage_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class HostApartmentGallery extends StatelessWidget {
  HostApartmentGallery({super.key});

  final controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h, //120.h
      //width: 150.w,
      child: ListView.separated(
        //padding: EdgeInsets.symmetric(horizontal: 20.w),
        physics: const BouncingScrollPhysics(),
        itemCount: controller.imageUrls.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 15.w,),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              //controller.selectedApartmentIndex == index; "setState"
            },
            child: Image.asset(
              controller.imageUrls[index], 
              height: 400.h, //60.h
              width: 200.w, //120.w
              fit: BoxFit.cover,
            )
            /*Container(
              alignment: Alignment.center,
              //height: 150,
              //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              decoration: BoxDecoration(
                image: DecorationImage(
                  //colorFilter: const ColorFilter.mode(AppColor.darkGreyColor, BlendMode.softLight), //dst, softLight
                  image: AssetImage(
                    //controller.imageUrls[index],
                    "assets/images/messi.png",
                  ),
                  fit: BoxFit.cover
                ),
                color: AppColor.darkPurpleColor,
                borderRadius: BorderRadius.circular(20.r), 
              ),
              //child: ,
            )*/
          );
        }
      ),
    );
  }
}