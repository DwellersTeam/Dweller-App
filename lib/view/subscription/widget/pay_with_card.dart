import 'dart:developer';

import 'package:dweller/services/controller/settings/settings_controller.dart';
import 'package:dweller/main.dart';
import 'package:dweller/services/repository/settings_service/settings_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/utils/components/text_input_formatters.dart';
import 'package:dweller/view/search/widget/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';






void payWithCardBottomsheet({
  required SettingsController controller,
  required VoidCallback onSettingRefresh,
  required SettingService service,
  required BuildContext context,
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
                'Cardholder Name',
                style: GoogleFonts.poppins(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 6.h,),
              TaskTextInputfield(
                onChanged: (val) {
                  controller.cardHolderNameController.text = val;
                },
                onFieldSubmitted: (val) {
                  controller.cardHolderNameController.text = val;
                },
                hintText: "Cardholder Name",
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                textController: controller.cardHolderNameController,
                inputFormatters: [],
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              
              Text(
                'Card Number',
                style: GoogleFonts.poppins(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 6.h,),
              TaskTextInputfield(
                onChanged: (val) {
                  controller.cardNumberController.text = val;
                },
                onFieldSubmitted: (val) {
                  controller.cardNumberController.text = val;
                },
                hintText: "Card number",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textController: controller.cardNumberController,
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
                        TaskTextInputfield(
                          onChanged: (val) {
                            controller.expiryDateController.text = val;
                          },
                          onFieldSubmitted: (val) {
                            controller.expiryDateController.text = val;
                          },
                          hintText: "Expiry date",
                          keyboardType: TextInputType.datetime,
                          textInputAction: TextInputAction.next,
                          textController: controller.expiryDateController,
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
                        TaskTextInputfield(
                          onChanged: (val) {
                            controller.CVVController.text = val;
                          },
                          onFieldSubmitted: (val) {
                            controller.CVVController.text = val;
                          },
                          hintText: "CVV",
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          textController: controller.CVVController,
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
                    if(controller.cardHolderNameController.text.isNotEmpty && controller.cardNumberController.text.isNotEmpty && controller.CVVController.text.isNotEmpty && controller.expiryDateController.text.isNotEmpty)  {
                      await service.subscribeToPro(
                      context: context, 
                      cardholderName: controller.cardHolderNameController.text,
                      cardNumber: controller.cardNumberController.text,
                      carrdCVV:  controller.CVVController.text,
                      carrdExpiry: controller.expiryDateController.text,
                      cardType: "master card", 
                      onSuccess: () async{
                        Get.back();
                        Get.back();
                        controller.cardHolderNameController.clear();
                        controller.cardNumberController.clear();
                        controller.CVVController.clear();
                        controller.expiryDateController.clear();
                        onSettingRefresh();
                        
                        /*await service.createCreditCard(
                          cardNumber: controller.cardNumberController.text,
                          carrdCVV:  controller.CVVController.text,
                          carrdExpiry: controller.expiryDateController.text,
                          cardType: "master card", 
                          onSuccess: () {
                            Get.back();
                            Get.back();
                            controller.cardNumberController.clear();
                            controller.CVVController.clear();
                            controller.expiryDateController.clear();
                            onSettingRefresh();
                            /*showMySnackBar(
                              context: context, 
                              message: "subscription successful", 
                              backgroundColor: AppColor.greenColor,
                            );*/
                          },
                          onFailure: () {
                            Get.back();
                            controller.cardNumberController.clear();
                            controller.CVVController.clear();
                            controller.expiryDateController.clear();
                            /*showMySnackBar(
                              context: context, 
                              message: "failed to create card details", 
                              backgroundColor: AppColor.redColor
                            );*/
                          }
                        );*/

                      }, 
                      onFailure: () {
                        Get.back();
                        controller.cardHolderNameController.clear();
                        controller.cardNumberController.clear();
                        controller.CVVController.clear();
                        controller.expiryDateController.clear();
                        /*showMySnackBar(
                          context: context, 
                          message: "failed to subscribe to dweller pro", 
                          backgroundColor: AppColor.redColor
                        );*/
                      }
                    );
                    }
                    else {
                      log("fields must not be empty");
                      //showMySnackBar(context: context, message: "fields must not be empty", backgroundColor: AppColor.redColor);
                    }
                    
                  },
                  style: GradientElevatedButton.styleFrom(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(9, 173, 234, 1),
                        Color.fromRGBO(41, 57, 238, 1),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Obx(
                    () {
                      return service.isLoading.value ? const CircularProgressIndicator.adaptive(backgroundColor: AppColor.whiteColor,) : Text(
                        'Pay ${currency(context).currencySymbol}9.99',
                        //'Make Payment',
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





void payWithCardBottomsheetAdvancedSearch({
  required SettingsController controller,
  required SettingService service,
  required BuildContext context,
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
                'Cardholder Name',
                style: GoogleFonts.poppins(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 6.h,),
              TaskTextInputfield(
                onChanged: (val) {
                  controller.cardHolderNameController.text = val;
                },
                onFieldSubmitted: (val) {
                  controller.cardHolderNameController.text = val;
                },
                hintText: "Cardholder Name",
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                textController: controller.cardHolderNameController,
                inputFormatters: [],
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              
              Text(
                'Card Number',
                style: GoogleFonts.poppins(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 6.h,),
              TaskTextInputfield(
                onChanged: (val) {
                  controller.cardNumberController.text = val;
                },
                onFieldSubmitted: (val) {
                  controller.cardNumberController.text = val;
                },
                hintText: "Card number",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textController: controller.cardNumberController,
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
                        TaskTextInputfield(
                          onChanged: (val) {
                            controller.expiryDateController.text = val;
                          },
                          onFieldSubmitted: (val) {
                            controller.expiryDateController.text = val;
                          },
                          hintText: "Expiry date",
                          keyboardType: TextInputType.datetime,
                          textInputAction: TextInputAction.next,
                          textController: controller.expiryDateController,
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
                        TaskTextInputfield(
                          onChanged: (val) {
                            controller.CVVController.text = val;
                          },
                          onFieldSubmitted: (val) {
                            controller.CVVController.text = val;
                          },
                          hintText: "CVV",
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          textController: controller.CVVController,
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
                    if(controller.cardHolderNameController.text.isNotEmpty && controller.cardNumberController.text.isNotEmpty && controller.CVVController.text.isNotEmpty && controller.expiryDateController.text.isNotEmpty) {
                      await service.subscribeToPro(
                      context: context, 
                      cardholderName: controller.cardHolderNameController.text,
                      cardNumber: controller.cardNumberController.text,
                      carrdCVV:  controller.CVVController.text,
                      carrdExpiry: controller.expiryDateController.text,
                      cardType: "master card", 
                      onSuccess: () async{
                        Get.back();
                        controller.cardHolderNameController.clear();
                        controller.cardNumberController.clear();
                        controller.CVVController.clear();
                        controller.expiryDateController.clear();
                        /*await service.createCreditCard(
                          cardNumber: controller.cardNumberController.text,
                          carrdCVV:  controller.CVVController.text,
                          carrdExpiry: controller.expiryDateController.text,
                          cardType: "master card", 
                          onSuccess: () {
                            Get.back();
                            controller.cardNumberController.clear();
                            controller.CVVController.clear();
                            controller.expiryDateController.clear();
                        
                            /*showMySnackBar(
                              context: context, 
                              message: "subscription successful", 
                              backgroundColor: AppColor.greenColor,
                            );*/
                          },
                          onFailure: () {
                            Get.back();
                            controller.cardNumberController.clear();
                            controller.CVVController.clear();
                            controller.expiryDateController.clear();
                            /*showMySnackBar(
                              context: context, 
                              message: "failed to create card details", 
                              backgroundColor: AppColor.redColor
                            );*/
                          }
                        );*/

                      }, 
                      onFailure: () {
                        Get.back();
                        controller.cardHolderNameController.clear();
                        controller.cardNumberController.clear();
                        controller.CVVController.clear();
                        controller.expiryDateController.clear();
                        /*showMySnackBar(
                          context: context, 
                          message: "failed to subscribe to dweller pro", 
                          backgroundColor: AppColor.redColor
                        );*/
                      }
                    );
                    }
                    else {
                      log("fields must not be empty");
                      //showMySnackBar(context: context, message: "fields must not be empty", backgroundColor: AppColor.redColor);
                    }
                    
                  },
                  style: GradientElevatedButton.styleFrom(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(9, 173, 234, 1),
                        Color.fromRGBO(41, 57, 238, 1),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Obx(
                    () {
                      return service.isLoading.value ? const CircularProgressIndicator.adaptive(backgroundColor: AppColor.whiteColor,) : Text(
                        'Pay ${currency(context).currencySymbol}9.99',
                        //'Make Payment',
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