import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';






Future<void> matchMadeAlert({required UserModel user}) async {
  await Get.dialog(
    transitionCurve: const ElasticOutCurve(),
    useSafeArea: true,
    barrierDismissible: false,
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      backgroundColor: AppColor.neutralBlackColor,
      //elevation: 2,
      //contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
      //wrap
      content: Wrap(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
            /*decoration: BoxDecoration(
              color: AppColor.blackColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
            ),*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60.h,),
                Text(
                  "Match made!",
                  style: GoogleFonts.bricolageGrotesque(
                    color: AppColor.whiteColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 20.h,),
                user.displayPicture.isEmpty ?
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: AppColor.blueColor,
                  child: CircleAvatar(
                    radius: 28.r,
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    //backgroundImage: const AssetImage("assets/images/messi.png"),
                    child: Icon(
                      size: 20.r,
                      color: AppColor.whiteColor,
                      CupertinoIcons.check_mark
                    )
                  ),
                )
                :CircleAvatar(
                  radius: 30.r,
                  backgroundColor: AppColor.blueColor,
                  child: CircleAvatar(
                    radius: 28.r,
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    backgroundImage: NetworkImage(user.displayPicture),
                    child: Icon(
                      size: 20.r,
                      color: AppColor.whiteColor,
                      CupertinoIcons.check_mark
                    )
                  ),
                ),
                SizedBox(height: 30.h,),
                Text(
                  "You've matched with ${user.firstname} ${user.lastname}! He/She has been added to your match list. ${user.firstname} will see the match and decide if he/she wants to match with you too",
                  style: GoogleFonts.poppins(
                  color: AppColor.whiteColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                ),

                SizedBox(height: 80.h,),

                //Custom Elevated Button
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    //padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0.h),
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: AppColor.blueColorDialogBox,
                      borderRadius: BorderRadius.circular(10.r)
                    ),
                    child: Text(
                      "Got It!",
                      style: GoogleFonts.poppins(
                        color: AppColor.blackColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
  
        ],
      ),
    ),
  );
}