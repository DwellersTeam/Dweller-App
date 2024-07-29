import 'dart:io';
import 'package:dweller/services/controller/create_profile/create_profile_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';





class ProfileAvatar extends StatelessWidget {
  ProfileAvatar({super.key, required this.onCameraTapped});
  final VoidCallback onCameraTapped;

  final createProfileController = Get.put(CreateProfileController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () {
            return CircleAvatar(
              backgroundColor: AppColor.whiteColor,
              radius: 55.r,
              child: CircleAvatar(
                backgroundColor: AppColor.pureLightGreyColor,
                radius: 53.r,
                backgroundImage: FileImage(
                  createProfileController.isProfileImageSelected.value ? createProfileController.imageFile.value! : 
                  File('')
                ),
              ),
            );
          }
        ),
        //camera button
        //yellow stacked container
        Positioned(
          bottom: 5.h, // Adjust this value to control how much it protrudes
          right: 0.w, //135.w
          child: InkWell(
            onTap: onCameraTapped,
            child: CircleAvatar(
              //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              /*alignment: Alignment.center,
              height: 40.h,
              width: 60.w, //130.w
              decoration: BoxDecoration(
                color: AppColor.blackColor,
                borderRadius: BorderRadius.circular(40.r)
              ),*/
              backgroundColor: AppColor.darkPurpleColor,
              radius: 17.r,
              child: Icon(
                size: 16.r,
                CupertinoIcons.camera_fill,
                color: AppColor.whiteColor,
              )
            ),
          ),
        ),
      ],
    );
  }
}