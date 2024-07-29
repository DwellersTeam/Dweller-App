import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';







class FeaturesBox extends StatelessWidget {
  const FeaturesBox({super.key, required this.svgImage, required this.title, required this.subtitle});
  final SvgPicture svgImage;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(15.r)
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical:  20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              svgImage,
              SizedBox(width: 6.w,),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: AppColor.darkPurpleColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600
                )
              )
            ],
          ),
          SizedBox(height: 15.h,),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: AppColor.chatGreyColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500
            ),
            overflow: TextOverflow.clip,
          )
        ],
      )
    );
  }
}