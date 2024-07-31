import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';






class BookmarkMenu extends StatelessWidget {
  const BookmarkMenu({super.key, required this.onOpenProfile, required this.onSendMatchRequest, required this.onDeleteBookmark});
  final VoidCallback onOpenProfile;
  final VoidCallback onSendMatchRequest;
  final VoidCallback onDeleteBookmark;

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
          case 'Open Profile':
            onOpenProfile();
            break;
          case 'Send Match Request':
            onSendMatchRequest();
            break;
          case 'Delete Bookmark':
            onDeleteBookmark();
            break;
      
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Open Profile',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/svg/chat_profile.svg'),
              SizedBox(width: 10.w,),
              Text(
                'Open Profile',
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
          value: 'Send Match Request',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //SvgPicture.asset('assets/svg/chat_clear.svg'),
              Icon(
                CupertinoIcons.check_mark_circled_solid,
                size: 16.r,
                color: AppColor.darkPurpleColor,
              ),
              SizedBox(width: 10.w,),
              Text(
                'Send Match Request',
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
          value: 'Delete Bookmark',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/svg/chat_clear.svg'),
              SizedBox(width: 10.w,),
              Text(
                'Delete Bookmark',
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