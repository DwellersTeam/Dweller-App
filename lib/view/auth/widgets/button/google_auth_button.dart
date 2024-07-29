import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';






class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({super.key, required this.onPressed, required this.text, required this.borderColor, required this.backgroundColor, required this.textColor, required this.foregroundColor,});
  final VoidCallback onPressed;
  final Color borderColor;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed, // Label text
        style: ElevatedButton.styleFrom(
          elevation: 0,
          enableFeedback: true,
          alignment: Alignment.center,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          //padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r), // Button border radius
            side: BorderSide(
              color: borderColor,
              width: 1.0.w
            )
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
            Image.asset(
              'assets/images/google_icon.png',
              height: 40.h,
              width: 40.w,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  CupertinoIcons.xmark,
                  color: AppColor.whiteColor,
                  size: 24.r,
                );
              },
            ),
            SizedBox(width: 10.w,),
            Text(
              text,
              style: GoogleFonts.poppins(
                color: textColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700
              )
            ),
  
          ],
        ),
      ),
    );
  }
}