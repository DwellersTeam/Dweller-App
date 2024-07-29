import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';



class DenseContainer extends StatelessWidget {
  const DenseContainer({super.key, required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      alignment: Alignment.bottomLeft,
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: AppColor.blueColor,
        image: const DecorationImage(
          image: AssetImage('assets/images/cr_acc.png'),
          fit: BoxFit.cover
        ),
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ], //32 500w
      ),
      child: Text(
        'create account',
        style: GoogleFonts.bricolageGrotesque(
          color: AppColor.lightCreamColor,
          fontSize: 32.sp,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}