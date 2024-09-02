import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';




//for the person you're chatting with
class ReceiverChatBox extends StatelessWidget {
  const ReceiverChatBox({super.key, required this.imageUrl, required this.content, required this.time, required this.profilePicture, required this.receipientName});
  final String imageUrl;
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
        
        //wrap with expanded
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7, // Max 70% of screen width
            ),
            child: Container(
              //alignment: Alignment.center,
              //height: 50.h,
              //width: double.infinity,
              padding: imageUrl.isEmpty 
              ? EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h)
              : EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColor.blueColorOp,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r), bottomRight: Radius.circular(20.r),)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageUrl.isEmpty
                  ? const SizedBox.shrink()
                  :Container(
                    alignment: Alignment.center,
                    //height: 200.h,
                    //width: double.infinity, 
                    decoration: BoxDecoration(
                      color: AppColor.pureLightGreyColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                      errorWidget: (context, url, error) {
                        log("error loading image: $error");
                        return Text(
                          error.toString(),
                          style: GoogleFonts.poppins(
                            color: AppColor.darkGreyColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400
                          ),
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                    ),
                  ),
                  imageUrl.isEmpty
                  ? const SizedBox.shrink()
                  :SizedBox(height: 5.h,),
                  Text(
                    content,
                    //'Hello there 👋, i noticed you like surfing',
                    style: GoogleFonts.poppins(
                      color: AppColor.blackColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 5.h,),
                  Text(
                    time,
                    style: GoogleFonts.poppins(
                      color: AppColor.chatTimeGreyColor,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w600
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}




//for the person sending the message
class SenderChatBox extends StatelessWidget {
  const SenderChatBox({super.key, required this.imageUrl, required this.content, required this.time});
  final String imageUrl;
  final String content;
  final String time;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7, // Max 70% of screen width
      ),
      child: Container(
        //alignment: Alignment.center,
        //height: 50.h,
        //width: double.infinity,
        padding: imageUrl.isEmpty 
          ? EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h)
          : EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColor.blueColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r), bottomLeft: Radius.circular(20.r),)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            imageUrl.isEmpty
            ? const SizedBox.shrink()
            :Container(
              alignment: Alignment.center,
              //height: 200.h,
              width: double.infinity, 
              decoration: BoxDecoration(
                color: AppColor.pureLightGreyColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
                errorWidget: (context, url, error) {
                  log("error loading image: $error");
                  return Text(
                    error.toString(),
                    style: GoogleFonts.poppins(
                      color: AppColor.darkGreyColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400
                    ),
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
            ),
            imageUrl.isEmpty
            ? const SizedBox.shrink()
            :SizedBox(height: 5.h,),
      
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
      ),
    );
  }
}