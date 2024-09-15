import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/main/mainpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';




class DwellerAppBar extends StatelessWidget {
  const DwellerAppBar({super.key, this.actionIcon});
  final Widget? actionIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //height: 90.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: const BoxDecoration(
        color: AppColor.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: actionIcon == null ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: SvgPicture.asset("assets/svg/arrow_back.svg")
          ),
          actionIcon ?? const SizedBox.shrink()
        ],
      ),
    );
  }
}



class DwellerAppBarHost extends StatelessWidget {
  const DwellerAppBarHost({super.key, this.actionIcon, required this.onPropertyTapped});
  final Widget? actionIcon;
  final VoidCallback onPropertyTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //height: 90.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: const BoxDecoration(
        color: AppColor.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: SvgPicture.asset("assets/svg/arrow_back.svg")
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: onPropertyTapped,
                child: Icon(
                  color: AppColor.blueColor,
                  size: 24.r,
                  Icons.add_home_rounded
                )
              ),
              SizedBox(width: 10.w,),
              actionIcon ?? const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}