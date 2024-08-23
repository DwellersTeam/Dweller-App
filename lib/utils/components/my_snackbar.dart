import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';





Future<void> showMySnackBar({required BuildContext context, required String message, required Color backgroundColor}) async{
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.down,
      backgroundColor: backgroundColor,
      showCloseIcon: false,
      content: Text(
        textAlign: TextAlign.center,
        message,
        style: GoogleFonts.inter(
          color: AppColor.whiteColor,
          fontSize: 13.sp,
          fontWeight: FontWeight.normal
        ),
      ),
      duration: Duration(seconds: 2), // Adjust the duration as needed
      /*action: SnackBarAction(
        label: 'CLOSE',
        onPressed: () {
          // Perform an action when the user presses the action button
        },
      ),*/
    ),
  );
}




Future<void> showMessagePopup({ 
  required String title,
  required String message,
  required String buttonText, 
  //required BuildContext context,
  }) async{
  Get.dialog(
    useSafeArea: true,
    AlertDialog.adaptive(
        //barrierDismissible: true,
        elevation: 2,
        backgroundColor: const Color.fromRGBO(10, 4, 43, 1),
        //contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
        content: Wrap(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.bricolageGrotesque(
                      color: const Color.fromRGBO(235, 252, 255, 1),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Text(
                    message,
                    style: GoogleFonts.poppins(
                      color: const Color.fromRGBO(235, 252, 255, 1),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400
                    ),
                    overflow: TextOverflow.clip,
                  ),
              
                  //SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                  SizedBox(height: 20.h),
                    
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: const Color.fromRGBO(235, 252, 255, 1),
                      ),
                      height: 50.h,
                      //width: 110.w,
                      width: double.infinity,
                      child: Text(
                        buttonText,
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600
                        )
                      )
                    ),
                  ),   
              
                ],
              ),
            ),
          ],
        ),
    )
  
  );
}




Future<void> showPropertyAlertPopup({ 
  required BuildContext context,
  required VoidCallback onTap,
  }) async{
  Get.dialog(
    useSafeArea: true,
    AlertDialog.adaptive(
        //barrierDismissible: true,
        elevation: 2,
        backgroundColor: const Color.fromRGBO(50, 92, 191, 1),
        //contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
        content: Wrap(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          CupertinoIcons.xmark_circle,
                          color: Color.fromRGBO(235, 252, 255, 1),
                          size: 24.r
                        ),
                      )
                    ]
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/prop_alert.svg'),
                      SizedBox(width: 20.w,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Property Listing',
                              style: GoogleFonts.bricolageGrotesque(
                                color: const Color.fromRGBO(235, 252, 255, 1),

                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 10.h,),
                            Text(
                              'Welcome to Dweller. List your property to match with a Seeker and help other Dwellers find you',
                              style: GoogleFonts.poppins(
                                color: const Color.fromRGBO(235, 252, 255, 1),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400
                              ),
                              overflow: TextOverflow.clip,
                            ),

                          ],
                        ),
                      )
                    ],
                  ),

              
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                    
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: const Color.fromRGBO(235, 252, 255, 1),
                      ),
                      height: 50.h,
                      //width: 110.w,
                      width: double.infinity,
                      child: Text(
                        'List property',
                        style: GoogleFonts.poppins(
                          color: AppColor.darkPurpleColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600
                        )
                      )
                    ),
                  ),   
              
                ],
              ),
            ),
          ],
        ),
      )
  );
    
  
}