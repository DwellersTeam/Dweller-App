import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';





class SubFeatureCard extends StatelessWidget {
  const SubFeatureCard({super.key, required this.text, required this.svgAsset});
  final String text;
  final String svgAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //height: 50.h,
      //width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColor.blueColorOp,
        borderRadius: BorderRadius.circular(30.r)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(svgAsset),
          SizedBox(width: 10.w,),
          Text(
            text,
            style: GoogleFonts.bricolageGrotesque(
              color: AppColor.darkPurpleColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500
            )
          ),
        ],
      ),
    );
  }
}