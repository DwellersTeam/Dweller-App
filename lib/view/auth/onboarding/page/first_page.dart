import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';






class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //SizedBox(height: 20.h,), //20.h
        //image
        Image.asset(
          'assets/images/onb_1.png',
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
                text: 'Finding the Perfect\nRoomies as easy as a',
                style: GoogleFonts.bricolageGrotesque(
                  color: AppColor.blackColor,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500
                )
              ),
              TextSpan(
                text: '\nSwipe!',
                style: GoogleFonts.bricolageGrotesque(
                  color: AppColor.blueColor,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700
                )
              )
            ]
          )
        ),
        SizedBox(height: 20.h,),
        Text(
          'Find the right roomate for you on dweller by\n swiping left or right',
          style: GoogleFonts.poppins(
            color: AppColor.semiDarkGreyColor,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500
          ),
          textAlign: TextAlign.center,
        ),
        //SizedBox(height: MediaQuery.of(context).size.height * 0.035),       
      ],
    );
  }
}