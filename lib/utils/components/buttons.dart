import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';







//PETITE ROUND ELEVATED BUTTON
class PetiteButton extends StatelessWidget {
  const PetiteButton({super.key, required this.onPressed, required this.backgroundColor, required this.text});
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: backgroundColor
        ),
        height: 60.h,
        width: 170.w,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: AppColor.whiteColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600
          )
        )
      ),
    );
  }
}


//PETITE ROUND ELEVATED BUTTON
class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.backgroundColor, required this.height, required this.width, required this.borderRadiusGeometry, required this.child, this.padding});
  final VoidCallback onPressed;
  final Color backgroundColor;
  final BorderRadiusGeometry borderRadiusGeometry;
  final double height;
  final double width;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 0.w),
        decoration: BoxDecoration(
          borderRadius: borderRadiusGeometry,
          color: backgroundColor
        ),
        height: height,
        width: width,
        child: child
      ),
    );
  }
}



//PETITE ROUND ELEVATED BORDER BUTTON
class CustomBorderButton extends StatelessWidget {
  const CustomBorderButton({super.key, required this.onPressed, required this.backgroundColor, required this.height, required this.width, required this.borderRadiusGeometry, required this.child, this.padding, required this.borderColor});
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final BorderRadiusGeometry borderRadiusGeometry;
  final double height;
  final double width;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 0.w),
        decoration: BoxDecoration(
          borderRadius: borderRadiusGeometry,
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1.0)
        ),
        height: height,
        width: width,
        child: child
      ),
    );
  }
}