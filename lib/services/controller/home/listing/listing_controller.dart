import 'package:dweller/model/listing/facility_model.dart';
import 'package:get/get.dart' as getx;
import 'dart:io';
import 'dart:math';
import 'package:cloudinary/cloudinary.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';











class ListingController extends getx.GetxController {
  

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

  //PHASE 2//
  ///HOST PHASE 2
  final TextEditingController propertyLocationController = TextEditingController();
  final TextEditingController buildingTypeController = TextEditingController();
  final TextEditingController propertySizeController = TextEditingController();
  final TextEditingController rentController = TextEditingController();
  final TextEditingController parkingLotController = TextEditingController();
  final TextEditingController floorsController = TextEditingController();
  final TextEditingController roomsController = TextEditingController();
  final TextEditingController storageController = TextEditingController();
  //cloudinary image response url
  final TextEditingController propImage1 = TextEditingController();
  final TextEditingController propImage2 = TextEditingController();
  final TextEditingController propImage3 = TextEditingController();
  
  //building type
  final List<String> items = [
    //'',
    'Bungalow', 
    'Storey building',
    'Duplex', 
  ];
  final selectedBuildingTypeValue = 'Bungalow'.obs; //SAVED TO DB
  void toggleBuildingType(String? newValue) {
    selectedBuildingTypeValue.value = newValue!;
  }

  //parking space
  final List<String> itemsParking = [
    'Yes', 
    'No',
  ];
  final selectedParkingLotValue = 'Yes'.obs; //SAVED TO DB
  void toggleParkingLot(String? newValue) {
    selectedParkingLotValue.value = newValue!;
  }

  //ample storage space
  final List<String> itemsStorage = [
    'Yes', 
    'No',
  ];
  final selectedAmpleStorageValue = 'Yes'.obs; //SAVED TO DB
  void toggleAmpleStorage(String? newValue) {
    selectedAmpleStorageValue.value = newValue!;
  }


  //1//
  //upload first property picture
  getx.Rx<File?> firstPropImage = getx.Rx<File?>(null);
  /// checks if any image is selected at all
  var isPropImage1Selected = false.obs;
  //pick image from gallery, display the image picked and upload to cloudinary sharps.
  Future<void> pickFirstPropertyImageFromGallery({required BuildContext context}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        firstPropImage.value = File(pickedImage.path);
        isPropImage1Selected.value = true;
        await uploadFirstPropertyImageToCloudinary(context: context);
        update();
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

  //upload image to cloudinary
  Future<void> uploadFirstPropertyImageToCloudinary({required BuildContext context}) async{
    isLoading.value = true;
    final response = await cloudinary.upload(
      file: firstPropImage.value!.path,
      //uploadPreset: "somePreset",
      resourceType: CloudinaryResourceType.image,
      folder: "dweller_users_photo",
      fileName: 'dweller_${Random().nextInt(200000)}',
      progressCallback: (count, total) {
        print('Uploading image from file in progress: $count/$total');
      }
    );
  
    if(response.isSuccessful) {
      isLoading.value = false;
      debugPrint("${response.statusCode}");
      debugPrint('cloudinary_image_url: ${response.secureUrl}');
      propImage1.text = response.secureUrl!;
      debugPrint(propImage1.text);
    }
    else {
      isLoading.value = false;
      debugPrint("${response.statusCode}}");
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "failed to upload photo: ${response.statusCode}"
      );
    }
  }
  
  //2//
  //upload first property picture
  getx.Rx<File?> secondPropImage = getx.Rx<File?>(null);
  /// checks if any image is selected at all
  var isPropImage2Selected = false.obs;
  //pick image from gallery, display the image picked and upload to cloudinary sharps.
  Future<void> pickSecondPropertyImageFromGallery({required BuildContext context}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        secondPropImage.value = File(pickedImage.path);
        isPropImage2Selected.value = true;
        await uploadSecondPropertyImageToCloudinary(context: context);
        update();
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

  //upload image to cloudinary
  Future<void> uploadSecondPropertyImageToCloudinary({required BuildContext context}) async{
    isLoading.value = true;
    final response = await cloudinary.upload(
      file: secondPropImage.value!.path,
      //uploadPreset: "somePreset",
      resourceType: CloudinaryResourceType.image,
      folder: "dweller_users_photo",
      fileName: 'dweller_${Random().nextInt(200000)}',
      progressCallback: (count, total) {
        print('Uploading image from file in progress: $count/$total');
      }
    );
  
    if(response.isSuccessful) {
      isLoading.value = false;
      debugPrint("${response.statusCode}");
      debugPrint('cloudinary_image_url: ${response.secureUrl}');
      propImage2.text = response.secureUrl!;
      debugPrint(propImage2.text);
    }
    else {
      isLoading.value = false;
      debugPrint("${response.statusCode}}");
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "failed to upload photo: ${response.statusCode}"
      );
    }
  }


  //3//
  //upload first property picture
  getx.Rx<File?> thirdPropImage = getx.Rx<File?>(null);
  /// checks if any image is selected at all
  var isPropImage3Selected = false.obs;
  //pick image from gallery, display the image picked and upload to cloudinary sharps.
  Future<void> pickThirdPropertyImageFromGallery({required BuildContext context}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        thirdPropImage.value = File(pickedImage.path);
        isPropImage3Selected.value = true;
        await uploadThirdPropertyImageToCloudinary(context: context);
        update();
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

  //upload image to cloudinary
  Future<void> uploadThirdPropertyImageToCloudinary({required BuildContext context}) async{
    isLoading.value = true;
    final response = await cloudinary.upload(
      file: thirdPropImage.value!.path,
      //uploadPreset: "somePreset",
      resourceType: CloudinaryResourceType.image,
      folder: "dweller_users_photo", //change to userId
      fileName: 'dweller_${Random().nextInt(200000)}',
      progressCallback: (count, total) {
        print('Uploading image from file in progress: $count/$total');
      }
    );
  
    if(response.isSuccessful) {
      isLoading.value = false;
      debugPrint("${response.statusCode}");
      debugPrint('cloudinary_image_url: ${response.secureUrl}');
      propImage3.text = response.secureUrl!;
      debugPrint(propImage3.text);
    }
    else {
      isLoading.value = false;
      debugPrint("${response.statusCode}}");
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "failed to upload photo: ${response.statusCode}"
      );
    }
  }


  //////////////////////////////////////////
  //Facilities List
  List<FacilityModel> facilitiesList = [
    FacilityModel(
      name: 'Storage', 
      icon: 'assets/svg/storage.svg'
    ),
    FacilityModel(
      name: 'Gym', 
      icon: 'assets/svg/gym.svg', 
    ),
    FacilityModel(
      name: 'EV Charging', 
      icon: 'assets/svg/ev_charger.svg',
    ),
    FacilityModel(
      name: 'Parking', 
      icon: 'assets/svg/parking.svg',
    ),
    FacilityModel(
      name: 'Wifi', 
      icon: 'assets/svg/wifi.svg',
    ),
    FacilityModel(
      name: 'Kids Park', 
      icon: 'assets/svg/kids.svg',
    ),
  ];
  List<FacilityModel> selectedFacilitiesList = []; //SAVE TO DB




  //EDITING PROPERTY/LISTING
  final TextEditingController propertyLocationControllerEdit = TextEditingController();
  final TextEditingController buildingTypeControllerEdit = TextEditingController();
  final TextEditingController propertySizeControllerEdit = TextEditingController();
  final TextEditingController rentControllerEdit = TextEditingController();
  final TextEditingController floorsControllerEdit = TextEditingController();
  final TextEditingController roomsControllerEdit = TextEditingController();




  @override
  void dispose() {
    propertyLocationController.dispose();
    buildingTypeController.dispose();
    propertySizeController.dispose();
    rentController.dispose();
    parkingLotController.dispose();
    floorsController.dispose();
    roomsController.dispose();
    storageController.dispose();
    propImage1.dispose();
    propImage2.dispose();
    propImage3.dispose();

    propertyLocationControllerEdit.dispose();
    buildingTypeControllerEdit.dispose();
    propertySizeControllerEdit.dispose();
    rentControllerEdit.dispose();
    floorsControllerEdit.dispose();
    roomsControllerEdit.dispose();
    super.dispose();
  }

}