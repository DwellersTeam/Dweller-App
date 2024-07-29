import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';





class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.onPressed, required this.text, required this.textColor});
  final VoidCallback onPressed;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: textColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700
        )
      )
    );
  }
}