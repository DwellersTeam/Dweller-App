import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';




class OnbSkipButton extends StatelessWidget {
  const OnbSkipButton({super.key, required this.onSkip});
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSkip,
      child: Text(
        'Skip',
        style: GoogleFonts.poppins(
          color: AppColor.semiDarkGreyColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700
        )
      )
    );
  }
}