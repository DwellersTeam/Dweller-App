import 'package:dweller/services/controller/auth/auth_controller.dart';
import 'package:dweller/services/controller/main_page/mainpage_controller.dart';
import 'package:dweller/services/repository/auth_service/auth_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/view/auth/forgot_password/forgot_password_page_1.dart';
import 'package:dweller/view/auth/register/page/register_page_1.dart';
import 'package:dweller/view/auth/widgets/button/auth_button.dart';
import 'package:dweller/view/auth/widgets/button/google_auth_button.dart';
import 'package:dweller/view/auth/widgets/textfields/auth_textfield.dart';
import 'package:dweller/view/main/mainpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final authController = Get.put(AuthController());
  final mainPageController = Get.put(MainPageController());
  final authService = Get.put(AuthService());

  void resetStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColor.whiteColor, //AppColor.whiteColor, Colors.transparent
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColor.blackColor, //AppColor.whiteColor,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //resetStatusBarColor();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.whiteColor,
      body: Obx(
        () {
          return authService.isLoading.value ? const Loader() : SafeArea(
            child: CustomPaint(
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
                //physics: ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //5% of the screen
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),  //0.08
                    //dweller svg icon
                    SvgPicture.asset(
                      'assets/svg/icon_dark.svg',
                      height: 55.h,
                      width: 55.w,
                      fit: BoxFit.contain,
                    ),
                    
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02), 
                    Text(
                      textAlign: TextAlign.start,
                      'welcome back dweller 👋',
                      style: GoogleFonts.bricolageGrotesque(
                        color: AppColor.blackColor,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    //SizedBox(height: 10.h,),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login to your Dweller account with your email and password',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        //SizedBox(height: 20.h,),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                        Text(
                          'Email',
                          style: GoogleFonts.poppins(
                            color: AppColor.semiDarkGreyColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        AuthTextField(
                          onChanged: (val) {},
                          onFocusChanged: (p0) {},
                          hintText: 'Your email address',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          textController: authController.loginEmailController,
                          icon: CupertinoIcons.mail_solid,
                          validator: (p0) => authController.validateEmail(value: p0!),
                        ),
                              
                        SizedBox(height: 20.h,),
                              
                        Text(
                          'Password',
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
                          hintText: 'Your password',
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          textController: authController.loginPasswordController,
                          //validator: (p0) => authController.validatePassword(value: p0!),
                          icon: Icon(
                            Icons.lock,
                            size: 24.r,
                            color: AppColor.darkGreyColor,
                          ),
                          isObscured: false,
                        ),
                              
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.off(() => ForgotPasswordPage1(), transition: Transition.rightToLeft);                       
                              },
                              child: Text(
                                'forgot password?',
                                style: GoogleFonts.poppins(
                                  color: AppColor.semiDarkGreyColor,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  //decoration: TextDecoration.underline,
                                  //decorationColor: AppColor.redColor
                                ),
                              ),
                            )
                          ]
                        ),
                              
                        SizedBox(height: 25.h,),
                              
                        //buttons
                        AuthButton(
                          onPressed: () {
                            if(authController.loginEmailController.text.isNotEmpty && authController.loginPasswordController.text.isNotEmpty) {
                              authService.loginEndpoint(
                                context: context, 
                                email: authController.loginEmailController.text, 
                                password: authController.loginPasswordController.text,
                                onSuccess: () {
                                  mainPageController.navigateToMainpageAtIndex(page: const MainPage(), index: 0);
                                  authController.loginEmailController.clear();
                                  authController.loginPasswordController.clear();
                                }
                              );
                            }
                            else{
                              showMessagePopup(
                                title: 'Uh oh', 
                                message: 'fields must not be empty', 
                                buttonText: 'Okay', 
                              );
                            }
                            
                            //mainPageController.navigateToMainpageAtIndex(page: const MainPage(), index: 0);

                          },
                          textColor: AppColor.whiteColor,
                          backgroundColor: AppColor.blackColor,
                          text: 'Login',
                        ),
                        SizedBox(height: 30.h,),
                        GoogleAuthButton(
                          textColor: AppColor.blackColor,
                          backgroundColor: AppColor.whiteColor,
                          foregroundColor: AppColor.whiteColor,
                          borderColor: AppColor.lightGreyColor,
                          text: 'Login with Google',
                          onPressed: () {
                            authService.signInWithGoogle(context: context);
                          },
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: GoogleFonts.poppins(
                                color: AppColor.semiDarkGreyColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(width: 5.w,),
                            InkWell(
                              onTap: () {
                                Get.off(() => RegisterPage1(), transition: Transition.rightToLeft);                       
                              },
                              child: Text(
                                'Create Account',
                                style: GoogleFonts.nunito(
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
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                              
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}