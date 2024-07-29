import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';




class ChangeButton extends StatelessWidget {
  const ChangeButton({super.key, required this.onPressed, required this.text, this.width});
  final VoidCallback onPressed;
  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 35.h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: AppColor.blueColorSettings,
          borderRadius: BorderRadius.circular(30.r)
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: AppColor.darkPurpleColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}