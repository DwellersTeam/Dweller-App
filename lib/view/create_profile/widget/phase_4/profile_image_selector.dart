import 'package:dotted_border/dotted_border.dart';
import 'package:dweller/services/controller/create_profile/create_profile_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class ImageSelector1 extends StatelessWidget {
  ImageSelector1({super.key,});

  final createProfileController = Get.put(CreateProfileController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          createProfileController.pickFirstSubImageFromGallery(context: context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "1",
              style: GoogleFonts.poppins(
                color: AppColor.semiDarkGreyColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500
              )
            ),
            SizedBox(height: 20.h,),
            Obx(
              () {
                return DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10.r),
                  color: AppColor.semiDarkGreyColor,
                  dashPattern: [8, 8,],
                  strokeWidth: 2,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      //color: Colors.transparent, //AppColor.whiteColor,
                      image: createProfileController.isSubImage1Selected.value ? DecorationImage(
                        image: FileImage(
                          /*errorBuilder: (context, url, error) => Icon(
                            Icons.error,
                            color: swapSpaceLightGreenColor,
                          ),*/
                          createProfileController.firstSubImage.value!,
                          //filterQuality: FilterQuality.high,                  
                        ),
                        fit: BoxFit.contain
                      )
                      :DecorationImage(
                        image: NetworkImage(createProfileController.firstSubImageController.text),
                        fit: BoxFit.contain
                      )
                    ),
                    height: 180.h,
                    width: double.infinity, //200.w,
                    child: createProfileController.isSubImage1Selected.value ? SizedBox() : Text(
                      '+',
                      style: GoogleFonts.poppins(
                        color: AppColor.semiDarkGreyColor,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  )
                    
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}



class ImageSelector2 extends StatelessWidget {
  ImageSelector2({super.key,});

  final createProfileController = Get.put(CreateProfileController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          createProfileController.pickSecondSubImageFromGallery(context: context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "2",
              style: GoogleFonts.poppins(
                color: AppColor.semiDarkGreyColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500
              )
            ),
            SizedBox(height: 20.h,),
            Obx(
              () {
                return DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10.r),
                  color: AppColor.semiDarkGreyColor,
                  dashPattern: [8, 8,],
                  strokeWidth: 2,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      //color: Colors.transparent, //AppColor.whiteColor,
                      image: createProfileController.isSubImage2Selected.value ? DecorationImage(
                        image: FileImage(
                          /*errorBuilder: (context, url, error) => Icon(
                            Icons.error,
                            color: swapSpaceLightGreenColor,
                          ),*/
                          createProfileController.secondSubImage.value!,
                          //filterQuality: FilterQuality.high,                  
                        ),
                        fit: BoxFit.contain
                      )
                      :DecorationImage(
                        image: NetworkImage(createProfileController.secondSubImageController.text),
                        fit: BoxFit.contain
                      )
                    ),
                    height: 180.h,
                    width: double.infinity, //200.w,
                    child: createProfileController.isSubImage2Selected.value ? SizedBox() : Text(
                      '+',
                      style: GoogleFonts.poppins(
                        color: AppColor.semiDarkGreyColor,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  )
                    
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}