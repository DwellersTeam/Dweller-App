import 'package:dweller/services/controller/auth/auth_controller.dart';
import 'package:dweller/services/repository/auth_service/auth_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/view/auth/widgets/3D_container/hd_container.dart';
import 'package:dweller/view/auth/widgets/button/auth_button.dart';
import 'package:dweller/view/auth/widgets/textfields/auth_textfield.dart';
import 'package:dweller/view/create_profile/page/intro/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







class RegisterPage4 extends StatefulWidget {
  const RegisterPage4({super.key});

  @override
  State<RegisterPage4> createState() => _RegisterPage4State();
}

class _RegisterPage4State extends State<RegisterPage4> {

  final authController = Get.put(AuthController());
  final authService = Get.put(AuthService());

  void resetStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //AppColor.whiteColor, //Colors.transparent
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
      body: Obx(
        () {
          return authService.isLoading.value ? const Loader() : SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              scrollDirection: Axis.vertical,
              physics:const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //40% of the screen
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          
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
                          'Create your password',
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                          ),
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
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          textController: authController.passwordController,
                          icon: Icon(
                            Icons.lock, 
                            color: AppColor.semiDarkGreyColor,
                            size: 24.r,
                          ),
                          isObscured: false,
                          validator: (val) => authController.validatePassword(value: val!),
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
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          textController: authController.confirmPasswordController,
                          icon: Icon(
                            Icons.lock, 
                            color: AppColor.semiDarkGreyColor,
                            size: 24.r,
                          ),
                          isObscured: false,
                          validator: (val) => authController.validateConfirmPassword(firstValue: authController.passwordController.text, secondValue: val!),
                        ),
                    
                        SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                    
                        //button
                        AuthButton(
                          textColor: AppColor.whiteColor,
                          onPressed: () {
                            //Get.to(() => WelcomePage(), transition: Transition.rightToLeft); 
                            if(authController.passwordController.text.isNotEmpty && authController.confirmPasswordController.text.isNotEmpty) {
                              authService.registerEndpoint(
                                context: context,
                                email: authController.emailController.text,
                                firstName: authController.firstNameController.text,
                                lastName: authController.lastNameController.text,
                                phone: "${authController.phone_code.value} ${authController.phoneNumberController.text}",
                                password: authController.passwordController.text,
                                confirmPassword: authController.confirmPasswordController.text,
                                onSuccess: () {
                                  Get.offAll(() =>  const WelcomePage());
                                  authController.emailController.clear();
                                  authController.firstNameController.clear();
                                  authController.lastNameController.clear();
                                  authController.phoneNumberController.clear();
                                  authController.passwordController.clear();
                                  authController.confirmPasswordController.clear();
                                  authController.emailOTPController.clear();
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
                          text: 'Create Account',
                        ),
                        //SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    
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