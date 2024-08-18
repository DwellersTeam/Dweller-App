import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/search/settings/widget/general/all_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







Future<void> successBottomsheet({
  required BuildContext context,
  required String title, 

  }) async{

  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    useSafeArea: true,
    backgroundColor: AppColor.whiteColor,
    //barrierColor: Theme.of(context).colorScheme.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.r)
      )
    ),
    context: context, 
    builder: (context) {
      return Wrap(
        children: [
          Container(
            alignment: Alignment.center,
            //height: MediaQuery.of(context).size.height * 0.75,
            //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Container(
                  alignment: Alignment.center,
                  height: 7.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: AppColor.greyColor,
                    borderRadius: BorderRadius.circular(15.r)
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text(
                  '👍',
                  style: GoogleFonts.poppins(
                    color: AppColor.blackColor,
                    fontSize: 60.sp,
                    fontWeight: FontWeight.w500
                  ),
                ),
                //SizedBox(height: 20.h,),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: AppColor.neutralBlackColor,
                    fontSize: 22.sp, //16.sp
                    fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.center,
                ),
                //SizedBox(height: 60.h,),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ConfirmButton(
                    backgroundColor: AppColor.blackColorOp, 
                    textColor: AppColor.whiteColor,
                    text: 'Got it!',
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                
              ],
            ),
          ),
        ],
      );
    }
  );
}

