import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';









class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.whiteColor,
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.h,),
          SvgPicture.asset(
            'assets/svg/noti_empty.svg',
            height: 160.h,
            width: double.infinity,
          ),
          SizedBox(height: 30.h,),
          Text(
            'No notifications',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: AppColor.darkPurpleColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400
              )
            )
          ),
    
        ],
      ),
    );
  }
}