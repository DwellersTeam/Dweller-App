import 'package:dweller/services/controller/auth/auth_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/view/auth/login/page/login_page.dart';
import 'package:dweller/view/auth/register/page/register_page_2.dart';
import 'package:dweller/view/auth/widgets/3D_container/hd_container.dart';
import 'package:dweller/view/auth/widgets/button/auth_button.dart';
import 'package:dweller/view/auth/widgets/textfields/auth_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class RegisterPage1 extends StatelessWidget {
  RegisterPage1({super.key});

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              //47% of the screen
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
                      'First Name',
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
                      hintText: 'Your first name',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      textController: authController.firstNameController,
                      icon: CupertinoIcons.person_fill,
                      validator: (val) => authController.validateFirstName(value: val!),
                    ),
                
                    SizedBox(height: 20.h,),
                
                    Text(
                      'Last Name',
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
                      hintText: 'Your last name',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      textController: authController.lastNameController,
                      icon: CupertinoIcons.person_fill,
                      validator: (val) => authController.validateLastName(value: val!),
                    ),
                
                    SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                
                    //button
                    AuthButton(
                      textColor: AppColor.whiteColor,
                      onPressed: () {
                        if(authController.firstNameController.text.isNotEmpty && authController.lastNameController.text.isNotEmpty) {
                          Get.to(() => RegisterPage2(), transition: Transition.rightToLeft); 
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
      ),
    );
  }
}