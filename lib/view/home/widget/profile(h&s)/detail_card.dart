import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';



class ProfileDetailCard extends StatelessWidget {
  const ProfileDetailCard({super.key, required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      //alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      //height: 60.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColor.whiteColor),
        boxShadow: [
          BoxShadow(
            color: AppColor.lightGreyColor.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      duration: const Duration(milliseconds: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: AppColor.blackColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          child
        ]
      )
    );
  }
}