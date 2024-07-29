import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/home/widget/profile(h&s)/detail_card.dart';
import 'package:dweller/view/home/widget/profile(h&s)/display_pictures.dart';
import 'package:dweller/view/home/widget/profile(h&s)/hobbies_list.dart';
import 'package:dweller/view/home/widget/profile(h&s)/lifestyle_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';






class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          /*borderRadius: BorderRadius.circular(50.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.semiDarkGreyColor.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],*/
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            //Profile Details
            AnimatedContainer(
              //alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              //height: 60.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.blueColorLightest,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColor.blueColorLightest),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.lightGreyColor.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              duration: const Duration(milliseconds: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //profile Avatar
                  CircleAvatar(
                    radius: 24.r,
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    backgroundImage: const AssetImage("assets/images/lionel.jpg"),
                    /*child: Text(
                      'J',
                      style: GoogleFonts.poppins(
                        color: AppColor.blackColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),*/
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Lisa Peters",
                        style: GoogleFonts.poppins(
                          color: AppColor.neutralBlackColorOp,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600
                        )
                      ),
                      SizedBox(width: 10.w,),
                      Icon(
                        color: AppColor.blueColor,
                        size: 22.r,
                        CupertinoIcons.checkmark_seal_fill
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Age  ",
                          style: GoogleFonts.poppins(
                            color: AppColor.neutralBlackColorOp,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        TextSpan(
                          text: "21      ",
                          style: GoogleFonts.poppins(
                            color: AppColor.neutralBlackColorOp,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        TextSpan(
                          text: "Sign  ",
                          style: GoogleFonts.poppins(
                            color: AppColor.neutralBlackColorOp,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        TextSpan(
                          text: "Gemini ♊",
                          style: GoogleFonts.poppins(
                            color: AppColor.neutralBlackColorOp,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ]
                    )
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    '"Lorem ipsum dolo bla bla bla fdgsdghfhjghjcghjghttttttttttttttttttttfffffffffffffffffffrrer"',
                    style: GoogleFonts.poppins(
                      color: AppColor.blackColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600
                    ),
                    overflow: TextOverflow.fade,
                  )
                ]
              )
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

            //Occupation
            ProfileDetailCard(
              title: "Occupation/Business",
              child: Text(
                "Fullstack Mobile Engineer @Jetify",
                style: GoogleFonts.poppins(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500
                )
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

            //Location
            ProfileDetailCard(
              title: "Location",
              child: Text(
                "14 Vana-Viru Tallin, 10111 / Estonia",
                style: GoogleFonts.poppins(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500
                )
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

            //Hobbies & Interests
            ProfileDetailCard(
              title: "Hobbies & Interests",
              child: ProfileHobbiesList(),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

            //Lifestyle
            ProfileDetailCard(
              title: "Lifestyle",
              child: ProfileLifestyleList(),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Text(
              "Display Pictures",
              style: GoogleFonts.poppins(
                color: AppColor.blackColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600
              )
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ProfileDisplayPictures(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          ]
        )
      ),
    );
  }
}