import 'dart:convert';
import 'dart:developer';
import 'package:dweller/model/bookmark/bookmark_response.dart';
import 'package:dweller/model/match/match_response.dart';
import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/services/controller/main_page/mainpage_controller.dart';
import 'package:dweller/services/repository/data_service/base_service/base_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';









class MatchService extends getx.GetxController {
  

  final baseService = getx.Get.put(BaseService());
  final mainPageController = Get.put(MainPageController());
  final isLoading = false.obs;  

  

  //FETCH CURRENT USER Match List(Your Swipe Request)
  Future<List<MatchResponse>> getYourSwipes() async {
    isLoading.value = true;
    try {

      http.Response res = await baseService.httpGet(endPoint: "matches?request=sent",);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //decode response from the server
        final List<dynamic> result = json.decode(res.body);
        
        List<MatchResponse> jsonResponse = result.map((e) => MatchResponse.fromJson(e)).toList();

        return jsonResponse;

      }
      else{
        isLoading.value = false;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        throw Exception("failed to fetch your swipes");
      }

    }


    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  
  }

  //FETCH CURRENT USER Match List(Swipes on You)
  Future<List<MatchResponse>> getSwipesOnYou() async {
    isLoading.value = true;
    try {

      http.Response res = await baseService.httpGet(endPoint: "matches?request=received",);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //decode response from the server
        final List<dynamic> result = json.decode(res.body);
        
        List<MatchResponse> jsonResponse = result.map((e) => MatchResponse.fromJson(e)).toList();

        return jsonResponse;

      }
      else{
        isLoading.value = false;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        throw Exception("failed to fetch swipes on you");
      }

    }


    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  
  }


  //Accept MATCH REQUEST OF A DWELLER
  Future<void> acceptMatchRequest({
    required BuildContext context,
    required String id,
    required VoidCallback onSuccess,
    }) async {
    isLoading.value = true;
    try {

      final body = {
        "status":"accepted"
      };

      http.Response res = await baseService.httpPatch(endPoint: "matches/$id", body: body);

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
        throw Exception("failed to accept match request");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }


  //DECLINE MATCH REQUEST OF A DWELLER
  Future<void> declineMatchRequest({
    required BuildContext context,
    required String id,
    required VoidCallback onSuccess,
    }) async {
    isLoading.value = true;
    try {

      final body = {
        "status":"declined"
      };

      http.Response res = await baseService.httpPatch(endPoint: "matches/$id", body: body);

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
        throw Exception("failed to decline match request");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }

  //DELETE MATCH REQUEST OF A DWELLER
  Future<void> deleteMatchRequest({
    required BuildContext context,
    required String id,
    required VoidCallback onSuccess,
    }) async {
    isLoading.value = true;
    try {

      http.Response res = await baseService.httpDelete(endPoint: "matches/$id",);

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
        baseService.showErrorMessage(
          httpStatusCode: res.statusCode,
          context: context
        );
        throw Exception("failed to delete match request");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }


  //SEND MATCH REQUEST TO A DWELLER
  Future<void> sendMatchRequest({
    required BuildContext context,
    required String userId,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
    required String direction
    }) async {
    isLoading.value = true;
    try {

      final body = {
        "to": userId,
        "direstion": direction,
      };

      http.Response res = await baseService.httpPost(endPoint: "matches", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //decode response from the server
        ///final TokenResponse jsonResponse = TokenResponse.fromJson(jsonDecode(res.body));

        //log("$jsonResponse");
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
        throw Exception("failed to send match request");
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