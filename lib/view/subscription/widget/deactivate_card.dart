import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







void deactivateCardDialog({
  required VoidCallback onCancel, 
  required VoidCallback onConfirm
  }) {
  Get.defaultDialog(
    barrierDismissible: true,
    backgroundColor: Color.fromRGBO(235, 252, 255, 1),
    contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
    title: '',
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //SizedBox(height: 10.h,),
        Text(
          'Deactivate card',
          style: GoogleFonts.bricolageGrotesque(
            color: AppColor.darkPurpleColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600
          ),
        ),
        SizedBox(height: 10.h,),
        Text(
          'Are you sure you want to deactivate this card?',
          style: GoogleFonts.poppins(
            color: AppColor.darkPurpleColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400
          ),
        ),
        SizedBox(height: 30.h,),
        //buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: onCancel,
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins(
                  color: AppColor.darkPurpleColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
  
            SizedBox(width: 20.w,),

            InkWell(
              onTap: onConfirm,
              child: Text(
                "Yes",
                style: GoogleFonts.poppins(
                  color: AppColor.darkPurpleColor,
                  fontSize: 14.sp,
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