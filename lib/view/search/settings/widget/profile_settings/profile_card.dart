import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';








class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.displayPic, required this.displayName, required this.age, required this.zodiac, required this.onEditPhoto});
  final String displayPic;
  final String displayName;
  final String age;
  final String zodiac;
  final VoidCallback onEditPhoto;


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 270.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
           AppColor.blueColor,
           AppColor.blueColor,
           AppColor.blueColor,
           AppColor.blueColorLightest,
           AppColor.blueColorLightest,
          ],
          stops: [
            0.0, // Start of blue
            1/3, // End of blue, Start of white
            1/3, // End of blue, Start of white
            1/3, // End of blue, Start of white
            1.0, // End of white
          ],
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter,
        ),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.058,),
          Stack(
            children: [
              //wrap with obx
              CircleAvatar(
                backgroundColor: AppColor.blueColorLightest,
                radius: 43.r,
                child: displayPic.isNotEmpty ? CircleAvatar(
                  radius: 40.r,
                  backgroundColor: Colors.grey.withOpacity(0.1),
                  backgroundImage: NetworkImage(displayPic),
                )
                : CircleAvatar(
                  radius: 40.r,
                  backgroundColor: Colors.grey.withOpacity(0.1),
                  child: Text(
                    getFirstLetter(displayName),
                    style: GoogleFonts.poppins(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
              //camera button
              //yellow stacked container
              Positioned(
                bottom: 5.h, // Adjust this value to control how much it protrudes
                right: 0.w, //135.w
                child: InkWell(
                  onTap: onEditPhoto,
                  child: SvgPicture.asset('assets/svg/edit_photo.svg')
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                displayName,
                style: GoogleFonts.poppins(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(width: 10.w),
              Icon(
                size: 24.r,
                color: AppColor.blueColor,
                CupertinoIcons.checkmark_seal_fill
              ),
            ],
          ),
          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //1
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Age',
                    style: GoogleFonts.poppins(
                      color: AppColor.blackColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    age,
                    style: GoogleFonts.poppins(
                      color: AppColor.blackColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              SizedBox(width: 20.w,),
              //2
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Sign',
                    style: GoogleFonts.poppins(
                      color: AppColor.blackColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    zodiac,
                    //'Gemini ♊',
                    style: GoogleFonts.poppins(
                      color: AppColor.blackColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]
      )
    );
  }
}