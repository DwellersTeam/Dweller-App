import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';






class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.onTap, required this.svgasset, required this.text});
  final VoidCallback onTap;
  final String svgasset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(svgasset),
          SizedBox(width: 10.w,),
          Text(
            text,
            style: GoogleFonts.poppins(
              color: AppColor.neutralBlackColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }
}