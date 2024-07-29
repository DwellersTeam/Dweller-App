import 'dart:developer';
import 'package:dweller/services/controller/settings/settings_controller.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/services/repository/settings_service/settings_service.dart';
import 'package:dweller/utils/components/custom_appbar.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/view/settings/widget/general/all_buttons.dart';
import 'package:dweller/view/settings/widget/kyc_settings/kyc_success_sheet.dart';
import 'package:dweller/view/settings/widget/kyc_settings/upload_doc_sheet.dart';
import 'package:dweller/view/settings/widget/kyc_settings/upload_document.dart';
import 'package:flutter/cupertino.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







class KYCSettings extends StatelessWidget {
  KYCSettings({super.key, required this.service, required this.onRefresh});
  final SettingService service;
  final VoidCallback onRefresh;

  final controller = Get.put(SettingsController());
  final String kycUrl = LocalStorage.getKYCDoc();

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
              //SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'KYC',
                  style: GoogleFonts.bricolageGrotesque(
                    color: AppColor.darkPurpleColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600
                  ),
                ),
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
                      Text(
                        'Choose document to upload',
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      //DropdownMenuBotton
                      Container(
                        alignment: Alignment.center,
                        height: 70.h,
                        width: double.infinity,
                        //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColor.legalGreyColor,
                        ),
                        child: DropdownButtonFormField<String>(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(        
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none, // Remove the border
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none, // Remove the border
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none, // Remove the border
                            ),   
                            hintText: "Select",
                            hintStyle: GoogleFonts.poppins(
                              color: AppColor.blackColor, 
                              fontSize: 16.sp, 
                              fontWeight: FontWeight.w400
                            ),              
                          ),
                          icon: Icon(
                            CupertinoIcons.chevron_down,
                            color: AppColor.blackColor,
                            size: 20.r,
                          ),
                          iconDisabledColor: AppColor.semiDarkGreyColor,
                          iconEnabledColor: AppColor.blackColor,
                          dropdownColor: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(10.r),
                          value: controller.kycDocType.value,
                          onChanged: (String? newValue) {
                            controller.kycDocType.value = newValue!;
                            log("selected kyc doc type: ${controller.kycDocType.value}");
                          },
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor, //textGreyColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          //dropdown menu item padding
                          padding: EdgeInsets.symmetric(horizontal: 10.w,),
                          items: controller.kycOptionsList
                            .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: GoogleFonts.poppins(
                                    color: AppColor.blackColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            }
                          ).toList(),
                        )
                      ),
                          
                      SizedBox(height: 40.h,),
                          
                      Obx(
                        () {
                          return controller.isDocSelected.value
                          ?UploadedKYCDoc(
                            onDelete: () {
                              controller.isDocSelected.value = false;
                            },
                            file: controller.kycDocFromGallery.value!,
                          )
                          :UploadKYCDoc(
                            onPressed: () {
                              uploadDocBottomsheet(
                                context: context,
                                service: controller,
                              );
                            },
                          );
                        }
                      ),
                          
                          
                    ]
                  )
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.42,),
              Obx(
                () {
                  return service.isLoading.value ? const Center(child: Loader2()) : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ConfirmButton(
                      textColor: AppColor.whiteColor,
                      backgroundColor: AppColor.darkPurpleColor,
                      text: 'Submit document',
                      onPressed: () async{
                        if(kycUrl.isEmpty || controller.kycDocType.value == "Select") {
                          showMessagePopup(
                            title: "Uh oh!", 
                            message:  "please select and upload your valid document", 
                            buttonText: "Okay", 
                            context: context
                          );
                        }
                        else{
                          await service.updateKYC(
                            context: context, 
                            kycDocUrl: kycUrl, 
                            kycDocType: controller.kycDocType.value, 
                            onSuccess: () {
                              //dismiss the selected file
                              controller.isDocSelected.value = false;
                              Get.back();
                              onRefresh();
                              kycSuccessBottomsheet(
                                context: context,
                                title: "Document uploaded",
                                subtitle: "It will take a maximum of 24 hours to confirm the details of your document"
                              );
                            }
                          );
                        }
                        
                      },
                      height: 70.h,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  );
                }
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
            ]
          ),
        )
      )
    );
  }
}