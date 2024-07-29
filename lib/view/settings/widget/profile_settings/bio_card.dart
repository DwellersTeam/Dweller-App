import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';







class BioCard extends StatelessWidget {
  const BioCard({super.key, required this.onEdit, required this.bioText, required this.locationText, required this.jobText});
  final VoidCallback onEdit;
  final String bioText;
  final String locationText;
  final String jobText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.blueColorLightest,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow:   [
          BoxShadow(
            color: AppColor.semiDarkGreyColor.withOpacity(0.1), //.blackColor.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ], 
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Bio',
                style: GoogleFonts.poppins(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600
                ),
              ),
              InkWell(
                onTap: onEdit,
                child: Icon(
                  size: 22.r,
                  color: AppColor.darkPurpleColor,
                  Icons.edit
                ),
              )
            ],
          ),
          //SizedBox(height: MediaQuery.of(context).size.height * 0.058,),
          SizedBox(height: 20.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bioText,
                style: GoogleFonts.poppins(
                  color: AppColor.profileBlackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500
                ),
              ),

              SizedBox(height: 20.h),
              Text(
                'Occupation',
                style: GoogleFonts.poppins(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 10.w,),
              Text(
                jobText,
                style: GoogleFonts.poppins(
                  color: AppColor.profileBlackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500
                ),
              ),

              SizedBox(height: 20.h),
              Text(
                'Location',
                style: GoogleFonts.poppins(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 10.w,),
              Text(
                locationText,
                style: GoogleFonts.poppins(
                  color: AppColor.profileBlackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ]
      )
    );
  }
}