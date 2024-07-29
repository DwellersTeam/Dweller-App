import 'package:dweller/services/controller/auth/auth_controller.dart';
import 'package:dweller/services/repository/auth_service/auth_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/view/auth/forgot_password/forgot_password_page_4.dart';
import 'package:dweller/view/auth/widgets/button/auth_button.dart';
import 'package:dweller/view/auth/widgets/textfields/auth_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







class ForgotPasswordPage3 extends StatelessWidget {
  ForgotPasswordPage3({super.key});

  final authController = Get.put(AuthController());
  final authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: TopBlueSectionPainter(),
        child: Obx(
          () {
            return authService.isLoading.value ? const Loader() : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              scrollDirection: Axis.vertical,
              physics:const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //22% of the screen
                  SizedBox(height: MediaQuery.of(context).size.height * 0.23),
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
                        'Create your new password',
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      //SizedBox(height: 20.h,),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      Text(
                        'Password',
                        style: GoogleFonts.nunito(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      AuthPasswordTextField(
                        onChanged: (val) {},
                        onFocusChanged: (p0) {},
                        hintText: 'Your password',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textController: authController.forgotPasswordNewPasswordController,
                        icon: Icon(
                          Icons.lock, 
                          color: AppColor.semiDarkGreyColor,
                          size: 24.r,
                        ),
                        isObscured: false,
                        validator: (val) {
                          return authController.validatePassword(value: val!);
                        }
                      ),
                  
                      SizedBox(height: 20.h,),
                  
                      Text(
                        'Confirm Password',
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      AuthPasswordTextField(
                        onChanged: (val) {},
                        onFocusChanged: (p0) {},
                        hintText: 'Re-type your password',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        textController: authController.forgotPasswordConfirmNewPasswordController,
                        icon: Icon(
                          Icons.lock, 
                          color: AppColor.semiDarkGreyColor,
                          size: 24.r,
                        ),
                        isObscured: false,
                        validator: (val) {
                          return authController.validateConfirmPassword(firstValue: authController.forgotPasswordNewPasswordController.text, secondValue: val!);
                        }
                      ),
                  
                      SizedBox(height: 70.h,),
                  
                      //button
                      AuthButton(
                        onPressed: () {
                          Get.to(() => ForgotPasswordPage4(), transition: Transition.rightToLeft);
                          if(authController.forgotPasswordNewPasswordController.text.isNotEmpty && authController.forgotPasswordConfirmNewPasswordController.text.isNotEmpty) {
                            authService.resetPasswordEndpoint(
                              context: context, 
                              email: authController.forgotPasswordEmailController.text, 
                              otp: authController.forgotPasswordOTPController.text,
                              password: authController.forgotPasswordNewPasswordController.text,
                              confirmPassword: authController.forgotPasswordConfirmNewPasswordController.text,
                              onSuccess: () {
                                Get.offAll(() => ForgotPasswordPage4());
                                authController.forgotPasswordEmailController.clear();
                                authController.forgotPasswordOTPController.clear();
                                authController.forgotPasswordNewPasswordController.clear();
                                authController.forgotPasswordConfirmNewPasswordController.clear();
                              },
                            );
                          }
                          else{
                            showMessagePopup(
                              title: 'Uh oh', 
                              message: 'fields must not be empty', 
                              buttonText: 'Okay', 
                              context: context
                            );
                          }
                        },
                        backgroundColor: AppColor.blackColor,
                        textColor: AppColor.whiteColor,
                        text: 'Set a new Password',
                      )
                  
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