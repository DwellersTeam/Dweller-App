import 'package:country_code_picker/country_code_picker.dart';
import 'package:dweller/services/controller/auth/auth_controller.dart';
import 'package:dweller/services/controller/settings/settings_controller.dart';
import 'package:dweller/services/repository/auth_service/auth_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/country_code_widget.dart';
import 'package:dweller/utils/components/custom_appbar.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/view/settings/widget/general/all_buttons.dart';
import 'package:dweller/view/settings/widget/general/settings_textfield.dart';
import 'package:dweller/view/settings/widget/general/success_sheet_acc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key, required this.onRefresh});
  final VoidCallback onRefresh;
  

  final controller = Get.put(SettingsController());
  final authService = Get.put(AuthService());
  final authController = Get.put(AuthController());

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: CustomPaint(
          painter: TopRedSectionPainter(),
          child: Obx(
            () {
              return authService.isLoading.value ? const LoaderS() : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //appbar
                  DwellerAppBar(
                    //actionIcon: SvgPicture.asset('assets/svg/settings_icon.svg'),
                  ),
                  
                  SizedBox(height: 20.h,),
              
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //1
                          Text(
                            'Old Password',
                            style: GoogleFonts.bricolageGrotesque(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          SettingsPasswordTextField(
                            onChanged: (val) {
                              controller.oldpasswordController.text = val;
                            },
                            onFieldSubmitted: (val) {},
                            hintText: 'password',
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            initialValue: '',
                            isObscured: false,
                            validator: (p0) => authController.validatePassword(value: p0!),
                          ),
                    
                          SizedBox(height: 30.h,),
              
                          //2
                          Text(
                            'New Password',
                            style: GoogleFonts.bricolageGrotesque(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          SettingsPasswordTextField(
                            onChanged: (val) {
                              controller.newpasswordController.text = val;
                            },
                            onFieldSubmitted: (val) {},
                            hintText: 'password',
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            initialValue: '',
                            isObscured: false,
                            validator: (p0) => authController.validatePassword(value: p0!),
                          ),
              
                          SizedBox(height: 30.h,),
                          //3
                          Text(
                            'Confirm New Password',
                            style: GoogleFonts.bricolageGrotesque(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          SettingsPasswordTextField(
                            onChanged: (val) {
                              controller.confirmnewpasswordController.text = val;
                            },
                            onFieldSubmitted: (val) {},
                            hintText: 'password',
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            initialValue: '',
                            isObscured: false,
                            validator: (p0) => authController.validateConfirmPassword(
                              firstValue: controller.newpasswordController.text, 
                              secondValue: p0!,
                            )
                          ),
              
                          SizedBox(height: MediaQuery.of(context).size.height * 0.32,),
                        
                          ConfirmButton(
                            backgroundColor: AppColor.blackColorOp, 
                            textColor: AppColor.whiteColor,
                            text: 'Confirm',
                            onPressed: () {
                              if(controller.oldpasswordController.text.isEmpty && controller.newpasswordController.text.isEmpty && controller.confirmnewpasswordController.text.isEmpty) {
                                showMessagePopup(
                                  title: "Uh oh!", 
                                  message: "fields must not be emoty", 
                                  buttonText: "Okay", 
                                );
                              }
                              else{
                                authService.changeInAppPasswordEndpoint(
                                  context: context, 
                                  old_password: controller.oldpasswordController.text, 
                                  new_password: controller.newpasswordController.text, 
                                  confirmPassword: controller.confirmnewpasswordController.text, 
                                  onSuccess: () {
                                    controller.oldpasswordController.clear();
                                    controller.newpasswordController.clear();
                                    controller.confirmnewpasswordController.clear();
                                    Get.back();
                                    onRefresh();
                                    successBottomsheet(
                                      context: context,
                                      title: 'Update Successful'
                                    );
                                  }
                                );
                              }
                              
                            },
                          ),     
                                  
                        ]
                      ),
                    ),
                  ),
                  
              
                ]
              );
            }
          ),
        )
      )
    );
  }
}