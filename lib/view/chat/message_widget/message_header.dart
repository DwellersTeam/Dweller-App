import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







class MessageHeader extends StatelessWidget {
  const MessageHeader({super.key, required this.menuBar, required this.name, required this.status});
  //final VoidCallback onMorePresed;
  final Widget menuBar;
  final String name;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //height: 90.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: SvgPicture.asset("assets/svg/arrow_back.svg")
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: GoogleFonts.bricolageGrotesque(
                    color: AppColor.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500
                  )
                ),
                SizedBox(height: 10.h,),
                Text(
                  status,
                  style: GoogleFonts.poppins(
                    color: status == "Online" ?AppColor.greenColor : AppColor.chatGreyColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600
                  )
                ),
              ],
            ),
          ),
          menuBar
          /*InkWell(
            onTap: onMorePresed,
            child: SvgPicture.asset("assets/svg/more.svg")
          ),*/
        ],
      ),
    );
  }
}