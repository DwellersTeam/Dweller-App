import 'package:dweller/services/controller/home/homepage_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';






class ProfileHobbiesList extends StatelessWidget {
  ProfileHobbiesList({super.key});

  final controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210.h, //200.h
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 30, //10,
          mainAxisSpacing: 20, //10,
          childAspectRatio: 0.35, //0.3 Adjust this ratio as needed to control the item size
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: controller.mainHobbiesList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              height: 40.h,
              //width: 180.w,
              //width: index.isEven ? 80.w : 160.w,
              decoration: BoxDecoration(          
                color: AppColor.blueColorLightest,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: AppColor.blueColorLightest,
                )
              ),
              child: Text(
                controller.mainHobbiesList[index],  //${index}
                style: GoogleFonts.poppins(
                  color:  AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              )
            ),
          );
        }
      ),
    );
  }
}