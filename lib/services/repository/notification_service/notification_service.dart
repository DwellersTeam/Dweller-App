import 'dart:convert';
import 'dart:developer';
import 'package:dio/src/response.dart';
import 'package:dweller/model/auth/token_response.dart';
import 'package:dweller/model/notification/notification_response.dart';
import 'package:dweller/services/controller/main_page/mainpage_controller.dart';
import 'package:dweller/services/repository/data_service/base_service/base_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';









class NotificationService extends getx.GetxController {
  

  final baseService = getx.Get.put(BaseService());
  final mainPageController = Get.put(MainPageController());
  final isLoading = false.obs;  


  //FETCH CURRENT USER NOTIFICATION
  Future<List<NotificationResponse>> getUserNotification() async {
    isLoading.value = true;
    try {

      http.Response res = await baseService.httpGet(endPoint: "notifications",);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //decode response from the server
        final List<dynamic> result = json.decode(res.body);
        
        List<NotificationResponse> jsonResponse = result.map((e) => NotificationResponse.fromJson(e)).toList();

        return jsonResponse;

      }
      else{
        isLoading.value = false;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        throw Exception("failed to fetch current user notification");
      }

    }


    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  
  }


  //CREATE NOTIFICATION FOR CURRENT USER
  Future<void> createNotification({
    required String title,
    required String subtitle,
    required String type,
    required String userId,
    required VoidCallback onSuccess,
    }) async {
    isLoading.value = true;
    try {

      final body = {
        //"user": userId,
        "title": title,
        "subtitle": subtitle,
        "type": type, //internal,
      };

      final http.Response res = await baseService.httpPost(endPoint: "notifications", body: body);  //httpPostAuth

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        final dynamic result = json.decode(res.body);
        log("$result");
        
        onSuccess();

      }
      else{
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        throw Exception("failed to create notification in database");
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