import 'package:dweller/services/controller/settings/settings_controller.dart';
import 'package:dweller/services/repository/settings_service/settings_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/utils/components/text_input_formatters.dart';
import 'package:dweller/view/search/widget/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';








void editCardBottomsheet({
  required SettingsController controller,
  required SettingService service,
  required BuildContext context,
  required String cardHolderName,
  required String cardNumber,
  required String expiryDate,
  required String cvv,
  required VoidCallback onRefresh,
}) {
  Get.bottomSheet(
    isDismissible: true,
    backgroundColor: AppColor.whiteColorForSubSheet,
    Wrap(
      children: [
        Container(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: AppColor.whiteColorForSubSheet,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 7.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: AppColor.greyColor,
                    borderRadius: BorderRadius.circular(15.r)
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              
              Text(
                'Card Number',
                style: GoogleFonts.poppins(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 6.h,),
              TaskTextInputfieldEdit(
                onChanged: (val) {},
                onFieldSubmitted: (val) {
                  controller.editCardNumberController.text = val;
                },
                hintText: "Card number",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                initialValue:  cardNumber,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CreditCardNumberFormatter(),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.04),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //1
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expiry Date',
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 6.h,),
                        TaskTextInputfieldEdit(
                          onChanged: (val) {},
                          onFieldSubmitted: (val) {
                            controller.editExpiryDateController.text = val;
                          },
                          hintText: "Expiry date",
                          keyboardType: TextInputType.datetime,
                          textInputAction: TextInputAction.next,
                          initialValue:  expiryDate,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CreditCardExpiryDateFormatter()
                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(width: 30.w,),
                  //2
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CVV',
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 6.h,),
                        TaskTextInputfieldEdit(
                          onChanged: (val) {},
                          onFieldSubmitted: (val) {
                            controller.editCVVController.text = val;
                          },
                          hintText: "CVV",
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          initialValue:  cvv,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CreditCardCVVFormatter()
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.04),

              //Save changes gradient button
              SizedBox(
                height: 60.h,
                width: double.infinity,
                child: GradientElevatedButton(
                  onPressed: () async{
                    await service.updateCreditCard(
                      context: context, 
                      cardNumber: controller.editCardNumberController.text.isNotEmpty ? controller.editCardNumberController.text : cardNumber, 
                      carrdCVV:  controller.editCVVController.text.isNotEmpty ?  controller.editCVVController.text : cvv, 
                      carrdExpiry: controller.editExpiryDateController.text.isNotEmpty ? controller.editExpiryDateController.text : expiryDate, 
                      cardType: "master card", 
                      onSuccess: () {
                        Get.back();
                        onRefresh();
                        showMySnackBar(
                          context: context, 
                          message: "credit card updated successfully", 
                          backgroundColor: AppColor.greenColor,
                        );
                      }, 
                      onFailure: () {
                        Get.back();
                        onRefresh();
                        showMySnackBar(
                          context: context, 
                          message: "failed to update credit card", 
                          backgroundColor: AppColor.redColor
                        );
                      }
                    );
                  },
                  style: GradientElevatedButton.styleFrom(
                    gradient: const LinearGradient(
                      colors: [
                        //Color.fromRGBO(9, 173, 234, 1),
                        //Color.fromRGBO(41, 57, 238, 1),
                        AppColor.blueColor,
                        AppColor.blueColor
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Obx(
                    () {
                      return service.isLoading.value ? const CircularProgressIndicator.adaptive(backgroundColor: AppColor.whiteColor,) : Text(
                        'Save Changes',
                        style: GoogleFonts.bricolageGrotesque(
                          color: AppColor.whiteColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                  ),
                ),
              ),

        
        
            ],
          ),
        ),
      ],
    ),
  );
}