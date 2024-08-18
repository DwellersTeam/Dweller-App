import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';




class MockField extends StatelessWidget {
  const MockField({super.key, required this.text, this.width});
  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.center,
      //height: 60.h,
      width: width ?? double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w), // Adjust padding as needed        
      decoration: BoxDecoration(
        color: AppColor.greyColor,
        borderRadius: BorderRadius.circular(15.r)
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: AppColor.blackColor, 
          fontSize: 14.sp, 
          fontWeight: FontWeight.w400
        ),
      ),
    );
  }
}