import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';









class SettingsSelector extends StatelessWidget {
  const SettingsSelector({super.key, this.onTap, required this.svgImage, this.icon, required this.text});
  final VoidCallback? onTap;
  final SvgPicture svgImage;
  final Widget? icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          svgImage,
          SizedBox(width: 20.w,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    color: AppColor.profileBlackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400
                  ),
                ),
                icon ?? SizedBox.shrink()
              ],
            )
          )
        ],
      ),
    );
  }
}







class SettingsSelector2 extends StatelessWidget {
  const SettingsSelector2({super.key, this.onTap, required this.svgImage, required this.text1, required this.text2, required this.text3, required this.switchWidget1, required this.switchWidget2, required this.text4, required this.text5});
  final VoidCallback? onTap;
  final SvgPicture svgImage;
  final Widget switchWidget1;
  final Widget switchWidget2;
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          svgImage,
          SizedBox(width: 20.w,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: GoogleFonts.poppins(
                    color: AppColor.profileBlackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: 10.h,),
                //switch section 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            text2,
                            style: GoogleFonts.poppins(
                              color: AppColor.profileBlackColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          Text(
                            text3,
                            style: GoogleFonts.poppins(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    switchWidget1
                  ]
                ),
                SizedBox(height: 20.h,),
                //switch section 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            text4,
                            style: GoogleFonts.poppins(
                              color: AppColor.profileBlackColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          Text(
                            text5,
                            style: GoogleFonts.poppins(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    switchWidget2
                  ]
                )

  
              ],
            )
          )
        ],
      ),
    );
  }
}