import 'dart:convert';
import 'dart:developer';
import 'package:dweller/model/settings/credit_card_response.dart';
import 'package:dweller/model/settings/settings_response.dart';
import 'package:dweller/services/controller/main_page/mainpage_controller.dart';
import 'package:dweller/services/repository/data_service/base_service/base_service.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;
//import 'package:get/get.dart';







class SettingService extends getx.GetxController {
  

  final baseService = getx.Get.put(BaseService());
  final mainPageController = getx.Get.put(MainPageController());
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

        /*if(res.headers['x-access-token']!.isNotEmpty || res.headers['x-access-token'] != null){
          log("x-access-token: ${res.headers['x-access-token']}");
          //save access token from header
          LocalStorage.saveToken(res.headers['x-access-token']!);
        }*/
        
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
  Future<void> advancedSearchForHost({
    required BuildContext context,
    required String address,
    required String placeId,
    required num longitude,
    required num latitude,
  
    required int minAge,
    required int maxAge,

    required int minRoomSize,
    required int maxRoomSize,
    required int minRent,
    required int maxRent,
    required int maximumNumberOfRooms,

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
          "roomSize": {
            "min": minRoomSize,
            "max": maxRoomSize
          },
          "price": {
            "min": minRent,
            "max": minRent
          },
          "maxRooms": maximumNumberOfRooms,
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

        /*if(res.headers['x-access-token']!.isNotEmpty || res.headers['x-access-token'] != null){
          log("x-access-token: ${res.headers['x-access-token']}");
          //save access token from header
          LocalStorage.saveToken(res.headers['x-access-token']!);
        }*/
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


  
  //UPDATE USER ADVANCED SEARCH (BOTH FOR HOST & SEEKER)

  Future<void> advancedSearchForSeeker({
    required BuildContext context,
    required String address,
    required String placeId,
    required num longitude,
    required num latitude,

    required int minAge,
    required int maxAge,

    required int distance,

    required List<dynamic> interests,
    required List<dynamic> pets,
    required List<dynamic> genders,
    required VoidCallback onSuccess,
    required VoidCallback onFailure
    }) async {
    isLoading.value = true;
    try {

      final body = {
        //userFilter
        "usersFilter": {
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
          "distance": distance, 
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
        /*if(res.headers['x-access-token']!.isNotEmpty || res.headers['x-access-token'] != null){
          log("x-access-token: ${res.headers['x-access-token']}");
          //save access token from header
          LocalStorage.saveToken(res.headers['x-access-token']!);
        }*/
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
        /*if(res.headers['x-access-token']!.isNotEmpty || res.headers['x-access-token'] != null){
          log("x-access-token: ${res.headers['x-access-token']}");
          //save access token from header
          LocalStorage.saveToken(res.headers['x-access-token']!);
        }*/
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
        /*if(res.headers['x-access-token']!.isNotEmpty || res.headers['x-access-token'] != null){
          log("x-access-token: ${res.headers['x-access-token']}");
          //save access token from header
          LocalStorage.saveToken(res.headers['x-access-token']!);
        }*/
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
        /*if(res.headers['x-access-token']!.isNotEmpty || res.headers['x-access-token'] != null){
          log("x-access-token: ${res.headers['x-access-token']}");
          //save access token from header
          LocalStorage.saveToken(res.headers['x-access-token']!);
        }*/
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
        /*if(res.headers['x-access-token']!.isNotEmpty || res.headers['x-access-token'] != null){
          log("x-access-token: ${res.headers['x-access-token']}");
          //save access token from header
          LocalStorage.saveToken(res.headers['x-access-token']!);
        }*/
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
        /*if(res.headers['x-access-token']!.isNotEmpty || res.headers['x-access-token'] != null){
          log("x-access-token: ${res.headers['x-access-token']}");
          //save access token from header
          LocalStorage.saveToken(res.headers['x-access-token']!);
        }*/
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

  

  

  ///SUBSCRIPTION APIS///////////////////////////////////
  //FETCH CURRENT USER ACCOUNT SUBSCRIPTION/CREDIT CARD DATA
  Future<CardResponse> getUserCard() async {
    isLoading.value = true;
    try {

      http.Response res = await baseService.httpGet(endPoint: "card",);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //decode response from the server
        //final dynamic result = json.decode(res.body);
        CardResponse jsonResponse = CardResponse.fromJson(json.decode(res.body));

        return jsonResponse;

      }
      else{
        isLoading.value = false;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        //.showErrorMessage(httpStatusCode: res.statusCode, context: context);
        throw Exception("failed to fetch your account credit card information");
      }

    }

    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }



  //Suscribe to pro dweller
  Future<void> subscribeToPro({
    required BuildContext context,
    required String cardholderName,
    required String cardNumber,
    required String carrdCVV,
    required String carrdExpiry,
    required String cardType,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
    }) async {

    isLoading.value = true;

    try {

      final body =  {
        "card": {
          "holderName": cardholderName,
          "number": cardNumber,
          "expiry": carrdExpiry,
          "cvc": carrdCVV
        }
      };

      http.Response res = await baseService.httpPost(endPoint: "subscription/subscribe", body: body);

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
        throw Exception("failed to update user to pro dweller subscription");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }


  //create credit card
  Future<void> createCreditCard({
    //required BuildContext context,
    required String cardNumber,
    required String carrdCVV,
    required String carrdExpiry,
    required String cardType,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
    }) async {

    isLoading.value = true;

    try {

      final body =  {
        "number": cardNumber,
        "expiry": carrdExpiry,
        "cvv": carrdCVV,
        "type": cardType
      };

      http.Response res = await baseService.httpPost(endPoint: "card", body: body);

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
        throw Exception("failed to create credit card");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }

  //update or edit existing credit card
  Future<void> updateCreditCard({
    required BuildContext context,
    required String cardNumber,
    required String cardholderName,
    required String carrdCVV,
    required String carrdExpiry,
    required String cardType,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
    }) async {

    isLoading.value = true;

    try {

      final body =  {
        "holderName": cardholderName,
        "number": cardNumber,
        "expiry": carrdExpiry,
        "cvc": carrdCVV,
        //"type": cardType
      };

      http.Response res = await baseService.httpPatch(endPoint: "card", body: body);

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
        throw Exception("failed to update/edit user credit card");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }



  //delete existing credit card of a user
  Future<void> deleteCreditCard({
    required BuildContext context,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
    }) async {

    isLoading.value = true;

    try {


      http.Response res = await baseService.httpDelete(endPoint: "card",);

      if (res.statusCode == 200 || res.statusCode == 204) {

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
        throw Exception("failed to delete user credit card");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }

  //deactivate existing credit card
  Future<void> deactivateCreditCard({
    required BuildContext context,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
    }) async {

    isLoading.value = true;

    try {

      final body =  {
        "active": false,
      };

      http.Response res = await baseService.httpPatch(endPoint: "card", body: body);

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
        throw Exception("failed to deactivate user credit card");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }


  //re-activate existing credit card
  Future<void> reactivateCreditCard({
    required BuildContext context,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
    }) async {

    isLoading.value = true;

    try {

      final body =  {
        "active": true,
      };

      http.Response res = await baseService.httpPatch(endPoint: "card", body: body);

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
        throw Exception("failed to re-activate user credit card");
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