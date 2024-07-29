import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';





void showAssignUserDialog({
  required VoidCallback onCancel, 
  required VoidCallback onConfirm
  }) {
  Get.defaultDialog(
    barrierDismissible: true,
    backgroundColor: Color.fromRGBO(214, 248, 255, 1),
    contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
    title: '',
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '🥹',
          style: GoogleFonts.poppins(
            color: AppColor.blackColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600
          ),
        ),
        SizedBox(height: 10.h,),
        Text(
          'Leaving so soon?',
          style: GoogleFonts.poppins(
            color: AppColor.darkPurpleColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600
          ),
        ),
        SizedBox(height: 10.h,),
        Text(
          'Are you sure you want to Logout of Dweller?',
          style: GoogleFonts.poppins(
            color: AppColor.darkPurpleColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 30.h,),
        //buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: onConfirm,
              child: Text(
                "Yes Logout",
                style: GoogleFonts.poppins(
                  color: AppColor.darkGreyColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            SizedBox(width: 20.w,),
            InkWell(
              onTap: onCancel,
              child: Text(
                "No I'll stay",
                style: GoogleFonts.poppins(
                  color: AppColor.darkPurpleColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}