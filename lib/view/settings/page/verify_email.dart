import 'dart:async';
import 'dart:developer';
import 'package:dweller/services/controller/settings/settings_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_appbar.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/view/settings/widget/general/all_buttons.dart';
import 'package:dweller/view/settings/widget/general/success_sheet_acc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';






class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key, required this.email});
  final String email;

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  
  final controller = Get.put(SettingsController());

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
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: CustomPaint(
          painter: TopRedSectionPainter(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //appbar
              DwellerAppBar(
                actionIcon: SvgPicture.asset('assets/svg/settings_icon.svg'),
              ),
                  
              SizedBox(height: MediaQuery.of(context).size.height * 0.20),
        
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  //padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  
                      Text(
                        'Verify that this email belongs to you',
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 30.h,),
                      Text(
                        'Kindly enter the OTP that has been sent to ${widget.email}',
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500
                        ),
                        textAlign: TextAlign.center,
                      ),  
                      /*SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Wrong email?",
                            style: GoogleFonts.poppins(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500
                            ),
                            textAlign: TextAlign.center,
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
                              textAlign: TextAlign.center,
                            ),
                          )
                        ]
                      ),*/
                        
                      SizedBox(height: 20.h,),
                      Focus(
                        child: OtpTextField(
                          margin: EdgeInsets.symmetric(horizontal: 15.w),
                          keyboardType: TextInputType.number,
                          cursorColor: AppColor.darkPurpleColor,
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
                          focusedBorderColor: AppColor.darkPurpleColor,
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
                            controller.otpController.text = verificationCode;
                            print("email verification OTP: ${controller.otpController.text}");
                          },
                        ),
                      ),
                        
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't get a code?",
                            style: GoogleFonts.poppins(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500
                            ),
                            textAlign: TextAlign.center,
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
                              textAlign: TextAlign.center,
                            ),
                          )
                        ]
                      ),
                        
                      SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  
                      //Confirm
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ConfirmButton(
                          backgroundColor: AppColor.blackColorOp, 
                          textColor: AppColor.whiteColor,
                          text: 'Confirm',
                          onPressed: () {
                            if(controller.otpController.text.isNum && controller.otpController.text.isNotEmpty) {
                              //POST request API call
                              Get.back();
                              successBottomsheet(title: 'Verification Successful', context: context,)
                              .whenComplete(() {
                                controller.otpController.clear();
                              });
                            }
                            else{
                              /*showMySnackBar(
                                context: context, 
                                message: "invalid input", 
                                backgroundColor: AppColor.redColor
                              );*/
                              log("OTP FIELD IS EMPTY OR ISN'T A DIGIT");
                            }
                          },
                        ),
                      )
                    ]
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}