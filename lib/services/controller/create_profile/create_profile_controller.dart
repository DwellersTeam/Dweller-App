import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloudinary/cloudinary.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';








class CreateProfileController extends getx.GetxController {

  final isCloudinaryImageLoading = false.obs;
  final isProfileImageLoading = false.obs;
  

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


  //selected index
  int selectedindex = -1; //-1 Initialize to -1 to indicate no selection


  //Dweller Type Selection//
  List<Map<String, dynamic>> dwellerTypeList = [
    { 
      "icon": "🏡",
      "type": 'Host',
      "description": "I have a room/apartment and i would like a roomate to join me here"
    },
    {
      "icon": "🔍",
      "type": 'Seeker',
      "description": "I do not have a room/apartment and i'm looking for a roommate with a space to dwell with"
    },
  ];

  //save to db
  final TextEditingController selectedDwellerType = TextEditingController();
  var isDwellerSelected = false.obs; //save to db
  
  //(save to db)
  void onDwellerTypeSelected({required int index}) {
    isDwellerSelected.value = true;
    selectedDwellerType.text = dwellerTypeList[index]['type'];
    print('Selected Dweller Type: ${selectedDwellerType.text}');
    // You can perform any other actions based on the selected animal here
  }


  //PHASE 1//
  final TextEditingController userNameController = TextEditingController();
  //final TextEditingController birthdayController = TextEditingController();
  final getx.RxString birthdayController = ''.obs;
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  //final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController currentMobileLocationController = TextEditingController();
  //final TextEditingController expectedApartmentLocationController = TextEditingController();
  //phone number selector
  var phone_code = "".obs; //save to db
  void onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    phone_code.value = countryCode.dialCode.toString();
    //phone_code.isEmpty ? "+234" : phone_code.value;
    debugPrint("Country Code selected: ${phone_code.value}");
    update();
  }
  getx.RxBool isPhase1ButtonEnabledH = false.obs;


  
  List<dynamic> overallPets = []; //SAVE TO DB
  List<dynamic> overallLivelihood = []; //SAVE TO DB

  //PHASE 3//
  //Livelihood
  //
  getx.RxBool showMoreLivelihood = false.obs;
  int selectedLivelihoodIndex = -1;
  final List<String> livelihooditems = [
    'Student', 
    'Worker',
    'Entrepreneur', 
    'More'
  ];
  //(save to db)
  final TextEditingController selectedLivelihoodController = TextEditingController();
  final TextEditingController moreLivelihoodController = TextEditingController();

  void onLivelihoodSelected({required int index}) {
    selectedLivelihoodController.text = livelihooditems[index];
    print('Selected Livelihood: ${selectedLivelihoodController.text}');
    if(selectedLivelihoodController.text != 'More') {
      overallLivelihood
      ..clear()
      ..add(selectedLivelihoodController.text);
      print('livelihood list: $overallLivelihood');
    }
    else{
      overallLivelihood
      ..clear()
      ..add(moreLivelihoodController.text);
      print('livelihood list: $overallLivelihood');
    }
    
    // You can perform any other actions based on the selected animal here
    update();
  }

  //Main Hobbies and Interests
  List<String> mainHobbiesList = [
    'Gaming',
    'Arts & Crafts',
    'Music',
    'Travelling',
    'Outdoor activities',
    'Hiking',
    'Concerts',
    'Reading',
    'Cooking',
    'Sports',
    // Add more pet names as needed
  ];
  List<String> selectedMainHobbiesList = []; //SAVE TO DB

  //Noise Level
  int selectedNoiseLevelIndex = -1;
  final List<String> noiselevelitems = [
    'Quiet', 
    'Moderate',
    'Loud', 
  ];
  //(save to db)
  final TextEditingController selectedNoiseLevelController = TextEditingController();

  void onNoiseLevelSelected({required int index}) {
    selectedNoiseLevelController.text = noiselevelitems[index];
    print('Selected Noise Level: ${selectedNoiseLevelController.text}');
    // You can perform any other actions based on the selected animal here
  }

  //Zodiac Sign
  int selectedZodiacSignIndex = -1;
  final List<String> zodiacsignitems = [
    'Aries  ♈',
    'Taurus  ♉',
    'Gemini  ♊',
    'Cancer  ♋',
    'Virgo  ♍',
    'Libra  ♎',
    "Capricon  ♑",
    'Aquarius ♒',
    'Sagarittus  ♐',
    'Leo  ♌',
    'Pisces  ♓',
    'Scorpio  ♏',
    'Not Interested'
  ];
  //(save to db)
  final TextEditingController selectedZodiacSignController = TextEditingController();

  void onZodiacSignSelected({required int index}) {
    selectedZodiacSignController.text = zodiacsignitems[index];
    print('Selected ZodiacSign: ${selectedZodiacSignController.text}');
    // You can perform any other actions based on the selected animal here
  }

  //Sexual Orientation
  getx.RxBool showMoreSexualOrientation = false.obs;
  int selectedSexualOrientationIndex = -1;
  final List<String> sexualorientationitems = [
    'Male', 
    'Female',
    //'Transgender', 
    'More',
  ];
  //(save to db)
  final TextEditingController selectedSexualOrientationController = TextEditingController();
  final TextEditingController moreSexualOrientationController = TextEditingController();

  void onSexualOrientationSelected({required int index}) {
    selectedSexualOrientationController.text = sexualorientationitems[index];
    print('Selected Sexual Orientation: ${selectedSexualOrientationController.text}');
    // You can perform any other actions based on the selected animal here
  }

  //Alcohol Intake
  int selectedAlcoholIntakeIndex = -1;
  final List<String> alcoholintakeitems = [
    'Social drinker', 
    'Occasional drinker',
    'Non-drinker', 
    'Regular drinker'
  ];
  //(save to db)
  final TextEditingController selectedAlcoholIntakeController = TextEditingController();

  void onAlcoholIntakeSelected({required int index}) {
    selectedAlcoholIntakeController.text = alcoholintakeitems[index];
    print('Selected Alcohol Intake Level: ${selectedAlcoholIntakeController.text}');
    // You can perform any other actions based on the selected animal here
  }

  //Pets
  getx.RxBool showMorePets = false.obs;
  int selectedPetsIndex = -1;
  final List<String> petsitems = [
    'None', 
    'Dog',
    'Cat', 
    'More'
  ];
  //(save to db)
  final TextEditingController selectedPetsController = TextEditingController();
  final TextEditingController morePetsController = TextEditingController();

  void onPetsSelected({required int index}) {
    selectedPetsController.text = petsitems[index];
    print('Selected Pets: ${selectedPetsController.text}');
    if(selectedPetsController.text != 'More') {
      overallPets
      ..clear()
      ..add(selectedPetsController.text);
      print('pets list: $overallPets');
    }
    else{
      overallPets
      ..clear()
      ..add(morePetsController.text);
      print('pets list: $overallPets');
    }
     
    // You can perform any other actions based on the selected animal here
  }

  //Sleep Schedule
  int selectedSleepScheduleIndex = -1;
  final List<String> sleepscheduleitems = [
    'Early Riser', 
    'Night Owl',
    'Flexible', 
  ];
  //(save to db)
  final TextEditingController selectedSleepScheduleController = TextEditingController();

  void onSleepScheduleSelected({required int index}) {
    selectedSleepScheduleController.text = sleepscheduleitems[index];
    print('Selected Sleep Schedule: ${selectedSleepScheduleController.text}');
    // You can perform any other actions based on the selected animal here
  }

  //Work/study Schedule
  int selectedWorkScheduleIndex = -1;
  final List<String> workscheduleitems = [
    '9-5', 
    'Irregular hours',
    'Student with varying class times', 
  ];
  //(save to db)
  final TextEditingController selectedWorkScheduleController = TextEditingController();

  void onWorkScheduleSelected({required int index}) {
    selectedWorkScheduleController.text = workscheduleitems[index];
    print('Selected Work Schedule: ${selectedWorkScheduleController.text}');
    // You can perform any other actions based on the selected animal here
  }

  //Guest Intake Schedule
  getx.RxBool showNextBotton = false.obs;
  int selectedGuestIntakeIndex = -1;
  final List<String> guestintakeitems = [
    'Open to frequent guests', 
    'Occasional guests',
    'Rarely has guests', 
  ];
  
  //(save to db)
  final TextEditingController selectedGuestIntakeController = TextEditingController();

  void onGuestIntakeSelected({required int index}) {
    selectedGuestIntakeController.text = guestintakeitems[index];
    print('Selected Guest Intake: ${selectedGuestIntakeController.text}');
    // You can perform any other actions based on the selected animal here
  }

  //PHASE 4//
  //HOST PHASE 4 (SETTING UP YOUR PROFILE)//
  /// checks if any image is selected at all
  var isProfileImageSelected = false.obs;
  //user profile file
  final TextEditingController imageUrlController = TextEditingController(); //save to db
  getx.Rx<File?> imageFile = getx.Rx<File?>(null);
  //pick image from gallery, display the image picked and upload to cloudinary sharps.
  Future<void> pickProfileImageFromGallery({required BuildContext context, required VoidCallback onSuccess, required VoidCallback onFailure}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        imageFile.value = File(pickedImage.path);
        isProfileImageSelected.value = true;
        await uploadGalleryImageToCloudinary(context: context, onSuccess: onSuccess, onFailure: onFailure);
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


  //upload gallery image to cloudinary
  Future<void> uploadGalleryImageToCloudinary({required BuildContext context, required VoidCallback onSuccess, required VoidCallback onFailure}) async{
    
    isProfileImageLoading.value = true;

    final response = await cloudinary.upload(
      file: imageFile.value!.path,
      //uploadPreset: "somePreset",
      resourceType: CloudinaryResourceType.image,
      folder: "dweller_users_profile_photo", //change to userId
      fileName: 'dweller_${Random().nextInt(200000)}',
      progressCallback: (count, total) {
        print('Uploading image from file in progress: $count/$total');
      }
    );

  
    if(response.isSuccessful) {
      isProfileImageLoading.value = false;
      debugPrint("${response.statusCode}");
      debugPrint('cloudinary_image_url: ${response.secureUrl}');
      imageUrlController.text = response.secureUrl!;
      LocalStorage.saveCloudinaryUrl(response.secureUrl!);
      debugPrint(imageUrlController.text);
      onSuccess();
    }
    else {
      isProfileImageLoading.value = false;
      debugPrint("${response.statusCode}}");
      onFailure();
    }
    update();
  }
  
  //user profile file
  //pick image from camera, display the image picked and upload to cloudinary sharps.
  Future<void> pickProfileImageFromCamera({required BuildContext context, required VoidCallback onSuccess, required VoidCallback onFailure}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        imageFile.value = File(pickedImage.path);
        isProfileImageSelected.value = true;
        await uploadCameraImageToCloudinary(context: context, onSuccess: onSuccess, onFailure: onFailure);
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

  //upload camera image to cloudinary
  Future<void> uploadCameraImageToCloudinary({required BuildContext context, required VoidCallback onSuccess, required VoidCallback onFailure}) async{
    
    isProfileImageLoading.value = true;
    
    final response = await cloudinary.upload(
      file: imageFile.value!.path,
      //uploadPreset: "somePreset",
      resourceType: CloudinaryResourceType.image,
      folder: "dweller_users_profile_photo", //change to userId
      fileName: 'dweller_${Random().nextInt(200000)}',
      progressCallback: (count, total) {
        print('Uploading image from file in progress: $count/$total');
      }
    );

  
    if(response.isSuccessful) {
      isProfileImageLoading.value = false;
      debugPrint("${response.statusCode}");
      debugPrint('cloudinary_image_url: ${response.secureUrl}');
      imageUrlController.text = response.secureUrl!;
      LocalStorage.saveCloudinaryUrl(response.secureUrl!);
      debugPrint(imageUrlController.text);
      onSuccess();
    }
    else {
      isProfileImageLoading.value = false;
      debugPrint("${response.statusCode}}");
      onFailure();
    }
    update();
  }

  


  //user profile about description
  final TextEditingController aboutUserController = TextEditingController();
  
  

  //TO SELECT MULTIPLE PICTURES OF AN INSTANCE
  List<File> selectedImages = []; // List of selected image
  List<dynamic> selectedImagesUrl = []; // List of selected image(save to DB)

  Future getImages({required BuildContext context, required VoidCallback onSuccess, required VoidCallback onFailure}) async {
	  final pickedFile = await ImagePicker().pickMultiImage(
		  imageQuality: 100, // To set quality of images
	    maxHeight: 1000, // To set maxheight of images that you want in your app
	    maxWidth: 1000
    ); 
    // To set maxheight of images that you want in your app
	  List<XFile> xfilePick = pickedFile; 

		  // if atleast 1 images is selected it will add 
		  // all images in selectedImages
		  // variable so that we can easily show them in UI
		  if (xfilePick.isNotEmpty) {
		    for (var i = 0; i < xfilePick.length; i++) {
			    selectedImages.add(File(xfilePick[i].path));
		    }
        print("selected files $selectedImages");
        await uploadImagesListToCloudinary(
          onFailure: onFailure,
          context: context,
          selectedImagesList: selectedImages,
          onSuccess: onSuccess,
          imageUrls: selectedImagesUrl
        );
		  } 
      else {
		    debugPrint("Error Picking Image From Gallery: $e");
        //error snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "no photo was selected"
      );
    }
  }

  Future<void> uploadImagesListToCloudinary({
    required BuildContext context,
    required List<File> selectedImagesList,
    required List<dynamic> imageUrls,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {

    const uploadPreset = 'acv3jmoj';
    const apiKey = "685998712312382";
    const apiSecret = "WJjLp5wLBq4-Lb8oww1O5ieBfi4";
    const cloudName = "dwvcga8sn";
    const cloudinaryUrl = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

    List<String> tempImageUrls = [];

    for (File image in selectedImagesList) {
      try {
        String mimeType = lookupMimeType(image.path) ?? 'image/jpeg';
        List<String> mimeTypeParts = mimeType.split('/');

        final request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl))
          ..fields['upload_preset'] = uploadPreset
          ..fields['api_key'] = apiKey
          ..fields['timestamp'] = DateTime.now().millisecondsSinceEpoch.toString()
          ..files.add(
            await http.MultipartFile.fromPath(
              'file',
              image.path,
              contentType: MediaType(mimeTypeParts[0], mimeTypeParts[1]),
            ),
          );

        final response = await request.send();
        final responseString = await response.stream.bytesToString();

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(responseString);
          String imageUrl = jsonResponse['secure_url'];
          tempImageUrls.add(imageUrl);
          print('Upload successful: $imageUrl');
        } 
        else {
          print('Upload failed ${response.statusCode}: $responseString');
          onFailure();
          return;
        }
      } 
      catch (e) {
        print('Exception during upload: $e');
        onFailure();
        return;
      }
    }

    // Update imageUrls after all uploads are successful
    imageUrls.addAll(tempImageUrls);
    tempImageUrls.clear();
    onSuccess();
  }





  
  //user profile sub-images
  //1//
  //save to db
  List<String> displayPicturesList = []; //SAVE TO DB
  final TextEditingController firstSubImageController = TextEditingController();
  //upload first sub-image picture
  getx.Rx<File?> firstSubImage = getx.Rx<File?>(null);
  /// checks if any image is selected at all
  var isSubImage1Selected = false.obs;
  //pick image from gallery, display the image picked and upload to cloudinary sharps.
  Future<void> pickFirstSubImageFromGallery({required BuildContext context}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        firstSubImage.value = File(pickedImage.path);
        isSubImage1Selected.value = true;
        await uploadFirstSubImageToCloudinary(context: context);
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
  Future<void> uploadFirstSubImageToCloudinary({required BuildContext context}) async{

    isCloudinaryImageLoading.value = true;

    final response = await cloudinary.upload(
      file: firstSubImage.value!.path,
      //uploadPreset: "somePreset",
      resourceType: CloudinaryResourceType.image,
      folder: "dweller_users_photo",
      fileName: 'dweller_${Random().nextInt(200000)}',
      progressCallback: (count, total) {
        print('Uploading image from file in progress: $count/$total');
      }
    );
  
    if(response.isSuccessful) {
      isCloudinaryImageLoading.value = false;
      debugPrint("${response.statusCode}");
      debugPrint('cloudinary_image_url: ${response.secureUrl}');
      firstSubImageController.text = response.secureUrl!;
      debugPrint(firstSubImageController.text);
      displayPicturesList
      ..clear()
      ..add(firstSubImageController.text);
      print('display pics list: $displayPicturesList');
    }
    else {
      isCloudinaryImageLoading.value = false;
      debugPrint("${response.statusCode}}");
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "failed to upload photo: ${response.statusCode}"
      );
    }
  }
  
  //2//
  final TextEditingController secondSubImageController = TextEditingController();
  //upload first sub-image picture
  getx.Rx<File?> secondSubImage = getx.Rx<File?>(null);
  /// checks if any image is selected at all
  var isSubImage2Selected = false.obs;
  //pick image from gallery, display the image picked and upload to cloudinary sharps.
  Future<void> pickSecondSubImageFromGallery({required BuildContext context}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        secondSubImage.value = File(pickedImage.path);
        isSubImage2Selected.value = true;
        await uploadSecondSubImageToCloudinary(context: context);
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
  Future<void> uploadSecondSubImageToCloudinary({required BuildContext context}) async{
    isCloudinaryImageLoading.value = true;
    final response = await cloudinary.upload(
      file: secondSubImage.value!.path,
      //uploadPreset: "somePreset",
      resourceType: CloudinaryResourceType.image,
      folder: "dweller_users_photo",
      fileName: 'dweller_${Random().nextInt(200000)}',
      progressCallback: (count, total) {
        print('Uploading image from file in progress: $count/$total');
      }
    );
  
    if(response.isSuccessful) {
      isCloudinaryImageLoading.value = false;
      debugPrint("${response.statusCode}");
      debugPrint('cloudinary_image_url: ${response.secureUrl}');
      secondSubImageController.text = response.secureUrl!;
      debugPrint(secondSubImageController .text);
      displayPicturesList
      //.addIf(firstSubImageController.text.isNotEmpty, secondSubImageController.text);
      .add(secondSubImageController.text);
      print('display pics list: $displayPicturesList');
    }
    else {
      isCloudinaryImageLoading.value = false;
      debugPrint("${response.statusCode}}");
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "failed to upload photo: ${response.statusCode}"
      );
    }
  }



  //MANIPULATION TO DELETE LIST OF DISPLAY PICTURES
  List<dynamic> selectedPicsForDeletion = []; //SAVE TO DB


  










  @override
  void dispose() {
    // TODO: implement dispose
    selectedDwellerType.dispose();
    userNameController.dispose();
    //birthdayController.dispose();
    occupationController.dispose();
    schoolController.dispose();
    currentMobileLocationController.dispose();

    selectedLivelihoodController.dispose();
    moreLivelihoodController.dispose();

    selectedNoiseLevelController.dispose();

    selectedZodiacSignController.dispose();

    selectedSexualOrientationController.dispose();
    moreSexualOrientationController.dispose();

    selectedAlcoholIntakeController.dispose();

    selectedPetsController.dispose();
    morePetsController.dispose();

    selectedSleepScheduleController.dispose();

    selectedWorkScheduleController.dispose();

    selectedGuestIntakeController.dispose();
    imageUrlController.dispose();
    aboutUserController.dispose();

    firstSubImageController.dispose();
    secondSubImageController.dispose();
    super.dispose();
  }

}