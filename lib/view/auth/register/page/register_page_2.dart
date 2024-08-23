import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dweller/services/controller/auth/auth_controller.dart';
import 'package:dweller/services/repository/auth_service/auth_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/country_code_widget.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/view/auth/login/page/login_page.dart';
import 'package:dweller/view/auth/register/page/register_page_3.dart';
import 'package:dweller/view/auth/widgets/3D_container/hd_container.dart';
import 'package:dweller/view/auth/widgets/button/auth_button.dart';
import 'package:dweller/view/auth/widgets/textfields/auth_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







class RegisterPage2 extends StatelessWidget {
  RegisterPage2({super.key});

  final authController = Get.put(AuthController());
  final authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return authService.isLoading.value ? const Loader() : SafeArea(
            /*decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/authdesign.png'),
                fit: BoxFit.cover, // Adjust the image's size to cover the entire container
              ),
            ),*/
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //40% of the screen
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          
                  DenseContainer(
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
          
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone Number',
                          style: GoogleFonts.poppins(
                            color: AppColor.semiDarkGreyColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        AuthPhoneNumberTextField(
                          onChanged: (val) {},
                          onFocusChanged: (p0) {},
                          hintText: 'Your phone number',
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          textController: authController.phoneNumberController,
                          icon: CountryCodeWidget(
                            onCountryChanged: (CountryCode val) {
                              authController.onCountryChange(val);
                            }
                          ),
                          validator: (val) => authController.validatePhoneNumber(value: val!),
                        ),
                    
                        SizedBox(height: 20.h,),
                    
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
                            authController.emailController.text = val;
                            log(authController.emailController.text);
                          },
                          onFocusChanged: (p0) {},
                          hintText: 'Your email address',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          textController: authController.emailController,
                          icon: CupertinoIcons.mail_solid,
                          validator: (val) => authController.validateEmail(value: val!),
                        ),
                    
                        SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                    
                        //button
                        AuthButton(
                          textColor: AppColor.whiteColor,
                          onPressed: () {
                            if(authController.phoneNumberController.text.isNotEmpty && authController.emailController.text.isNotEmpty) {
                              authService.sendEmailOTPEndpoint(
                                context: context,
                                email: authController.emailController.text,
                                firstName: authController.firstNameController.text,
                                lastName: authController.lastNameController.text,
                                //otpTextController: authController.emailOTPController.text,
                                nextPage: RegisterPage3(),
                              );
    
                            }
                            else{
                              showMessagePopup(
                                title: 'Uh oh', 
                                message: 'fields must not be empty', 
                                buttonText: 'Okay', 
                              );
                            }
                          },
                          backgroundColor: AppColor.blackColor,
                          text: 'Next',
                        ),
                    
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    
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
                        )
                    
                    
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
  
    );
  }
}