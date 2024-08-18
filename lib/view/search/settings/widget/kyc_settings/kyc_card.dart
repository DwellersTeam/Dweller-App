import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';




class KYCCard extends StatelessWidget {
  const KYCCard({super.key, required this.onStartKyc});
  final VoidCallback onStartKyc;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      decoration: BoxDecoration(
        color: AppColor.blueColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Become a Verified Dweller',
                  style: GoogleFonts.bricolageGrotesque(
                    color: AppColor.whiteColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 15.h,),
                Text(
                  'Complete your KYC process to become a verified dweller',
                  style: GoogleFonts.poppins(
                    color: AppColor.whiteColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: 15.h,),
                InkWell(
                  onTap: onStartKyc,
                  child: Container(
                    alignment: Alignment.center,
                    height: 40.h,
                    width: 110.w,
                    //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Start KYC',
                          style: GoogleFonts.poppins(
                            color: AppColor.darkPurpleColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(width: 5.w,),
                        Icon(
                          size: 16.r,
                          color: AppColor.darkPurpleColor,
                          CupertinoIcons.chevron_forward
                        )
                      ]
                    )
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 5.w,),
          SvgPicture.asset(
            "assets/svg/kyc.svg",
            height: 60.h,
            width: 60.w,
          ),
        ],
      )
    );
  }
}


class PurpleKYCCard extends StatelessWidget {
  const PurpleKYCCard({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      decoration: BoxDecoration(
        color: AppColor.darkPurpleColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: 25.h,
            width: 90.w,
            //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: Color.fromRGBO(55, 203, 237, 0.16),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '⚠️   ',
                    style: GoogleFonts.poppins(
                      color: AppColor.whiteColor,
                      fontSize: 6.sp,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  TextSpan(
                    text: 'Verification Pending',
                    style: GoogleFonts.poppins(
                      color: AppColor.whiteColor,
                      fontSize: 6.sp,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ]
              )
            ),
          ),
          SizedBox(height: 15.h,),
          Text(
            'Thank you for uploading your documents!📃',
            style: GoogleFonts.bricolageGrotesque(
              color: AppColor.whiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(height: 15.h,),
          Text(
            "We're are verifying your documents for KYC purposes. Expect an update within 24 hours",
            style: GoogleFonts.poppins(
              color: AppColor.whiteColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w400
            ),
          ),
          
        ],
      ),
    );
  }
}



class SuccessPurpleKYCCard extends StatelessWidget {
  const SuccessPurpleKYCCard({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      decoration: BoxDecoration(
        color: AppColor.darkPurpleColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: 25.h,
            width: 90.w,
            //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(55, 203, 237, 0.16),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '🎉   ',
                    style: GoogleFonts.poppins(
                      color: AppColor.whiteColor,
                      fontSize: 6.sp,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  TextSpan(
                    text: 'Verification successful',
                    style: GoogleFonts.poppins(
                      color: AppColor.whiteColor,
                      fontSize: 6.sp,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ]
              )
            ),
          ),
          SizedBox(height: 15.h,),
          Text(
            'Your documents have been verified successfully!📃',
            style: GoogleFonts.bricolageGrotesque(
              color: AppColor.whiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(height: 15.h,),
          Text(
            "Take a seat and enjoy the ride with us.",
            style: GoogleFonts.poppins(
              color: AppColor.whiteColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w400
            ),
          ),
          
        ],
      ),
    );
  }
}