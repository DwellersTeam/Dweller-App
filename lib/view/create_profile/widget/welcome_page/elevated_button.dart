import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';






class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.onPressed, required this.buttonColor, required this.textColor, required this.text});
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: buttonColor
        ),
        height: 60.h,
        width: 170.w,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700
          )
        )
      ),
    );
  }
}