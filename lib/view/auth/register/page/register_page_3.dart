import 'dart:async';
import 'dart:developer';
import 'package:dweller/services/controller/auth/auth_controller.dart';
import 'package:dweller/services/repository/auth_service/auth_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/view/auth/register/page/register_page_4.dart';
import 'package:dweller/view/auth/widgets/3D_container/hd_container.dart';
import 'package:dweller/view/auth/widgets/button/auth_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';








class RegisterPage3 extends StatefulWidget {
  const RegisterPage3({super.key});

  @override
  State<RegisterPage3> createState() => _RegisterPage3State();
}

class _RegisterPage3State extends State<RegisterPage3> {

  final authController = Get.put(AuthController());
  final authService = Get.put(AuthService());


  late Timer _timer;
  int _secondsRemaining = 59;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 1) {
          _secondsRemaining--;
        } 
        else {
          // Timer reached 0 seconds, navigate to password expired screen
          timer.cancel(); // Stop the timer
          //Get.back();
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel(); //cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return authService.isLoading.value ? const Loader() :  SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              scrollDirection: Axis.vertical,
              physics:const BouncingScrollPhysics(),
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
                          'Confirm your email',
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Text(
                          'Kindly enter the OTP that has been sent to your email',  //email text controller  //
                          style: GoogleFonts.poppins(
                            color: AppColor.semiDarkGreyColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                    
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Wrong email?",
                              style: GoogleFonts.poppins(
                                color: AppColor.semiDarkGreyColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(width: 5.w,),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Text(
                                'Click here to input correct email',
                                style: GoogleFonts.poppins(
                                  color: AppColor.darkPurpleColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  //decoration: TextDecoration.underline,
                                  //decorationColor: AppColor.redColor
                                ),
                              ),
                            )
                          ]
                        ),
                    
                        SizedBox(height: 20.h,),
                        Focus(
                          child: OtpTextField(
                            margin: EdgeInsets.symmetric(horizontal: 15.w),
                            keyboardType: TextInputType.number,
                            cursorColor: AppColor.blueColor,
                            numberOfFields: 4,
                            //fieldHeight: 70.h,
                            fieldWidth: 50.w,
                            borderColor: AppColor.darkGreyColor,
                            enabledBorderColor: AppColor.semiDarkGreyColor,
                            //set to true to show as box or false to show as dash
                            showFieldAsBox: true,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.start, 
                            borderRadius: BorderRadius.circular(5.r),
                            focusedBorderColor: AppColor.blueColor,
                            textStyle: GoogleFonts.nunito(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              color: AppColor.semiDarkGreyColor
                            ),
                            //runs when a code is typed in
                            onCodeChanged: (String code) {
                              //handle validation or checks here           
                            },
                            //runs when every textfield is filled
                            onSubmit: (String verificationCode){
                              authController.emailOTPController.text = verificationCode;
                              print("email verification OTP: ${authController.emailOTPController.text}");
                            },
                          ),
                        ),
                    
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Didn't get a code?",
                              style: GoogleFonts.poppins(
                                color: AppColor.semiDarkGreyColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(width: 5.w,),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Text(
                                'Resend code in ${_secondsRemaining}s',
                                style: GoogleFonts.poppins(
                                  color: AppColor.darkPurpleColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  //decoration: TextDecoration.underline,
                                  //decorationColor: AppColor.redColor
                                ),
                              ),
                            )
                          ]
                        ),
                    
                        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    
                        //button
                        AuthButton(
                          textColor: AppColor.whiteColor,
                          onPressed: () {
                            if(authController.emailOTPController.text.isNum && authController.emailOTPController.text.isNotEmpty) {
                              //POST request API call
                              authService.veryEmailEndpoint(
                                context: context, 
                                otp: authController.emailOTPController.text, 
                                email: authController.emailController.text,
                                firstName: authController.firstNameController.text,
                                lastName: authController.lastNameController.text,
                                onSuccess: () {
                                  Get.to(() => const RegisterPage4());
                                },
                              );
                            }
                            else{
                              showMessagePopup(
                                title: 'Uh oh', 
                                message: 'invalid input', 
                                buttonText: 'Okay', 
                              );
                              log("OTP FIELD IS EMPTY OR ISN'T A DIGIT");
                            }
                          },
                          backgroundColor: AppColor.blackColor,
                          text: 'Next',
                        ),
                    
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    
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