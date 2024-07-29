import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







class TaskHeader extends StatelessWidget {
  const TaskHeader({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //height: 90.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: SvgPicture.asset("assets/svg/arrow_back.svg")
          ),
          SizedBox(width: 20.w),
          Text(
            'Schedule Tasks',
            style: GoogleFonts.bricolageGrotesque(
              color: AppColor.blackColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500
            )
          ),
        ],
      ),
    );
  }
}