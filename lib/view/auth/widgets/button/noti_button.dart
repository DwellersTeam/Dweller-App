import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';






class CloseNotiButton extends StatelessWidget {
  const CloseNotiButton({super.key, required this.onClosed, this.width, required this.text});
  final VoidCallback onClosed;
  final double? width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClosed,
      child: Container(
        height: 60.h,
        width: width,
        alignment: Alignment.center,
        //padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r), // Button border radius
          border: Border.all(width: 2.0, color: AppColor.darkGreyColor)
        ),
    
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 15.w,),
          Text(
            text, //'Close Notification',
            style: GoogleFonts.poppins(
              color: AppColor.blackColorOp,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600
            )
          ),
          SizedBox(width: 30.w,),
          Icon(
            size: 20.r,
            CupertinoIcons.xmark,
            color: AppColor.blackColorOp,
          )
        ],
      ),
    ),
    );
  }
}