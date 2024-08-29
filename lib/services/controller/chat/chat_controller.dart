import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'package:cloudinary/cloudinary.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:image_picker/image_picker.dart';






class ChatPageController extends getx.GetxController {

  //for the message textfield on the chat page
  final TextEditingController messageTextController = TextEditingController();
  final getx.RxBool isIconTapped = false.obs;

  //for adding todo/tasks
  final TextEditingController taskNameTextController = TextEditingController();
  final TextEditingController taskDescriptionTextController = TextEditingController();
  final getx.RxString dueDate = ''.obs;
  final getx.RxString dueTime = ''.obs;
  final getx.RxString assignTask = ''.obs;

  //for edit todo/tasks
  final TextEditingController taskNameTextControllerEdit = TextEditingController();
  final TextEditingController taskDescriptionTextControllerEdit = TextEditingController();
  final getx.RxString dueDateEdit = ''.obs;
  final getx.RxString dueTimeEdit = ''.obs;
  final getx.RxString assignTaskEdit = ''.obs;







  /////////MESSAGES SECTION///////////
  final isMessageImageLoading = false.obs;
  //cloudinary config
  /// This three params can be obtained directly from your Cloudinary account Dashboard.
  /// The .signedConfig(...) factory constructor is recommended only for server side apps, where [apiKey] and 
  /// [apiSecret] are secure. 
  static const uploadPreset = 'acv3jmoj';
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "685998712312382",
    apiSecret: "WJjLp5wLBq4-Lb8oww1O5ieBfi4",
    cloudName: "dwvcga8sn",
  );


  /// checks if any image is selected at all
  //var isProfileImageSelected = false.obs;
  //user profile file
  final imageUrlController = "".obs; //save to db
  getx.Rx<File?> imageFile = getx.Rx<File?>(null);
  //pick image from gallery, display the image picked and upload to cloudinary sharps.
  Future<void> pickMessageImageFromGallery({required BuildContext context, required VoidCallback onSuccess, required VoidCallback onFailure}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        imageFile.value = File(pickedImage.path);
        //isProfileImageSelected.value = true;
        await uploadGalleryImageToCloudinary(context: context, onSuccess: onSuccess, onFailure: onFailure);
      }
    }
    catch (e) {
      debugPrint("Error Picking Image From Gallery: $e");
      //error snackbar
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "no photo was selected"
      );
    }
  }


  //upload gallery image to cloudinary
  Future<void> uploadGalleryImageToCloudinary({required BuildContext context, required VoidCallback onSuccess, required VoidCallback onFailure}) async{
    
    isMessageImageLoading.value = true;

    final response = await cloudinary.upload(
      file: imageFile.value!.path,
      //uploadPreset: "somePreset",
      resourceType: CloudinaryResourceType.image,
      folder: "dweller_users_chats_images", //change to userId
      fileName: 'dweller_${Random().nextInt(200000)}',
      progressCallback: (count, total) {
        print('Uploading image from file in progress: $count/$total');
      }
    );

  
    if(response.isSuccessful) {
      isMessageImageLoading.value = false;
      debugPrint("${response.statusCode}");
      debugPrint('cloudinary_image_url: ${response.secureUrl}');
      imageUrlController.value = response.secureUrl!;
      debugPrint(imageUrlController.value);
      onSuccess();
    }
    else {
      isMessageImageLoading.value = false;
      debugPrint("${response.statusCode}}");
      onFailure();
    }

  }
  
  //user profile file
  //pick image from camera, display the image picked and upload to cloudinary sharps.
  Future<void> pickMessageImageFromCamera({required BuildContext context, required VoidCallback onSuccess, required VoidCallback onFailure}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        imageFile.value = File(pickedImage.path);
        await uploadCameraImageToCloudinary(context: context, onSuccess: onSuccess, onFailure: onFailure);
        //update();
      }
    }
    catch (e) {
      debugPrint("Error Picking Image From Gallery: $e");
      //error snackbar
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "no photo was selected"
      );
    }
  }

  //upload camera image to cloudinary
  Future<void> uploadCameraImageToCloudinary({required BuildContext context, required VoidCallback onSuccess, required VoidCallback onFailure}) async{
    
    isMessageImageLoading.value = true;
    
    final response = await cloudinary.upload(
      file: imageFile.value!.path,
      //uploadPreset: "somePreset",
      resourceType: CloudinaryResourceType.image,
      folder: "dweller_users_chats_images", //change to userId
      fileName: 'dweller_${Random().nextInt(200000)}',
      progressCallback: (count, total) {
        print('Uploading image from file in progress: $count/$total');
      }
    );

  
    if(response.isSuccessful) {
      isMessageImageLoading.value = false;
      debugPrint("${response.statusCode}");
      debugPrint('cloudinary_image_url: ${response.secureUrl}');
      imageUrlController.value = response.secureUrl!;
      debugPrint(imageUrlController.value);
      onSuccess();
    }
    else {
      isMessageImageLoading.value = false;
      debugPrint("${response.statusCode}}");
      onFailure();
    }
  }



  //SEND PUSH NOTI COUNT
  getx.RxInt notiCount = 0.obs; // Counter for right swipes
  //check if the current user is blocked with the id
  final getx.RxBool isBlocked = false.obs;
  final getx.RxString theBlockedUser = ''.obs;




  @override
  void dispose() {
    messageTextController.dispose();
    taskNameTextController.dispose();
    taskDescriptionTextController.dispose();
    taskNameTextControllerEdit.dispose();
    taskDescriptionTextControllerEdit.dispose();
    super.dispose();
  }

}