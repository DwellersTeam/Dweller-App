import 'dart:developer';

import 'package:dweller/services/controller/chat/chat_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/chat/message_widget/options_sheet.dart';
import 'package:dweller/view/chat/schedule_task/send_photo/send_photo_bottomsheet.dart';
import 'package:dweller/view/chat/schedule_task/task_screen.dart';
import 'package:dweller/view/search/widget/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';







class MessageTextField extends StatelessWidget {
  MessageTextField({super.key, required this.onSend, required this.receipientId});
  final VoidCallback onSend;
  final String receipientId;

  final controller = Get.put(ChatPageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //height: 90.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () {
              return controller.imageUrlController.value.isEmpty ? const SizedBox.shrink()
              :Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  alignment: Alignment.center,
                  //height: 200.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: AppColor.pureLightGreyColor,
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: NetworkImage(controller.imageUrlController.value),
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.contain
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        controller.imageUrlController.value = "";
                      },
                      child: Icon(
                        size: 16.r,
                        color: AppColor.darkPurpleColor,
                        CupertinoIcons.xmark
                      ),
                    ),
                  ),
                ),
              );
            }
          ),

          Obx(
            () => controller.imageUrlController.value.isEmpty ? const SizedBox.shrink() : SizedBox(height: 20.h,)
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /*Obx(
                () {
                  return SpeedDial(
                    switchLabelPosition: true,
                    direction: SpeedDialDirection.up,
                    foregroundColor: AppColor.whiteColor,
                    backgroundColor: AppColor.whiteColor,  //pureLightGreyColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.r))
                    ),
                    elevation: 0,
                    overlayOpacity: 0.4,
                    overlayColor: AppColor.blackColor,
                    child: Icon(
                      controller.isIconTapped.value 
                      ?CupertinoIcons.xmark 
                      :CupertinoIcons.add,
                      size: 30.r,
                      color: AppColor.blackColor
                    ),
                    onOpen: () {
                      controller.isIconTapped.value = true;
                    },
                    onClose: () {
                      controller.isIconTapped.value = false;
                    },
                    spaceBetweenChildren: 30,
                    //childPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    // Menu items
                    children: [
                      //1
                      SpeedDialChild(
                        label: "Schedule Task",
                        labelStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: AppColor.blackColor
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.r))
                        ),
                        onTap: () {
                          Get.to(() => TaskScreen());
                        },
                        //child: SvgPicture.asset('assets/svg/schedule_task.svg')
                      ),
                      //2
                      SpeedDialChild(
                        label: "Add picture",
                        labelStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: AppColor.blackColor
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.r))
                        ),
                        onTap: () {
                          sendPhotoTextBottomsheet(
                            context: context,
                            controller: controller
                          );
                        },
                        //child: SvgPicture.asset('assets/svg/add_picture.svg')
                      )
                    ],
                  );
                }
              ),*/
        
          
              InkWell(
                onTap: () {
                  messageOptionBottomsheet(
                    context: context,
                    controller: controller,
                    receipientId: receipientId
                  );
                },
                child: Icon(
                  CupertinoIcons.add,
                  size: 24.r,
                  color: AppColor.blackColor
                )
              ),
              SizedBox(width: 5.w,),
              Expanded(
                child: MessageTextInputfield(
                  textController: controller.messageTextController,
                  onChanged: (val) {
                    controller.messageTextController.text = val;
                    log(controller.messageTextController.text);
                  },
                  onFieldSubmitted: (val) {},
                  hintText: 'Say something',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.none,
                  //suffixIcon: 
                  /*InkWell(
                    onTap: () {},
                    child: Icon(
                      size: 24.r,
                      color: AppColor.semiDarkGreyColor,
                      CupertinoIcons.photo_camera
                    )
                    /*SvgPicture.asset(
                      'assets/svg/camera_icon.svg',
                      height: 30.h,
                      width: 30.w,
                    ),*/
                  ),*/
                
                ),
              ),
              SizedBox(width: 5.w,),
              FloatingActionButton(
                enableFeedback: true,
                elevation: 0,
                foregroundColor: AppColor.blueColor,
                backgroundColor: AppColor.blueColor,
                onPressed: onSend,
                shape: const CircleBorder(),
                child: Icon(
                  size: 20.r,
                  color: AppColor.whiteColor,
                  CupertinoIcons.paperplane_fill
                ),
              )     
            
            ]
          ),
        ],
      )
    );
  }
}