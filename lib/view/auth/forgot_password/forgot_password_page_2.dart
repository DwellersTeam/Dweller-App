import 'dart:async';
import 'package:dweller/services/controller/auth/auth_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/view/auth/forgot_password/forgot_password_page_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';








class ForgotPasswordPage2 extends StatefulWidget {
  const ForgotPasswordPage2({super.key});

  @override
  State<ForgotPasswordPage2> createState() => _ForgotPasswordPage2State();
}

class _ForgotPasswordPage2State extends State<ForgotPasswordPage2> {

  final authController = Get.put(AuthController());

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
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //30% of the screen
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
              SizedBox(height: 10.h,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '⚠ A code to reset your password has been sent to ${authController.forgotPasswordEmailController.text}',
                    style: GoogleFonts.poppins(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Text(
                    'Kindly enter the OTP that has been sent to ${authController.forgotPasswordEmailController.text}',  //email text controller
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
                        authController.forgotPasswordOTPController.text = verificationCode;
                        print("fp email verification OTP: ${authController.forgotPasswordOTPController.text}");
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
                  )
              
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(authController.forgotPasswordOTPController.text.isNum && authController.forgotPasswordOTPController.text.isNotEmpty) {
            //POST request API call
            Get.to(() => ForgotPasswordPage3(), transition: Transition.rightToLeft);
          }
          else{
            showMySnackBar(
              context: context, 
              message: "invalid input", 
              backgroundColor: AppColor.redColor
            );
            print("OTP FIELD IS EMPTY OR ISN'T A DIGIT");
          }
        },
        child: Icon(
          color: AppColor.whiteColor,
          Icons.arrow_forward_rounded,
          size: 24.r,
        ), // Icon for the floating action button
        backgroundColor: AppColor.blackColor, // Background color of the button
        foregroundColor: AppColor.blackColor, // Icon color
        elevation: 4.0, // Elevation of the button
        splashColor: AppColor.lightGreyColor, // Splash color when pressed
        tooltip: 'Next',
        enableFeedback: true,
        shape: const CircleBorder(), // Makes the button circular
      ),
    );
  }
}