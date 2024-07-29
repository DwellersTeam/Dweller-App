import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';







class PropertyFee extends StatelessWidget {
  const PropertyFee({super.key, required this.fee});
  final String fee;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      //padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      height: 60.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.blueColorOp,
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(color: AppColor.blueColorOp)
      ),
      duration: const Duration(milliseconds: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              "Rent",
              style: GoogleFonts.poppins(
                color: AppColor.blackColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500
              )
            ),
          ),
          SizedBox(width: 20.w,),
          Expanded(
            child: Container(
              //padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
              //padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.blackColor,
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(color: AppColor.blackColor)
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "$fee  ",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.whiteColor
                      )
                    ),
                    TextSpan(
                      text: "(Total before split)",
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.whiteColor
                      )
                    )
                  ]
                )
              )
            ),
          ),

        ],
      )
    );
  }
}