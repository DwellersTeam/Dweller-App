import 'dart:async';
import 'package:dweller/services/controller/auth/auth_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







class SplashScreenUpdated extends StatefulWidget {
  const SplashScreenUpdated({super.key, required this.next_screen});
  final Widget next_screen;

  @override
  State<SplashScreenUpdated> createState() => _SplashScreenUpdatedState();
}

class _SplashScreenUpdatedState extends State<SplashScreenUpdated> {

  final authController = Get.put(AuthController());

  late Timer _timer;
  int _secondsRemaining = 3;

  @override
  void initState() {
    super.initState();
    startTimer();
    setStatusBarColor();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    resetStatusBarColor();
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 1) {
          _secondsRemaining--;
          debugPrint("timer: $_secondsRemaining");
        } 
        else {
          // Timer reached 0 seconds, navigate to password expired screen
          timer.cancel(); // Stop the timer
          Get.off(() => widget.next_screen, transition: Transition.rightToLeft);  //Transition.rightToLeft
        }
      });
    });
  }


  void setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set your desired color here
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColor.blackColor, //AppColor.whiteColor,
    ));
  }

  void resetStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,//AppColor.blueColorOpacity, // Set your desired color here
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColor.blackColor, //AppColor.whiteColor,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_pic.png'),
            fit: BoxFit.cover, // Adjust the image's size to cover the entire container
            filterQuality: FilterQuality.medium
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/icon.svg',
              height: 40.h,
              width: 40.w,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10.w,),
            Text(
              'dweller',
              style: GoogleFonts.bricolageGrotesque(
                color: AppColor.purpleColor,
                fontSize: 36.sp, //32.sp
                fontWeight: FontWeight.w700
              )
            ),
          ],
        ),
      )
    );
  }
}