import 'dart:convert';
import 'dart:developer';
import 'package:dweller/model/settings/settings_response.dart';
import 'package:dweller/services/controller/main_page/mainpage_controller.dart';
import 'package:dweller/services/repository/data_service/base_service/base_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';







class SettingService extends getx.GetxController {
  

  final baseService = getx.Get.put(BaseService());
  final mainPageController = Get.put(MainPageController());
  final isLoading = false.obs;  

  

  //FETCH CURRENT USER ACCOUNT SETTINGS DATA
  Future<SettingsResponse> getUserSettings(BuildContext context) async {
    isLoading.value = true;
    try {

      http.Response res = await baseService.httpGet(endPoint: "settings",);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //decode response from the server
        //final dynamic result = json.decode(res.body);
        
        SettingsResponse jsonResponse = SettingsResponse.fromJson(json.decode(res.body));

        return jsonResponse;

      }
      else{
        isLoading.value = false;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        baseService.showErrorMessage(httpStatusCode: res.statusCode, context: context);
        throw Exception("failed to fetch your account settings");
      }

    }

    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }


  //UPDATE USER ADVANCED SEARCH (BOTH FOR Seeker)
  Future<void> advancedSeacrchForSeekers({
    required BuildContext context,
    required String address,
    required String placeId,
    required num longitude,
    required num latitude,
  
    required int minAge,
    required int maxAge,
    required int distance,
    required List<dynamic> facilities,
    required List<dynamic> interests,
    required List<dynamic> pets,
    required List<dynamic> genders,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
    }) async {
    isLoading.value = true;
    try {

      final body = {
        "propertiesFilter": {
          "location":{
            "address": address,
            "placeId": placeId,
            "longitude": longitude,
            "latitude":latitude,
          },
           "age": {
            "min": minAge,
            "max": maxAge
          },
          "distance": distance, //i do not know if this distance is long and latitude or what muyiwa has in mind
          "facilities": facilities,
          "interests": interests,
          "genders": genders,
          "pets": pets
        },
      };

      http.Response res = await baseService.httpPatch(endPoint: "settings", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        onSuccess();

      }
      else{
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        onFailure();
        /*baseService.showErrorMessage(
          httpStatusCode: res.statusCode,
          context: context
        );*/
        throw Exception("failed to update user advanced search for seekers (PATCH)");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }



  //UPDATE USER ADVANCED SEARCH (BOTH FOR HOST)
  Future<void> advancedSeacrch({
    required BuildContext context,
    required String address,
    required String placeId,
    required num longitude,
    required num latitude,
    required int minRoomSize,
    required int maxRoomSize,
    required int minRent,
    required int maxRent,
    required int minAge,
    required int maxAge,
    required int maximumNumberOfRooms,
    required int distance,
    required List<dynamic> facilities,
    required List<dynamic> interests,
    required List<dynamic> pets,
    required List<dynamic> genders,
    required VoidCallback onSuccess,
    required VoidCallback onFailure
    }) async {
    isLoading.value = true;
    try {

      final body = {
        "propertiesFilter": {
          "location":{
            "address": address,
            "placeId": placeId,
            "longitude": longitude,
            "latitude":latitude,
          },
          "roomSize": {
            "min": minRoomSize,
            "max": maxRoomSize
          },
          "price": {
            "min": minRent,
            "max": maxRent
          },
           "age": {
            "min": minAge,
            "max": maxAge
          },
          "distance": distance, //i do not know if this distance is long and latitude or what muyiwa has in mind
          "maxRooms": maximumNumberOfRooms,
          "facilities": facilities,
          "interests": interests,
          "genders": genders,
          "pets": pets
        },
      };

      /*final body = {
        "propertiesFilter": {
          "roomSize": {
            "min": 0,
            "max": 500
          },
          "price": {
            "min": 2000,
            "max": 2500
          },
           "age": {
            "min": 7,
            "max": 23
          },
          "distance": 5,
          "maxRooms": 5,
          "facilities": ["park"],
          "interests": [],
          "genders": [],
          "pets": []
        },

        "kyc": {
          "document": "",
          "url": ""
        },
        "pushNotification": true,
        "emailNotification": false,
        "showOnDweller": true,
        "showOnline": true,
      };*/

      http.Response res = await baseService.httpPatch(endPoint: "settings", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        onSuccess();

      }
      else{
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        /*baseService.showErrorMessage(
          httpStatusCode: res.statusCode,
          context: context
        );*/
        onFailure();
        throw Exception("failed to update user advanced search for hosts (PATCH)");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }


  //UPDATE USER ACCOUNT SETTINGS (KYC ONLY) 
  Future<void> updateKYC({
    required BuildContext context,
    required String kycDocUrl,
    required String kycDocType,
    required VoidCallback onSuccess,
    }) async {
    isLoading.value = true;
    try {

      final body = {
        "kyc": {
          "document": kycDocType,
          "url": kycDocUrl
        },
      };

      http.Response res = await baseService.httpPatch(endPoint: "settings", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
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
        throw Exception("failed to update user kyc settings (PATCH)");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }
  

  //UPDATE USER ACCOUNT SETTINGS (Show me online ONLY) 
  Future<void> updateShowMeOnline({
    required BuildContext context,
    required bool showOnline,
    required VoidCallback onSuccess,
    }) async {
    isLoading.value = true;
    try {

      final body = {
        "showOnline": showOnline,
      };

      http.Response res = await baseService.httpPatch(endPoint: "settings", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
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
        throw Exception("failed to update user show online settings (PATCH)");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }

  //UPDATE USER ACCOUNT SETTINGS (Show me on Dweller ONLY) 
  Future<void> updateShowMeOnDweller({
    required BuildContext context,
    required bool showOnDweller,
    required VoidCallback onSuccess,
    }) async {
    isLoading.value = true;
    try {

      final body = {
        "showOnDweller": showOnDweller,
      };

      http.Response res = await baseService.httpPatch(endPoint: "settings", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
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
        throw Exception("failed to update user show on dweller settings (PATCH)");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }

  //UPDATE USER ACCOUNT SETTINGS (EMAIL NOTIFICATION ONLY) 
  Future<void> updateEmailNotification({
    required BuildContext context,
    required bool emailNotification,
    required VoidCallback onSuccess,
    }) async {
    isLoading.value = true;
    try {

      final body = {
        "emailNotification": emailNotification,
      };

      http.Response res = await baseService.httpPatch(endPoint: "settings", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
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
        throw Exception("failed to update user email notification (PATCH)");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }

  //UPDATE USER ACCOUNT SETTINGS (PUSH NOTIFICATION ONLY) 
  Future<void> updatePushNotification({
    required BuildContext context,
    required bool pushNotification,
    required VoidCallback onSuccess,
    }) async {
    isLoading.value = true;
    try {

      final body = {
        "pushNotification": pushNotification,
      };

      http.Response res = await baseService.httpPatch(endPoint: "settings", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
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
        throw Exception("failed to update user push notification (PATCH)");
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