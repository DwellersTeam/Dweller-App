import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/home/widget/profile(h&s)/profile_info.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';









class SeekerTabPage extends StatefulWidget {
  const SeekerTabPage({super.key, required this.user,});
  final UserModel user;

  @override
  State<SeekerTabPage> createState() => _SeekerTabPageState();
}

class _SeekerTabPageState extends State<SeekerTabPage>{
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h,),
            ///HEADER///
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: SvgPicture.asset("assets/svg/arrow_back.svg")
                  ),
                  SizedBox(width: 15.w,),
                  Text(
                    "Back",
                    style: GoogleFonts.poppins(
                      color: AppColor.blackColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),
            
            Expanded(
              child: ProfileInfo(user: widget.user,),
            )
            //
          
          ],
        ),
      )
    );
  }
}