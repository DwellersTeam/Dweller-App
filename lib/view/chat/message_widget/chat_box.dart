import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';




//for the person you're chatting with
class ReceiverChatBox extends StatelessWidget {
  const ReceiverChatBox({super.key, required this.type, required this.content, required this.time, required this.profilePicture, required this.receipientName});
  final String type;
  final String content;
  final String time;
  final String profilePicture;
  final String receipientName;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        profilePicture.isEmpty
        ?CircleAvatar(
          radius: 15.r, //24.r,
          backgroundColor: Colors.grey.withOpacity(0.1),
          //backgroundImage: const AssetImage("assets/images/lionel.jpg"),
          child: Text(
            getFirstLetter(receipientName),
            style: GoogleFonts.poppins(
              color: AppColor.blackColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500
            ),
          ),
        )
        :CircleAvatar(
          radius: 15.r, //24.r,
          backgroundColor: Colors.grey.withOpacity(0.1),
          backgroundImage: NetworkImage(profilePicture),
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
                content,
                //'Hello there 👋, i noticed you like surfing',
                style: GoogleFonts.poppins(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
                )
              ),
              SizedBox(height: 5.h,),
              Text(
                time,
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
  const SenderChatBox({super.key, required this.type, required this.content, required this.time});
  final String type;
  final String content;
  final String time;

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
            content,
            //'Yup! I do. Just my be my fav activity in Vinyl.',
            style: GoogleFonts.poppins(
              color: AppColor.whiteColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400
            )
          ),
          SizedBox(height: 5.h,),
          Text(
            time,
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