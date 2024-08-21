import 'package:dweller/services/controller/chat/chat_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/chat/schedule_task/add_task/add_task_overlay.dart';
import 'package:dweller/view/chat/schedule_task/send_photo/send_photo_bottomsheet.dart';
import 'package:dweller/view/chat/schedule_task/task_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







//Upload Photo Bottomsheet
Future<void> messageOptionBottomsheet({
  required BuildContext context,
  required String receipientId,
  required ChatPageController controller,
}) async {
  final size = MediaQuery.of(context).size;
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
        top: Radius.circular(15.r)
      )
    ),
    context: context, 
    builder: (context) {
      return Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              //image: DecorationImage(image: AssetImage(''),),
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      //image: DecorationImage(image: AssetImage(''),),
                      color: AppColor.greyColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    height: 7.h,
                    width: 40.w,
                  ),
                ),

                SizedBox(height: size.height * 0.03,),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //1
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              sendPhotoTextBottomsheet(
                                context: context,
                                controller: controller
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: size.height * 0.2,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                //image: DecorationImage(image: AssetImage(''),),
                                color: AppColor.greyColor, ///pureLightGreyColor,
                                borderRadius: BorderRadius.circular(20.r)
                              ),
                              child: Icon(
                                size: 40.r,
                                CupertinoIcons.camera_viewfinder,
                                color: AppColor.blackColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Text(
                            'Add Picture',
                            style: GoogleFonts.poppins(
                              color: AppColor.blackColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 20.w,),

                    //2
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              Get.to(() => TaskScreen(
                                receipientId: receipientId,
                              ));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: size.height * 0.2,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                //image: DecorationImage(image: AssetImage(''),),
                                color: AppColor.greyColor,  //.pureLightGreyColor,
                                borderRadius: BorderRadius.circular(20.r)
                              ),
                              child: Icon(
                                size: 40.r,
                                CupertinoIcons.doc_text_fill,
                                color: AppColor.blackColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Text(
                            'Schedule Task',
                            style: GoogleFonts.poppins(
                              color: AppColor.blackColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                SizedBox(height: size.height * 0.02,),
              ],
            ),
          ),
        ],
      );
    }
  );
}

