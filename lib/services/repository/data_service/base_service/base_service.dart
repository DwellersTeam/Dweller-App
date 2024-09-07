import 'dart:convert';
import 'dart:developer';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as diox;
import 'package:get/get.dart' as getX;








class BaseService extends getX.GetxController {


  Future<dynamic> showErrorMessage({required int httpStatusCode, required BuildContext context}) async {
    switch (httpStatusCode) {
      case 200:
        return 'Success!';
      case 201:
        return 'Success!';
      case 204:
        return 'Deleted Successfully!';
      case 400:
        return showMessagePopup(
          title: 'Oops!', 
          message: 'Something went wrong. Please try again.', 
          buttonText: 'Dismiss', 
        );
      case 401:
        return showMessagePopup(
          title: 'Session Expired', 
          message: 'Please log in again.', 
          buttonText: 'Dismiss', 
        );
      case 403:
        return showMessagePopup(
          title: 'Access Denied', 
          message: 'You do not have permission for this action.', 
          buttonText: 'Dismiss', 
        );
      case 404:
        return showMessagePopup(
          title: 'Not Found', 
          message: 'The requested resource could not be found.', 
          buttonText: 'Dismiss', 
        );
      case 500:
        return showMessagePopup(
          title: 'Server Error', 
          message: 'There was a problem on our end. Please try again later.', 
          buttonText: 'Dismiss', 
        );
      case 502:
        return showMessagePopup(
          title: 'Bad Gateway', 
          message: 'The server is having issues. Please try again later.', 
          buttonText: 'Dismiss', 
        );
      case 503:
        return showMessagePopup(
          title: 'Service Unavailable', 
          message: 'The service is temporarily unavailable. Please try again later.', 
          buttonText: 'Dismiss', 
        );
      case 504:
        return showMessagePopup(
          title: 'Timeout', 
          message: 'The server took too long to respond. Please try again later.', 
          buttonText: 'Dismiss', 
        );
      default:
        return showMessagePopup(
          title: 'Error', 
          message: 'An unexpected error occurred. Please try again.', 
          buttonText: 'Dismiss', 
        );
    }
  }


  


  //General Base URL
  String socketUrl = "ws://dweller-node-api.onrender.com/";
  String baseUrl = "https://dweller-node-api.onrender.com/api/v1/";
  

  ///HTTP SERVICES/// 
  //function that sends a GET request for Google Auth (on a soft)
  Future<http.Response> httpPostGoogle({required String endPoint, required dynamic body}) async {
    Uri url = Uri.parse("$baseUrl$endPoint");
    log('$url');

    final res = await http.post(
      url,
      body: jsonEncode(body),
      headers:
      {
        //"Accept": "*/*",
        "Content-Type": "application/json",
        //"Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
      } 
    );
    print(res.headers['content-type']);
    return res;
  
  }

  final dio = diox.Dio(
    diox.BaseOptions(
      responseType: diox.ResponseType.json,
    )
  );

  //function that sends a GET request for Google Auth (on a soft)
  Future<http.Response> httpPostAuth({required String endPoint, required dynamic body}) async {
    //var token = await LocalStorage.getToken();
    Uri url = Uri.parse("$baseUrl$endPoint");
    log('$url');
    final res = http.post(
      url,
      body: json.encode(body),
      headers:
      {
        //"Accept": "*/*",
        "Content-Type": "application/json",
        //"Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
      } 
    );
    return res;
  }


  //function that sends a PUT request  for resetting password (on a soft)
  Future<http.Response> httpPutAuth({required String endPoint, required dynamic body}) async {
    Uri url = Uri.parse("$baseUrl$endPoint");
    log('$url');
    final res = http.put(
      url,
      body: json.encode(body),
      headers:
      {
        //"Accept": "*/*",
        "Content-Type": "application/json",
        //"Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
      } 
    );
    return res;
  }

  //function that sends a PATCH request (on a soft)
  Future<http.Response> httpPatchAuth({required String endPoint, required dynamic body}) async {
    Uri url = Uri.parse("$baseUrl$endPoint");
    log('$url');
    final res = http.put(
      url,
      body: json.encode(body),
      headers:
      {
        //"Accept": "*/*",
        "Content-Type": "application/json",
        //"Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
      } 
    );
    return res;
  }

  




  ///X-refresh HEADERS///
  //function that sends a GET request (on a soft)
  Future<dynamic> httpGet({required String endPoint}) async {
    final token = await LocalStorage.getToken();
    final xtoken = await LocalStorage.getXrefreshToken();
    Uri url = Uri.parse("$baseUrl$endPoint");
    log('$url');
    final res = http.get(
      url,
      headers: token != null ? 
      {
        'Authorization': 'Bearer $token',
        //"Accept": "*/*",
        "Content-Type": "application/json",
        "Connection": "keep-alive",
        "x-refresh": xtoken
      } 
      : null
    );
    return res;
  }

  //function that sends a POST request (on a soft)
  Future<dynamic> httpPost({required String endPoint, required dynamic body}) async {
    final token = await LocalStorage.getToken();
    final xtoken = await LocalStorage.getXrefreshToken();
    Uri url = Uri.parse("$baseUrl$endPoint");
    log('$url');
    final res = http.post(
      url,
      body: jsonEncode(body),
      headers: token != null ? 
      {
        'Authorization': 'Bearer $token',
        //"Accept": "*/*",
        "Content-Type": "application/json",
        "Connection": "keep-alive",
        "x-refresh": xtoken
      } 
      : null
    );
    return res;
  }
  
  //function that sends a PUT request (on a soft)
  Future<http.Response> httpPut({required String endPoint, required dynamic body}) async {
    final token = await LocalStorage.getToken();
    final xtoken = await LocalStorage.getXrefreshToken();
    Uri url = Uri.parse("$baseUrl$endPoint");
    log('$url');
    final res = http.put(
      url,
      body: jsonEncode(body),
      headers: token != null ? 
      {
        'Authorization': 'Bearer $token',
        //"Accept": "*/*",
        "Content-Type": "application/json",
        //"Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        "x-refresh": xtoken
      } 
      : null,
    );
    return res;
  }

  //function that sends a PATCH request (on a soft)
  Future<http.Response> httpPatch({required String endPoint, required dynamic body}) async {
    final token = await LocalStorage.getToken();
    final xtoken = await LocalStorage.getXrefreshToken();
    Uri url = Uri.parse("$baseUrl$endPoint");
    log('$url');
    final res = http.patch(
      url,
      body: jsonEncode(body),
      headers: token != null ? 
      {
        'Authorization': 'Bearer $token',
        //"Accept": "*/*",
        "Content-Type": "application/json",
        //"Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        "x-refresh": xtoken
      } 
      : null,
    );
    return res;
  }

  
  //function that sends a DELETE request (on a soft)
  Future<http.Response> httpDeleteWithBody({required String endPoint, dynamic body}) async {
    final token = await LocalStorage.getToken();
    final xtoken = await LocalStorage.getXrefreshToken();
    final res = http.delete(
      Uri.parse("$baseUrl$endPoint"),
      body: jsonEncode(body),
      headers: token != null ? 
      {
        'Authorization': 'Bearer $token',
        //"Accept": "*/*",
        "Content-Type": "application/json",
        //"Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        "x-refresh": xtoken
      } 
      : null
    );
    return res;
  }

  //function that sends a DELETE request (on a soft)
  Future<http.Response> httpDelete({required String endPoint,}) async {
    final token = await LocalStorage.getToken();
    final xtoken = await LocalStorage.getXrefreshToken();
    final res = http.delete(
      Uri.parse("$baseUrl$endPoint"),
      //body: json.encode(body),
      headers: token != null ? 
      {
        'Authorization': 'Bearer $token',
        //"Accept": "*/*",
        "Content-Type": "application/json",
        //"Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        "x-refresh": xtoken
      } 
      : null
    );
    return res;
  }


}


