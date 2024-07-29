import 'dart:developer';
import 'dart:io';
import 'package:cloudinary/cloudinary.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;







class SettingsController extends getx.GetxController {
  
  final isLoading = false.obs;

  //cloudinary config
  /// This three params can be obtained directly from your Cloudinary account Dashboard.
  /// The .signedConfig(...) factory constructor is recommended only for server side apps, where [apiKey] and 
  /// [apiSecret] are secure. 
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "685998712312382",
    apiSecret: "WJjLp5wLBq4-Lb8oww1O5ieBfi4",
    cloudName: "dwvcga8sn",
  );


  //functions for url_launcher (to launch user socials link)
  Future<void> launchUrlLink({required String link}) async{
    //String myPhoneNumber = "+234 07040571471";
    //Uri uri = Uri.parse(myPhoneNumber);
    Uri linkUri = Uri(
      scheme: 'https',
      path: link.replaceFirst("https://", "")
    );
    if(await launcher.canLaunchUrl(linkUri)) {
      launcher.launchUrl(
        linkUri,
        mode: launcher.LaunchMode.inAppWebView
      );
    }
    else {
      throw Exception('Can not launch uri: $linkUri');
    }
  }


  //EDIT BIO/JOB/LOCATION SETTINGS
  final TextEditingController profilejobController = TextEditingController();
  final TextEditingController profilebioController = TextEditingController();
  final TextEditingController profileLocationController = TextEditingController();



  //GENERAL SETTINGS
  //for the toggle switch
  final isPushNotiToggled = false.obs;
  final isEmailNotiToggled = false.obs;
  final isShowMeOnDwellerToggled = false.obs;
  final isOnlineStatusToggled = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController oldpasswordController = TextEditingController();
  final TextEditingController newpasswordController = TextEditingController();
  final TextEditingController confirmnewpasswordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  //phone number selector
  var phone_code = "".obs; 
  void onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    phone_code.value = countryCode.dialCode.toString();
    //phone_code.isEmpty ? "+234" : phone_code.value;
    debugPrint("New Country selected: ${phone_code.value}");
    update();
  }










  //KYC SETTINGS STUFFS
  //picked image/doc from gallery {pass it to cloudinary}
  getx.Rx<File?> kycDocFromGallery = getx.Rx<File?>(null);
  /// checks if any image/logo is selected at all
  var isDocSelected = false.obs;
  //logged-in user id
  String userId = LocalStorage.getUserID();

  //upload image to cloudinary
  Future<void> uploadKYCDocToCloudinary({required BuildContext context}) async{
    
    final response = await cloudinary.upload(
      file: kycDocFromGallery.value!.path,
      //uploadPreset: "somePreset",
      resourceType: CloudinaryResourceType.image,
      folder: "dweller_users_kyc",
      fileName: 'kyc_doc_$userId',
      progressCallback: (count, total) {
        log('Uploading image from file in progress: $count/$total');
      }
    );
  
    if(response.isSuccessful) {
      await LocalStorage.saveKYCDoc(response.secureUrl!);
      log('cloudinary_image_url_saved: ${response.secureUrl}');
      isLoading.value = false;
      //success snackbar
      /*showMySnackBar(
        context: context,
        backgroundColor: AppColor.greenColor,
        message: "kyc file uploaded successfully"
      );*/
    }
    else {
      isLoading.value = false;
      /*showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "failed to upload kyc file"
      );*/
    }
  }

  //pick image from gallery, display the image picked and upload to cloudinary sharps.
  Future<void> pickDocFromGallery({required BuildContext context}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        kycDocFromGallery.value = File(pickedImage.path);
        isDocSelected.value = true;
        isLoading.value = true;
        await uploadKYCDocToCloudinary(context: context);
        //update();
      }
      else {
        isLoading.value = false;
        throw Exception("no image/doc was picked");
      }
    }
    catch (e) {
      isLoading.value = false;
      debugPrint("Error picking image/doc From Gallery: $e");
    }
  }

  //pick image from camera, display the image picked and upload to cloudinary sharps.
  Future<void> pickDocFromCamera({required BuildContext context}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        kycDocFromGallery.value = File(pickedImage.path);
        isDocSelected.value = true;
        isLoading.value = true;
        await uploadKYCDocToCloudinary(context: context);
        //update();
      }
      else {
        isLoading.value = false;
        throw Exception("no image/doc was snapped");
      }
    }
    catch (e) {
      isLoading.value = false;
      debugPrint("Error snapping image/doc From Gallery: $e");
    }
  }




  //Select KYC Document DropDown
  getx.RxString kycDocType = "Select".obs;
  final kycOptionsList = <String>[
    "Select", 
    "National ID", 
    "Driver's License", 
    "Passport",
  ];


  //PROFILE SETTINGS SCREEN




  //SUBSCRIPTION & PAYMENT SETTINGS
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController CVVController = TextEditingController();
  
  final TextEditingController editCardNumberController = TextEditingController();
  final TextEditingController editCardHolderNameController = TextEditingController();
  final TextEditingController editExpiryDateController = TextEditingController();
  final TextEditingController editCVVController = TextEditingController();



  
  



  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();

    oldpasswordController.dispose();
    newpasswordController.dispose();
    confirmnewpasswordController.dispose();
    phoneNumberController.dispose();

    profilejobController.dispose();
    profilebioController.dispose();
    profileLocationController.dispose();


    cardNumberController.dispose();
    cardHolderNameController.dispose();
    expiryDateController.dispose();
    CVVController.dispose();
    
    editCardNumberController.dispose();
    editCardHolderNameController.dispose();
    editExpiryDateController.dispose();
    editCVVController.dispose();

    super.dispose();
  }

}