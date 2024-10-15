import 'package:country_code_picker/country_code_picker.dart';
import 'package:dweller/services/controller/auth/auth_controller.dart';
import 'package:dweller/services/controller/settings/settings_controller.dart';
import 'package:dweller/services/repository/auth_service/auth_service.dart';
import 'package:dweller/services/repository/create_profile_service/create_profile_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/country_code_widget.dart';
import 'package:dweller/utils/components/custom_appbar.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/settings/widget/general/all_buttons.dart';
import 'package:dweller/view/settings/widget/general/settings_textfield.dart';
import 'package:dweller/view/settings/widget/general/success_sheet_acc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class ChangeMobileNumberPage extends StatelessWidget {
  ChangeMobileNumberPage({super.key, required this.phone, required this.onRefresh});
  final String phone;
  final VoidCallback onRefresh;
  
  final profileService = Get.put(CreateProfileService());
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
              return profileService.isLoading.value ? const LoaderS() :  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //appbar
                  DwellerAppBar(
                    //actionIcon: SvgPicture.asset('assets/svg/settings_icon.svg'),
                  ),
                  
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25,),

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
                            'Enter Phone Number',
                            style: GoogleFonts.bricolageGrotesque(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          SettingsPhoneNumberTextField(
                            onChanged: (val) {
                              controller.phoneNumberController.text = val;
                            },
                            onFieldSubmitted: (val) {},
                            hintText: 'phone number',
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            initialValue: phone,
                            icon: CountryCodeWidget(
                              onCountryChanged: (CountryCode val) {
                                controller.onCountryChange(val);
                              }
                            ),
                            validator: (p0) => authController.validatePhoneNumber(value: p0!),
                          ),
                      
                          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                        
                          ConfirmButton(
                            backgroundColor: AppColor.blackColorOp, 
                            textColor: AppColor.whiteColor,
                            text: 'Confirm',
                            onPressed: () async{
                              await profileService.updateUserPhoneNumberEndpoint(
                                context: context,
                                phone: controller.phoneNumberController.text.isNotEmpty ? "${controller.phone_code.value} ${controller.phoneNumberController.text}" : phone,
                                onSuccess: () {
                                  controller.phoneNumberController.clear();
                                  Get.back();
                                  onRefresh();
                                  successBottomsheet(
                                    context: context,
                                    title: 'Update Successful'
                                  );
                                },
                              );
                              
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