import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';






class ChatEmptyState extends StatelessWidget {
  const ChatEmptyState({super.key, required this.title, required this.subtitle, this.button});
  final String title;
  final String subtitle;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 80.h,),
          SvgPicture.asset('assets/svg/no_matches.svg'),
          SizedBox(height: 20.h,),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: AppColor.blackColor,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h,),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: AppColor.blackColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.h,),
          button ?? SizedBox()
        ],
      ),
    );
  }
}