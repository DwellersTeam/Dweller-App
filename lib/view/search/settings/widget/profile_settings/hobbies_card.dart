import 'package:dweller/services/controller/home/homepage_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/search/settings/page/edit_hobbies_lifestyle_settings.dart';
import 'package:dweller/view/search/settings/widget/general/all_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







class HobbiesCard extends StatelessWidget {
  HobbiesCard({super.key, required this.onEdit, required this.interests, required this.livelihood,});
  final VoidCallback onEdit;
  final List<dynamic> interests;
  final List<dynamic> livelihood;

  final controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
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
          Text(
            'Hobbies and Interests',
            style: GoogleFonts.poppins(
              color: AppColor.blackColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(height: 20.h,),
          //Grid list of hobbies
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 30, //10,
              mainAxisSpacing: 20, //10,
              childAspectRatio: 1.95, //0.35 Adjust this ratio as needed to control the item size
            ),
            physics: NeverScrollableScrollPhysics(),
            itemCount: interests.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            //padding: EdgeInsets.symmetric(horizontal: 0.w),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  //height: 40.h,
                  //width: 180.w,
                  //width: index.isEven ? 80.w : 160.w,
                  decoration: BoxDecoration(          
                    color: AppColor.blueColorLightest,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                      color: AppColor.blueColorLightest,
                    )
                  ),
                  child: Text(
                    interests[index],  //${index}
                    style: GoogleFonts.poppins(
                      color:  AppColor.blackColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  )
                ),
              );
            }
          ),

          SizedBox(height: 40.h,),

          Text(
            'LifeStyle',
            style: GoogleFonts.poppins(
              color: AppColor.blackColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(height: 20.h,),
          //Grid list of lifestyle
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 30, //10,
              mainAxisSpacing: 20, //10,
              childAspectRatio: 1.95, //0.35 Adjust this ratio as needed to control the item size
            ),
            physics: NeverScrollableScrollPhysics(),
            itemCount: livelihood.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            //padding: EdgeInsets.symmetric(horizontal: 0.w),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  //height: 40.h,
                  //width: 180.w,
                  //width: index.isEven ? 80.w : 160.w,
                  decoration: BoxDecoration(          
                    color: AppColor.blueColorLightest,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                      color: AppColor.blueColorLightest,
                    )
                  ),
                  child: Text(
                    livelihood[index],  //${index}
                    style: GoogleFonts.poppins(
                      color:  AppColor.blackColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  )
                ),
              );
            }
          ),
          SizedBox(height: 20.h,),
          Align(
            alignment: Alignment.centerRight,
            child: EditHobbiesButton(
              onPressed: onEdit,
              backgroundColor: AppColor.darkPurpleColor,
              textColor: AppColor.whiteColor,
              text: 'Edit Hobbies and Lifestyle',
              //width: 150.w,
            ),
          )

  
        ]
      )
    );
  }
}