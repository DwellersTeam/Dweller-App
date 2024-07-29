import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';




//for the person you're chatting with
class ReceiverChatBox extends StatelessWidget {
  const ReceiverChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 15.r, //24.r,
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
        ),
        SizedBox(width: 4.w,),
        Container(
          alignment: Alignment.center,
          //height: 50.h,
          //width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: AppColor.blueColorOp,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r), bottomRight: Radius.circular(20.r),)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello there 👋, i noticed you like surfing',
                style: GoogleFonts.poppins(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
                )
              ),
              SizedBox(height: 5.h,),
              Text(
                '4:30 AM',
                style: GoogleFonts.poppins(
                  color: AppColor.chatTimeGreyColor,
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w600
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
}




//for the person sending the message
class SenderChatBox extends StatelessWidget {
  const SenderChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.center,
      //height: 50.h,
      //width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColor.blueColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r), bottomLeft: Radius.circular(20.r),)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Yup! I do. Just my be my fav activity in Vinyl.',
            style: GoogleFonts.poppins(
              color: AppColor.whiteColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400
            )
          ),
          SizedBox(height: 5.h,),
          Text(
            '5:30 AM',
            style: GoogleFonts.poppins(
              color: AppColor.whiteColor,
              fontSize: 8.sp,
              fontWeight: FontWeight.w600
            )
          ),
          //SizedBox(height: 3.h,),
          //isSeen
          /*Icon(
            Icons.done_all_rounded,
            color: Colors.grey,
            size: 20.r,
          ),
          Icon(
            CupertinoIcons.checkmark_alt,
            color: Colors.grey,
            size: 20.r,
          ),*/
        ],
      ),
    );
  }
}