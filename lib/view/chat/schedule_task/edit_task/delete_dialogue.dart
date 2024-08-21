import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







void deleteTaskDialog({
  required String taskName,
  required VoidCallback onCancel, 
  required VoidCallback onConfirm
  }) {
  Get.dialog(
    barrierDismissible: true,
    transitionCurve: const ElasticOutCurve(),
    useSafeArea: true,
    //backgroundColor: Color.fromRGBO(235, 252, 255, 1),
    
    AlertDialog.adaptive(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      //backgroundColor: Color.fromRGBO(214, 248, 255, 1),
      backgroundColor: Color.fromRGBO(235, 252, 255, 1),
      content: Wrap(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //SizedBox(height: 10.h,),
                Text(
                  'Delete "$taskName"',
                  style: GoogleFonts.bricolageGrotesque(
                    color: AppColor.darkPurpleColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 10.h,),
                Text(
                  'Are you sure you want to delete this task?',
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
          ),
        ],
      ),
    ),
  );
}