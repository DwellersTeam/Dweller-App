import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';




class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.onPressed, required this.backgroundColor, required this.text, required this.textColor});
  final VoidCallback onPressed;
  final Color backgroundColor;
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
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700 //w600
          )
        ),
      ),
    );
  }
}