import 'package:dweller/services/controller/auth/auth_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/view/auth/login/page/login_page.dart';
import 'package:dweller/view/auth/widgets/button/auth_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







class ForgotPasswordPage4 extends StatelessWidget {
  ForgotPasswordPage4({super.key});

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        /*decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/authdesign.png'),
            fit: BoxFit.cover, // Adjust the image's size to cover the entire container
          ),
        ),*/
        painter: TopBlueSectionPainter(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          scrollDirection: Axis.vertical,
          physics:const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //20% of the screen
              SizedBox(height: MediaQuery.of(context).size.height * 0.20),
            
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h,),
                  Text(
                    '👍',
                    style: GoogleFonts.poppins(
                      color: AppColor.blackColor,
                      fontSize: 60.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  //SizedBox(height: 20.h,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Text(
                    'password successfully reset!',
                    style: GoogleFonts.bricolageGrotesque(
                      color: AppColor.blackColor,
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                  ),
                  //SizedBox(height: 60.h,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  
                  //button
                  AuthButton(
                    onPressed: () {
                      Get.offAll(() => LoginPage(), transition: Transition.rightToLeft);
                    },
                    backgroundColor: AppColor.blackColor,
                    textColor: AppColor.whiteColor,
                    text: 'Login',
                  )
              
                ],
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}