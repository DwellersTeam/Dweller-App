import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';






class LegalSelector extends StatelessWidget {
  const LegalSelector({super.key, required this.onPressed, required this.text});
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        //height: 50.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColor.legalGreyColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.poppins(
                color: AppColor.darkPurpleColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              )
            ),
            Icon(
              size: 24.r,
              color: AppColor.darkPurpleColor,
              CupertinoIcons.chevron_forward
            )
          ],
        ),
      ),
    );
  }
}