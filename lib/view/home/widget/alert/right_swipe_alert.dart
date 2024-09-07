import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/services/repository/match_service/match_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/home/widget/alert/match_made_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';




final MatchService matchService = Get.put(MatchService());

Future<void> rightSwipeAlert({required BuildContext context, required UserModel user}) async {
  await Get.dialog(
    transitionCurve: const ElasticOutCurve(),
    useSafeArea: true,
    barrierDismissible: false,
    AlertDialog.adaptive(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      backgroundColor: AppColor.neutralBlackColor,
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
                SizedBox(height: 80.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    user.displayPicture.isNotEmpty ?
                    CircleAvatar(
                      radius: 28.r,
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      backgroundImage: NetworkImage(user.displayPicture),
                      /*child: Text(
                        'J',
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),*/
                    )
                    :CircleAvatar(
                      radius: 28.r,
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      child: Text(
                        getFirstLetter(user.firstname),
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    
                    //property picture
                    /*SizedBox(width: 10.w,),
                    CircleAvatar(
                      radius: 28.r,
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
                    ),*/
  
                  ],
                ),
                SizedBox(height: 20.h,),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${user.age} yo |',
                        style: GoogleFonts.poppins(
                          color: AppColor.whiteColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400
                        )
                      ),
                      TextSpan(
                        text: ' ${user.location.address}',
                        style: GoogleFonts.poppins(
                          color: AppColor.whiteColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500
                        )
                      )
                    ]
                  )
                ),
                SizedBox(height: 30.h,),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Match with ',
                        style: GoogleFonts.poppins(
                          color: AppColor.whiteColor,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w400
                        )
                      ),
                      TextSpan(
                        text: '\n${user.firstname} ${user.lastname}?',
                        style: GoogleFonts.poppins(
                          color: AppColor.whiteColor,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500
                        )
                      )
                    ]
                  )
                ),
                SizedBox(height: 100.h,),

                //Custom Elevated Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //button 1
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0.h),
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(10.r)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "No Dismiss",
                                  style: GoogleFonts.poppins(
                                    color: AppColor.blackColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              Icon(
                                size: 20.r,
                                color: AppColor.blackColor,
                                CupertinoIcons.arrow_left,
                                //Icons.arrow_back_rounded
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    //button 2
                    Expanded(
                      child: InkWell(
                        onTap: () async{
                          //dismiss previous dialog then navigate to the next dialog
                          await matchService.sendMatchRequest(
                            context: context, 
                            userId: user.id, 
                            direction: "right",
                            onSuccess: () {
                              Get.back();
                              matchMadeAlert(user: user);
                            },
                            onFailure: () {},
                          );
                    
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0.h),
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: AppColor.blueColorDialogBox,
                            borderRadius: BorderRadius.circular(10.r)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () {
                                  return matchService.isLoading.value ? const Loader2()/*CircularProgressIndicator.adaptive(
                                    strokeWidth: 2.0,
                                    backgroundColor: AppColor.darkPurpleColor,
                                    strokeCap: StrokeCap.round,
                                  )*/ : Text(
                                    "Yes Match!",
                                    style: GoogleFonts.poppins(
                                      color: AppColor.blackColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                }
                              ),
                              SizedBox(width: 10.w,),
                              Icon(
                                size: 20.r,
                                color: AppColor.blackColor,
                                CupertinoIcons.check_mark
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
  
        ],
      ),
    ),
  );
}