import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';







class MatchListYourSwipesMenu extends StatelessWidget {
  const MatchListYourSwipesMenu({super.key, required this.onOpenProfile, required this.onUndoMatch});
  final VoidCallback onOpenProfile;
  final VoidCallback onUndoMatch;

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
          case 'Undo Match':
            onUndoMatch();
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
          value: 'Undo Match',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/svg/chat_clear.svg'),
              SizedBox(width: 10.w,),
              Text(
                'Undo Match',
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





class MatchListSwipesOnYouMenu extends StatelessWidget {
  const MatchListSwipesOnYouMenu({super.key, required this.onOpenProfile, required this.onAcceptMatch, required this.onDeclineMatch});
  final VoidCallback onOpenProfile;
  final VoidCallback onAcceptMatch;
  final VoidCallback onDeclineMatch;

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
          case 'Accept Match':
            onAcceptMatch();
            break;
          case 'Decline Match':
            onDeclineMatch();
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
          value: 'Accept Match',
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
                'Accept Match',
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
          value: 'Decline Match',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/svg/chat_clear.svg'),
              SizedBox(width: 10.w,),
              Text(
                'Decline Match',
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