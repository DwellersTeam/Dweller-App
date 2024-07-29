import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';





class ChatMenu extends StatelessWidget {
  const ChatMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      //elevation: 2,
      //popUpAnimationStyle: AnimationStyle(duration: Duration(milliseconds: 200), curve: ElasticInOutCurve()),
      enableFeedback: true,
      color: AppColor.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r)
      ),
      onSelected: (String result) {
        switch (result) {
          case 'View Profile':
            //_viewProfile(context);
            break;
          case 'Clear Chats':
            //_viewProfile(context);
            break;
          case 'Block User':
            //_blockUser(context);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'View Profile',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/svg/chat_profile.svg'),
              SizedBox(width: 10.w,),
              Text(
                'View Profile',
                style: GoogleFonts.poppins(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
                )
              )
            ],
          )
        ),
        PopupMenuItem<String>(
          value: 'Clear Chats',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/svg/chat_clear.svg'),
              SizedBox(width: 10.w,),
              Text(
                'Clear Chats',
                style: GoogleFonts.poppins(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
                )
              )
            ],
          )
        ),
        PopupMenuItem<String>(
          value: 'Block User',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/svg/chat_delete.svg'),
              SizedBox(width: 10.w,),
              Text(
                'Block User',
                style: GoogleFonts.poppins(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
                )
              )
            ],
          )
        ),
      ],
    );
  }
}