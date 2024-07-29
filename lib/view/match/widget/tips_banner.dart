import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';







class TipsBanner extends StatelessWidget {
  const TipsBanner({super.key, required this.onCancelForLife, required this.onClose, required this.text});
  final VoidCallback onCancelForLife;
  final VoidCallback onClose;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          /*BoxShadow(
            color: AppColor.darkGreyColor.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),*/
          BoxShadow(
            color: AppColor.lightGreyColor.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              color: AppColor.blackColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
          ),
          SizedBox(height: 20.h), //greyColorLight
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                onPressed: onCancelForLife,
                backgroundColor: AppColor.greyColorLight,
                height: 45.h,
                width: 190.w, //200.w
                borderRadiusGeometry: BorderRadius.circular(40.r),
                child: Text(
                  "Don't show this again",
                  style: GoogleFonts.poppins(
                    color: AppColor.blackColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
              SizedBox(width: 15.w,),
              CustomButton(
                onPressed: onClose,
                backgroundColor: AppColor.redColorLight,
                height: 45.h,
                width: 90.w,
                borderRadiusGeometry: BorderRadius.circular(40.r),
                child: Text(
                  "Close",
                  style: GoogleFonts.poppins(
                    color: AppColor.blackColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
            ],
          )
        ]
      )
    );
  }
}