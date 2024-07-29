import 'package:dweller/services/repository/auth_service/auth_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/auth/login/page/login_page.dart';
import 'package:dweller/view/auth/widgets/button/auth_button.dart';
import 'package:dweller/view/auth/widgets/button/google_auth_button.dart';
import 'package:dweller/view/auth/register/page/register_page_1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';






class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  //to set status bar color
  @override
  void initState() {
    super.initState();
    // Call the method to set the status bar color
    setStatusBarColor();
  }
  
  //to reset status bar color
  @override
  void dispose() {
    // TODO: implement dispose
    resetStatusBarColor();
    super.dispose();
  }

  void setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set your desired color here
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColor.blackColor, //AppColor.whiteColor,
    ));
  }

  void resetStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //AppColor.whiteColor, Colors.transparent
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColor.blackColor, //AppColor.whiteColor,
      ),
    );
  }

  final authService = Get.put(AuthService());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/intro_pic.png'),
            fit: BoxFit.cover, // Adjust the image's size to cover the entire container
            filterQuality: FilterQuality.high
          ),
        ),
        child: Obx(
          () {
            return authService.isLoading.value ? const LoaderWhite() : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //30% of the screen
                SizedBox(height: MediaQuery.of(context).size.height * 0.3), 
                
                //dweller svg icon
                SvgPicture.asset(
                  'assets/svg/intro_icon.svg',
                  height: 60.h,
                  width: 60.w,
                  fit: BoxFit.contain,
                ),
                /*Icon(
                  CupertinoIcons.checkmark_seal_fill,
                  size: 70.r,
                  color: AppColor.whiteColor,
                ),*/
            
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text(
                  'Swipe match and\nmove in with Dweller',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bricolageGrotesque(
                    color: AppColor.whiteColor,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w500,
                  )
                ),
            
                //SizedBox(height: 80.h,),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New to Dweller?',
                        style: GoogleFonts.bricolageGrotesque(
                          //fontStyle: FontStyle.italic,
                          color: AppColor.whiteColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600
                        )
                      ),
                      SizedBox(width: 5.w),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Create an account',
                          style: GoogleFonts.bricolageGrotesque(
                            color: AppColor.whiteColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            //decoration: TextDecoration.underline,
                            //decorationColor: AppColor.redColor, 
                          )
                        ),
                      ),
                    ]  
                  ),
                ),
            
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: AuthButton(
                    backgroundColor: AppColor.blueColor,
                    textColor: AppColor.blackColor,
                    onPressed: () {
                      Get.offAll(() => RegisterPage1(), transition: Transition.rightToLeft);
                    },
                    text: 'Signup',
                  ),
                ),
                SizedBox(height: 15.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: GoogleAuthButton(
                    textColor: AppColor.whiteColor,
                    borderColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.transparent,
                    onPressed: () {
                      //func to launch google here
                      authService.signUpWithGoogle(context: context);
                    },
                    text: 'Signup with Google',
                  ),
                ),
            
                //SizedBox(height: 30.h,),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                
                //login section
                Text(
                  'Already have an account?',
                  style: GoogleFonts.bricolageGrotesque(
                    color: AppColor.whiteColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400
                  )
                ),
                SizedBox(height: 5.h),
                InkWell(
                  onTap: () {
                    Get.offAll(() => LoginPage(), transition: Transition.rightToLeft);
                  },
                  child: Text(
                    'Click here to Login',
                    style: GoogleFonts.bricolageGrotesque(
                      color: AppColor.blueColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      //decoration: TextDecoration.underline,
                      //decorationColor: AppColor.redColor, 
                    )
                  ),
                ),
            
              
              ],
            );
          }
        ),
      ),
    );
  }
}