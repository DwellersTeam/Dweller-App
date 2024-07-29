import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class FilterHeader extends StatelessWidget {
  const FilterHeader({super.key, required this.rightText, required this.leftText});
  final String rightText;
  final String leftText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText,
          style: GoogleFonts.bricolageGrotesque(
            color: AppColor.darkPurpleColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          overflow: TextOverflow.fade,
        ),
        Text(
          rightText,
          style: GoogleFonts.bricolageGrotesque(
            color: Color.fromRGBO(107, 110, 122, 1),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }
}