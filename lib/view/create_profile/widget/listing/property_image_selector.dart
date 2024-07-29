import 'package:dotted_border/dotted_border.dart';
import 'package:dweller/services/controller/home/listing/listing_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';









class ImageButton1 extends StatelessWidget {
  ImageButton1({super.key,});

  final createProfileController = Get.put(ListingController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          createProfileController.pickFirstPropertyImageFromGallery(context: context);
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
                      image: createProfileController.isPropImage1Selected.value ? DecorationImage(
                        image: FileImage(
                          /*errorBuilder: (context, url, error) => Icon(
                            Icons.error,
                            color: swapSpaceLightGreenColor,
                          ),*/
                          createProfileController.firstPropImage.value!,
                          //filterQuality: FilterQuality.high,                  
                        ),
                        fit: BoxFit.contain
                      )
                      :DecorationImage(
                        image: NetworkImage(createProfileController.propImage1.text),
                        fit: BoxFit.contain
                      )
                    ),
                    height: 180.h,
                    width: double.infinity, //200.w,
                    child: createProfileController.isPropImage1Selected.value ? SizedBox() : Text(
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



class ImageButton2 extends StatelessWidget {
  ImageButton2({super.key,});

  final createProfileController = Get.put(ListingController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          createProfileController.pickSecondPropertyImageFromGallery(context: context);
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
                      image: createProfileController.isPropImage2Selected.value ? DecorationImage(
                        image: FileImage(
                          /*errorBuilder: (context, url, error) => Icon(
                            Icons.error,
                            color: swapSpaceLightGreenColor,
                          ),*/
                          createProfileController.secondPropImage.value!,
                          //filterQuality: FilterQuality.high,                  
                        ),
                        fit: BoxFit.contain
                      )
                      :DecorationImage(
                        image: NetworkImage(createProfileController.propImage2.text),
                        fit: BoxFit.contain
                      )
                    ),
                    height: 180.h,
                    width: double.infinity, //200.w,
                    child: createProfileController.isPropImage2Selected.value ? SizedBox() : Text(
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


class ImageButton3 extends StatelessWidget {
  ImageButton3({super.key,});

  final createProfileController = Get.put(ListingController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          createProfileController.pickThirdPropertyImageFromGallery(context: context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "3",
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
                      image: createProfileController.isPropImage3Selected.value ? DecorationImage(
                        image: FileImage(
                          /*errorBuilder: (context, url, error) => Icon(
                            Icons.error,
                            color: swapSpaceLightGreenColor,
                          ),*/
                          createProfileController.thirdPropImage.value!,
                          //filterQuality: FilterQuality.high,                  
                        ),
                        fit: BoxFit.contain
                      )
                      :DecorationImage(
                        image: NetworkImage(createProfileController.propImage3.text),
                        fit: BoxFit.contain
                      )
                    ),
                    height: 180.h,
                    width: double.infinity, //200.w,
                    child: createProfileController.isPropImage3Selected.value ? SizedBox() : Text(
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