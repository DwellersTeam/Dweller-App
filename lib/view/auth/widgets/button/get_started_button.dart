import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';






class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key, required this.onGetStarted});
  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onGetStarted, // Label text
        style: ElevatedButton.styleFrom(
          elevation: 0,
          enableFeedback: true,
          alignment: Alignment.center,
          backgroundColor: AppColor.darkPurpleColor,
          //padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r), // Button border radius
          ),
        ),
        /*icon: Icon(
          size: 20.r,
          CupertinoIcons.chevron_right,
          color: AppColor.whiteColor,
        ),*/ // Icon to be displayed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 90.w,),
            Text(
              'Get Started',
              style: GoogleFonts.poppins(
                color: AppColor.whiteColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700
              )
            ),
            SizedBox(width: 90.w,),
            Icon(
              size: 20.r,
              CupertinoIcons.chevron_right,
              color: AppColor.whiteColor,
            )
          ],
        ),
      ),
    );
  }
}