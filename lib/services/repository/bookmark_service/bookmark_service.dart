import 'dart:convert';
import 'dart:developer';
import 'package:dweller/model/bookmark/bookmark_response.dart';
import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/services/controller/main_page/mainpage_controller.dart';
import 'package:dweller/services/repository/data_service/base_service/base_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';









class BookmarkService extends getx.GetxController {
  

  final baseService = getx.Get.put(BaseService());
  final mainPageController = Get.put(MainPageController());
  final isLoading = false.obs;  

  

  //FETCH CURRENT USER BOOKMARK LISTS
  Future<List<BookmarkResponse>> getBookmarks() async {
    isLoading.value = true;
    try {

      http.Response res = await baseService.httpGet(endPoint: "bookmarks",);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //decode response from the server
        final List<dynamic> result = json.decode(res.body);
        
        List<BookmarkResponse> jsonResponse = result.map((e) => BookmarkResponse.fromJson(e)).toList();

        return jsonResponse;

      }
      else{
        isLoading.value = false;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        throw Exception("failed to fetch your bookmarks");
      }

    }


    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  
  }


  //DELETE CURRENT USER BOOKMARK
  Future<void> deleteBookmark({
    required BuildContext context,
    required String id,
    required VoidCallback onSuccess,
    }) async {
    isLoading.value = true;
    try {

      http.Response res = await baseService.httpDelete(endPoint: "bookmarks/$id",);

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
        throw Exception("failed to delete bookmark");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }


  //CREATE BOOKMARK
  Future<void> createBookmark({
    required BuildContext context,
    required String userId,
    required VoidCallback onSuccess,
    }) async {
    isLoading.value = true;
    try {

      final body = {
        "profile": userId
      };

      http.Response res = await baseService.httpPost(endPoint: "bookmarks", body: body);

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
        throw Exception("failed to create bookmark");
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