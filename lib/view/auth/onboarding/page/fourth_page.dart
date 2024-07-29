import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';





class FourthPage extends StatelessWidget {
  const FourthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //SizedBox(height: 20.h,), //20.h
        //image
        Image.network(
          'https://res.cloudinary.com/dwvcga8sn/image/upload/v1721822493/onb_4_ph7rpy.png',
          height: 350.h,
          width: double.infinity,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high
        ),
          
        SizedBox(height: 30.h,),
    
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Schedule Room ',
                style: GoogleFonts.bricolageGrotesque(
                  color: AppColor.blueColor,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700
                )
              ),
              TextSpan(
                text: '\nActivities ',
                style: GoogleFonts.bricolageGrotesque(
                  color: AppColor.blueColor,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700
                )
              ),
              TextSpan(
                text: 'with ease on ',
                style: GoogleFonts.bricolageGrotesque(
                  color: AppColor.blackColor,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500
                )
              ),
              TextSpan(
                text: '\nDweller',
                style: GoogleFonts.bricolageGrotesque(
                  color: AppColor.blackColor,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500
                )
              )
            ]
          )
        ),
        SizedBox(height: 20.h,),
        Text(
          'Find the right roommate for you on Dweller by\nswiping right or left',
          style: GoogleFonts.poppins(
            color: AppColor.semiDarkGreyColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500
          ),
          textAlign: TextAlign.center,
        ),    
      ],
    );
  }
}