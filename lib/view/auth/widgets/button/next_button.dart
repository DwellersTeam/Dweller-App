import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';






class OnbNextButton extends StatelessWidget {
  const OnbNextButton({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onNext,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: AppColor.darkPurpleColor
        ),
        height: 60.h,
        width: 170.w,
        child: Text(
          'Next',
          style: GoogleFonts.poppins(
            color: AppColor.whiteColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700
          )
        )
      ),
    );
  }
}