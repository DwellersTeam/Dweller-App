import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';








class UploadKYCDoc extends StatelessWidget {
  const UploadKYCDoc({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: DottedBorder(
        borderType: BorderType.RRect, //Rect, //RrRct
        radius: Radius.circular(10.r),
        dashPattern: [6, 6],
        color: AppColor.blueColor,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: AppColor.blueColorOp,
            borderRadius: BorderRadius.circular(10.r)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.cloud_upload,
                color: AppColor.semiDarkGreyColor //darkGreyColor,
              ),
              Container(
                alignment: Alignment.center,
                //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                height: 40.h,
                width: 120.w,
                decoration: BoxDecoration(
                  color: AppColor.blueColorOp,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  "Upload +",
                  style: GoogleFonts.poppins(
                    color: AppColor.semiDarkGreyColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400
                  ),
                ),
                          
              )
            ],
          ),
        )
      ),
    );
  }
}



class UploadedKYCDoc extends StatelessWidget {
  const UploadedKYCDoc({super.key, required this.onDelete, required this.file});
  final VoidCallback onDelete;
  final File? file;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(10.r),
      dashPattern: [6, 6],
      color: AppColor.blueColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: AppColor.blueColorOp,
              borderRadius: BorderRadius.circular(10.r)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.folder_solid, //cloud_upload,
                  color: AppColor.darkPurpleColor
                ),
                SizedBox(width: 10.w,),
                Text(
                  "file uploaded",
                  style: GoogleFonts.poppins(
                    color: AppColor.darkPurpleColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500
                  ),
                ),
              
              ],
            ),
          ),
          TextButton(
            onPressed: onDelete, 
            child: Text(
              "Delete",
              style: GoogleFonts.poppins(
                color: AppColor.redColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: AppColor.redColor
              ),
            ),
          )
        ],
      )
    );
  }
}