import 'dart:developer';

import 'package:dweller/services/controller/auth/auth_controller.dart';
import 'package:dweller/services/repository/auth_service/auth_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/view/auth/forgot_password/forgot_password_page_2.dart';
import 'package:dweller/view/auth/login/page/login_page.dart';
import 'package:dweller/view/auth/widgets/button/auth_button.dart';
import 'package:dweller/view/auth/widgets/textfields/auth_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class ForgotPasswordPage1 extends StatelessWidget {
  ForgotPasswordPage1({super.key});

  final authController = Get.put(AuthController());
  final authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.whiteColor,
      body: CustomPaint(
        /*decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/authdesign.png'),
            fit: BoxFit.cover, // Adjust the image's size to cover the entire container
          ),
        ),*/
        painter: TopBlueSectionPainter(),
        child: Obx(
          () {
            return authService.isLoading.value ? const Loader() : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //34% of the screen
                  SizedBox(height: MediaQuery.of(context).size.height * 0.30),
                  Text(
                    'reset your password',
                    style: GoogleFonts.bricolageGrotesque(
                      color: AppColor.blackColor,
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w500
                    ),
                    //textAlign: TextAlign.center,
                  ),
                  //SizedBox(height: 10.h,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'An OTP to reset your password will be sent to your email',
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      //SizedBox(height: 20.h,),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      Text(
                        'Email Address',
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      AuthTextField(
                        onChanged: (val) {
                          authController.forgotPasswordEmailController.text = val;
                          log('${authController.forgotPasswordEmailController.text}');
                        },
                        onFocusChanged: (p0) {},
                        hintText: 'Your valid email address',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        textController: authController.forgotPasswordEmailController,
                        icon: CupertinoIcons.mail_solid,
                        validator: (val) {
                          return authController.validateEmail(value: val!);
                        }
                      ),
                      SizedBox(height: 60.h,),
                  
                      //button
                      AuthButton(
                        textColor: AppColor.whiteColor,
                        onPressed: () {                     
                          if(authController.forgotPasswordEmailController.text.isNotEmpty) {
                            authService.forgotPasswordEndpoint(
                              context: context, 
                              email: authController.forgotPasswordEmailController.text, 
                              nextPage: const ForgotPasswordPage2(),
                            );
                          }
                          else{
                            showMessagePopup(
                              title: 'Uh oh', 
                              message: 'field must not be empty', 
                              buttonText: 'Okay', 
                            );
                          }
                        },
                        backgroundColor: AppColor.blackColor,
                        text: 'Send OTP',
                      ),
                  
                      SizedBox(height: 10.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have an account?',
                            style: GoogleFonts.poppins(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(width: 5.w,),
                          InkWell(
                            onTap: () {
                              Get.off(() => const LoginPage(), transition: Transition.rightToLeft);                       
                            },
                            child: Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                color: AppColor.darkPurpleColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                //decoration: TextDecoration.underline,
                                //decorationColor: AppColor.redColor
                              ),
                            ),
                          )
                        ]
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        ),
      ),
  
    );
  }
}