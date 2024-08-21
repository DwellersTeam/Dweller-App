import 'package:dweller/services/controller/create_profile/create_profile_controller.dart';
import 'package:dweller/services/repository/create_profile_service/create_profile_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







//Upload Photo Bottomsheet
Future<void> updateProfilePhotoBottomsheet({
  required BuildContext context,
  required CreateProfileController controller,
  required CreateProfileService service,
  required VoidCallback onRefresh,

}) async {
  final size = MediaQuery.of(context).size;
  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    useSafeArea: true,
    backgroundColor: AppColor.whiteColor,
    //barrierColor: Theme.of(context).colorScheme.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.r)
      )
    ),
    context: context, 
    builder: (context) {
      return Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              //image: DecorationImage(image: AssetImage(''),),
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      //image: DecorationImage(image: AssetImage(''),),
                      color: AppColor.greyColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    height: 7.h,
                    width: 40.w,
                  ),
                ),
                SizedBox(height: size.height * 0.03,),
                Text(
                  'Upload Picture from',
                  style: GoogleFonts.poppins(
                    color: AppColor.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(height: size.height * 0.04,),
                Obx(
                  () {
                    return controller.isProfileImageLoading.value ? const Loader() : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //1
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.pickProfileImageFromGallery(
                                    context: context,
                                    onFailure: () {
                                      showMySnackBar(
                                        context: context,
                                        backgroundColor: AppColor.redColor,
                                        message: "failed to upload photo to the server"
                                      );
                                    },
                                    onSuccess: () {
                                      service.updateUserPhotoEndpoint(
                                        context: context, 
                                        picture: controller.imageUrlController.text, 
                                        onSuccess: () {
                                          controller.imageUrlController.clear();
                                          onRefresh();
                                          Get.back();
                                        }
                                      );
                                    },
                                  );
                                  
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: size.height * 0.2,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    //image: DecorationImage(image: AssetImage(''),),
                                    color: AppColor.greyColor, ///pureLightGreyColor,
                                    borderRadius: BorderRadius.circular(20.r)
                                  ),
                                  child: Icon(
                                    size: 40.r,
                                    CupertinoIcons.folder_solid,
                                    color: AppColor.blackColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h,),
                              Text(
                                'Your Gallery',
                                style: GoogleFonts.poppins(
                                  color: AppColor.blackColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                    
                        SizedBox(width: 20.w,),
                    
                        //2
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.pickProfileImageFromCamera(
                                    context: context,
                                    onFailure: () {
                                      showMySnackBar(
                                        context: context,
                                        backgroundColor: AppColor.redColor,
                                        message: "failed to upload photo to the server"
                                      );
                                    },
                                    onSuccess: () {
                                      service.updateUserPhotoEndpoint(
                                        context: context, 
                                        picture: controller.imageUrlController.text, 
                                        onSuccess: () {
                                          controller.imageUrlController.clear();
                                          onRefresh();
                                          Get.back();
                                        }
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: size.height * 0.2,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    //image: DecorationImage(image: AssetImage(''),),
                                    color: AppColor.greyColor,  //.pureLightGreyColor,
                                    borderRadius: BorderRadius.circular(20.r)
                                  ),
                                  child: Icon(
                                    size: 40.r,
                                    CupertinoIcons.camera_fill,
                                    color: AppColor.blackColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h,),
                              Text(
                                'Your Camera',
                                style: GoogleFonts.poppins(
                                  color: AppColor.blackColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                    
                      ],
                    );
                  }
                ),
                SizedBox(height: size.height * 0.02,),
              ],
            ),
          ),
        ],
      );
    }
  );
}