import 'dart:developer';
import 'package:dweller/model/listing/property_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'dart:convert';
import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/services/controller/main_page/mainpage_controller.dart';
import 'package:dweller/services/repository/data_service/base_service/base_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';









class HomeService extends getx.GetxController {
  

  final baseService = getx.Get.put(BaseService());
  final mainPageController = Get.put(MainPageController());
  final isLoading = false.obs;  
  final hasError = false.obs;  


  //FETCH  SEEKERS BY LOCATION
  final seekersList = <UserModel>[].obs;
  Future<List<UserModel>> getSeekers(BuildContext context) async {
    isLoading.value = true;
    try {

      http.Response res = await baseService.httpGet(endPoint: "users",);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body for seekers ==> ${res.body}');
        //decode response from the server
        final List<dynamic> result = json.decode(res.body);
        
        List<UserModel> jsonResponse = result.map((e) => UserModel.fromJson(e)).toList();
        seekersList
        ..clear()
        ..addAll(jsonResponse);
        return jsonResponse;

      }
      else{
        isLoading.value = false;
        hasError.value = true;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        baseService.showErrorMessage(httpStatusCode: res.statusCode, context: context);
        throw Exception("failed to fetch users by your location");
      }

    }


    catch(e, stackTrace) {
      isLoading.value = false;
      hasError.value = true;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  
  }

  //FETCH HOSTS BY LOCATION
  final propertyList = <PropertyHostModel>[].obs;
  Future<List<PropertyHostModel>> getHosts(BuildContext context) async {
    isLoading.value = true;
    try {

      http.Response res = await baseService.httpGet(endPoint: "properties",);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body for properties/hosts ==> ${res.body}');
        //decode response from the server
        final List<dynamic> result = json.decode(res.body);
        
        List<PropertyHostModel> jsonResponse = result.map((e) => PropertyHostModel.fromJson(e)).toList();
        propertyList
        ..clear()
        ..addAll(jsonResponse);
        return jsonResponse;

      }
      else{
        isLoading.value = false;
        hasError.value = true;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        baseService.showErrorMessage(httpStatusCode: res.statusCode, context: context);
        throw Exception("failed to fetch hosts by your location");
      }

    }

    catch(e, stackTrace) {
      isLoading.value = false;
      hasError.value = true;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  
  }


  Future<PropertyModel> getHostPropertyById({required BuildContext context, required String userId}) async {
    isLoading.value = true;
    try {

      http.Response res = await baseService.httpGet(endPoint: "properties/$userId",);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body for the users property ==> ${res.body}');
        
        //decode response from the server
        final dynamic result = json.decode(res.body);
        
        PropertyModel jsonResponse = PropertyModel.fromJson(result);
        return jsonResponse;

      }
      else{
        isLoading.value = false;
        hasError.value = true;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        baseService.showErrorMessage(httpStatusCode: res.statusCode, context: context);
        throw Exception("failed to fetch host property");
      }

    }

    catch(e, stackTrace) {
      isLoading.value = false;
      hasError.value = true;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  
  }




}
