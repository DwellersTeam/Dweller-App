import 'dart:convert';
import 'dart:developer';
import 'package:dweller/model/auth/token_response.dart';
import 'package:dweller/model/listing/property_model.dart';
import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/services/controller/main_page/mainpage_controller.dart';
import 'package:dweller/services/repository/data_service/base_service/base_service.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:get/get.dart';










class CreateProfileService extends getx.GetxController {
  

  final baseService = getx.Get.put(BaseService());
  final mainPageController = Get.put(MainPageController());
  final FCMToken = LocalStorage.getFCMToken();
  final token = LocalStorage.getToken();
  final tokenExpDateInt = LocalStorage.getTokenExpDate() ?? 0;
  final userId = LocalStorage.getUserID();
  final isLoading = false.obs;  
  final isLoadingAdd = false.obs;  




  //DECODE USER JWT
  Future<UserModel> fetchUserDetailFromJWT(BuildContext context) async {
    isLoading.value = true;
    try {  

      isLoading.value = false;
      // Decode the JWT token with the awesome package {JWT Decoder}
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      log("Decoded jwt: $decodedToken");
      UserModel jsonResponse = UserModel.fromJson(
        {
          'property': decodedToken['property'] ?? false,
          'picture': decodedToken['picture'] ?? '',
          'firstname': decodedToken['firstname'] ?? '',
          'lastname': decodedToken['lastname'] ?? '',
          'email': decodedToken['email'] ?? '',
          '_id': decodedToken['_id'] ?? '',
        }
      );
      return jsonResponse;
    }

    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  
  }
  

  //FETCH ANY USER BY ID
  Future<UserModel> getUserByIdEndpoint({required BuildContext context, required String id}) async {
    isLoading.value = true;
    try {

      http.Response res = await baseService.httpGet(endPoint: "users/$id",);

      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');

        /*if(res.headers['x-accessToken']!.isNotEmpty || res.headers['x-accessToken'] != null){
          //save access token from header
          LocalStorage.saveToken(res.headers['x-accessToken']!);
        }*/
        
        //decode response from the server
        UserModel jsonResponse = UserModel.fromJson(json.decode(res.body));

        return jsonResponse;

      }
      else{
        isLoading.value = false;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        baseService.showErrorMessage(
          httpStatusCode: res.statusCode,
          context: context
        );
        throw Exception("failed to fetch current user");
      }

    }


    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  
  }
  

  //FETCH CURRENT USER
  Future<UserModel> getCurrentUserEndpoint(BuildContext context) async {
    isLoading.value = true;
    try {

      http.Response res = await baseService.httpGet(endPoint: "users/me",);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        
        //decode response from the server
        UserModel jsonResponse = UserModel.fromJson(json.decode(res.body));

        return jsonResponse;

      }
      else{
        isLoading.value = false;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        baseService.showErrorMessage(
          httpStatusCode: res.statusCode,
          context: context
        );
        throw Exception("failed to fetch current user");
      }

    }


    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  
  }



  Map<String, dynamic> myPreferenceMap = {};
  Future<Map<String, dynamic>> addToMap({
    required String noiseLevel,
    required String smoke,
    required String alchohol,
    required String sleepSchedule,
    required String workStudySchedule,
    required String visitors,
    required List<dynamic> interests,
    required List<dynamic> pets,
    required List<dynamic> livelihood,
  }) async{
    Map<String, dynamic> userMap =  {
      "noise": noiseLevel,
      "smoke": smoke,
      "alchohol": alchohol,
      "sleepSchedule": sleepSchedule,
      "wrokStudySchedule": workStudySchedule,
      "visitors": visitors,
      "interests": interests,
      "pets": pets,
      "livelihood": livelihood
    };
    myPreferenceMap.addAll(userMap);
    log("preference map: $myPreferenceMap");
    return myPreferenceMap;
  }
  //UPDATE CURRENT USER PROFILE UPON CREATION OF ACCOUNT
  Future<void> updateUserEndpoint({
    required BuildContext context,
    required String gender,
    required String dateOfBirth,
    required String dwellerKind,
    required String bio,
    required String job,
    required String school,
    required String kyc_doc_type,
    required String kyc_doc_url,
    required String display_picture,
    required List<String> pictures,
    required Map<String, dynamic> location,
    required Map<String, dynamic> preferences,
    required String phoneNumber,
    required String authProvider,
  

    required VoidCallback onSuccess,
    }) async {
    isLoading.value = true;
    try {

      final body = 
      authProvider == 'email' ?  {
        //"username": "nil",
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "dwellerKind": dwellerKind,  //"host", //seeker
        "bio": bio,
        "job": job,
        "school": school,
        "picture": display_picture,
        "pictures": pictures,
        "location": location,

        "kyc": {
          "document": kyc_doc_type,
          "url": kyc_doc_url
        },

        "preferences": preferences,
  
      }:
      {
        //"username": "nil",
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "dwellerKind": dwellerKind,  //"host", //seeker
        "bio": bio,
        'phone': phoneNumber,

        "job": job,
        "school": school,
        
        "picture": display_picture,
        "pictures": pictures,
        "location": location,

        "kyc": {
          "document": kyc_doc_type,
          "url": kyc_doc_url
        },
      
        "preferences": preferences,
  
      };

      log("payload: $body");

      http.Response res = await baseService.httpPatch(endPoint: "users/me", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        
        //decode response from the server
        final TokenResponse jsonResponse = TokenResponse.fromJson(jsonDecode(res.body));
        LocalStorage.saveDwellerType(dwellerKind);
        LocalStorage.saveToken(jsonResponse.accessToken);
        LocalStorage.saveXrefreshToken(jsonResponse.refreshToken);

        log("$jsonResponse");
        onSuccess();

      }
      else{
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        baseService.showErrorMessage(
          httpStatusCode: res.statusCode,
          context: context
        );
        throw Exception("failed to update user profile");
      }

    }


    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  
  }



  //UPDATE BIO, OCCUPATION,LOCATION
  Future<void> updateBioEndpoint({
    required BuildContext context,
    required Map<String, dynamic> location,
    required String job,
    required String bio,

    //w.r.t user location from Google Maps API
    //required String placeId,
    required VoidCallback onSuccess,
    }) async {
    isLoading.value = true;
    try {

      final body = {
        "bio": bio,
        "job": job,
        "location": location,
      };
      

      http.Response res = await baseService.httpPatch(endPoint: "users/me", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        
        //decode response from the server
        final TokenResponse jsonResponse = TokenResponse.fromJson(jsonDecode(res.body));

        LocalStorage.saveToken(jsonResponse.accessToken);
        LocalStorage.saveXrefreshToken(jsonResponse.refreshToken);

        log("$jsonResponse");
        onSuccess();

      }
      else{
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        baseService.showErrorMessage(
          httpStatusCode: res.statusCode,
          context: context
        );
        throw Exception("failed to update user bio details");
      }
    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }



  //UPDATE CURRENT USER LIFESTYLE
  Future<void> updateUserPreferenceEndpoint({
    required BuildContext context,
    //required String job,
    required String noiseLevel,
    required String smoke,
    required String alchohol,
    required String sleepSchedule,
    required String workStudySchedule,
    required String visitors,
    required List<dynamic> interests,
    required List<dynamic> pets,
    required List<dynamic> livelihood,
    required VoidCallback onSuccess,
    }) async {
    isLoading.value = true;
    try {

      final body = {
        //"job": job,
        "preferences": {
          "noise": noiseLevel,
          "smoke": smoke,
          "alchohol": alchohol,
          "sleepSchedule": sleepSchedule,
          "wrokStudySchedule": workStudySchedule,
          "visitors": visitors,
          "interests": interests,
          "pets": pets,
          "livelihood": livelihood
        },
  
      };
      
      http.Response res = await baseService.httpPatch(endPoint: "users/me", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        
        //decode response from the server
        //final dynamic jsonResponse = json.decode(res.body);
        //decode response from the server
        final TokenResponse jsonResponse = TokenResponse.fromJson(jsonDecode(res.body));
        LocalStorage.saveToken(jsonResponse.accessToken);
        LocalStorage.saveXrefreshToken(jsonResponse.refreshToken);

        log("$jsonResponse");
        onSuccess();

      }
      else{
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        baseService.showErrorMessage(
          httpStatusCode: res.statusCode,
          context: context
        );
        throw Exception("failed to update user preference");
      }

    }


    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }


  //UPDATE CURRENT USER PROFILE PHOTO
  Future<void> updateUserPhotoEndpoint({
    required BuildContext context,
    required String picture,
    required VoidCallback onSuccess,
    }) async {
    isLoading.value = true;
    try {

      final body = {
        "picture": picture,
      };
      
      http.Response res = await baseService.httpPatch(endPoint: "users/me", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        
        //decode response from the server
        final TokenResponse jsonResponse = TokenResponse.fromJson(jsonDecode(res.body));

        LocalStorage.saveToken(jsonResponse.accessToken);
        LocalStorage.saveXrefreshToken(jsonResponse.refreshToken);

        log("$jsonResponse");
        onSuccess();

      }
      else{
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        baseService.showErrorMessage(
          httpStatusCode: res.statusCode,
          context: context
        );
        throw Exception("failed to update your profile picture");
      }

    }

    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  
  }


  //UPDATE CURRENT USER PHONE NUMBER
  Future<void> updateUserPhoneNumberEndpoint({
    required BuildContext context,
    required String phone,
    required VoidCallback onSuccess,
    }) async {
    isLoading.value = true;
    try {

      final body = {
        "phone": phone,
      };
      
      http.Response res = await baseService.httpPatch(endPoint: "users/me", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        
        //decode response from the server
        final TokenResponse jsonResponse = TokenResponse.fromJson(jsonDecode(res.body));

        LocalStorage.saveToken(jsonResponse.accessToken);
        LocalStorage.saveXrefreshToken(jsonResponse.refreshToken);

        log("$jsonResponse");
        onSuccess();

      }
      else{
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        baseService.showErrorMessage(
          httpStatusCode: res.statusCode,
          context: context
        );
        throw Exception("failed to updateyour  mobile number");
      }

    }

    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  
  }



  //UPDATE CURRENT USER DISPLAY PHOTOS 
  //List<dynamic> addDisplayPicturesList = [];
  Future<void> updateUserDisplayPhotosEndpoint({
    required BuildContext context,
    required List<dynamic> pictures,
    required VoidCallback onSuccess,
    }) async {
    isLoading.value = true;
    try {

      final body = {
        "pictures": pictures,
      };
      
      http.Response res = await baseService.httpPatch(endPoint: "users/me", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        
        //decode response from the server
        final TokenResponse jsonResponse = TokenResponse.fromJson(jsonDecode(res.body));

        LocalStorage.saveToken(jsonResponse.accessToken);
        LocalStorage.saveXrefreshToken(jsonResponse.refreshToken);

        log("$jsonResponse");
        onSuccess();

      }
      else{
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        baseService.showErrorMessage(
          httpStatusCode: res.statusCode,
          context: context
        );
        throw Exception("failed to update display pictures");
      }

    }

    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  
  }

  //CREATE PROPERTY FOR CURRENT USER (HOST)
  Future<void> createPropertyEndpoint({
    required BuildContext context,
    required String buildingType,
    required int rooms,
    required int floors,
    required int size,
    required int rent,


    required Map<String, dynamic> location,
    required List<dynamic> facilitiesList,
    required List<dynamic> propertyPicList,
    required VoidCallback onSuccess,
    }) async {
    isLoadingAdd.value = true;
    try {

      final body = {
        "building": buildingType,
        "rooms": rooms,
        "floors": floors,
        "size": size,
        "rent": rent,
        "location": location,  //map object as usual

        "facilities": facilitiesList, //List
        "pictures": propertyPicList,  //List
      };
      
      http.Response res = await baseService.httpPost(endPoint: "properties", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoadingAdd.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        
        //decode response from the server
        /*final TokenResponse jsonResponse = TokenResponse.fromJson(jsonDecode(res.body));

        LocalStorage.saveToken(jsonResponse.accessToken);
        LocalStorage.saveXrefreshToken(jsonResponse.refreshToken);*/

        //log("$jsonResponse");
        onSuccess();

      }
      else{
        isLoadingAdd.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        baseService.showErrorMessage(
          httpStatusCode: res.statusCode,
          context: context
        );
        throw Exception("failed to create property");
      }

    }


    catch(e, stackTrace) {
      isLoadingAdd.value  = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }


  //CREATE PROPERTY FOR CURRENT USER (HOST)
  Future<void> updatePropertyEndpoint({
    required BuildContext context,
    required String buildingType,
    required int rooms,
    required int floors,
    required int size,
    required int rent,

    required Map<String, dynamic> location,
    required List<dynamic> facilitiesList,
    required List<dynamic> propertyPicList,
    required VoidCallback onSuccess,
    }) async {

    isLoadingAdd.value  = true;
    try {

      final body = {
        "building": buildingType,
        "rooms": rooms,
        "floors": floors,
        "size": size,
        "rent": rent,
        "location": location,  //map object as usual

        "facilities": facilitiesList, //List
        "pictures": propertyPicList,  //List
      };
      
      http.Response res = await baseService.httpPatch(endPoint: "properties", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoadingAdd.value  = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        
        //decode response from the server
        /*final TokenResponse jsonResponse = TokenResponse.fromJson(jsonDecode(res.body));

        LocalStorage.saveToken(jsonResponse.accessToken);
        LocalStorage.saveXrefreshToken(jsonResponse.refreshToken);

        log("$jsonResponse");*/
        onSuccess();

      }
      else{
        isLoadingAdd.value  = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        baseService.showErrorMessage(
          httpStatusCode: res.statusCode,
          context: context
        );
        throw Exception("failed to update property");
      }

    }


    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }


  //VIEW OR FETCH PROPERTY INSIDE HOST PROFILE
  Future<PropertyModel> getPropertiesByIdEndpoint({required BuildContext context, required String id}) async {
    isLoading.value = true;
    try {

      http.Response res = await baseService.httpGet(endPoint: "properties/$id",);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        
        //decode response from the server
        PropertyModel jsonResponse = PropertyModel.fromJson(json.decode(res.body));

        return jsonResponse;

      }
      else{
        isLoading.value = false;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        baseService.showErrorMessage(
          httpStatusCode: res.statusCode,
          context: context
        );
        throw Exception("failed to fetch properties by location");
      }

    }

    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  
  }



}