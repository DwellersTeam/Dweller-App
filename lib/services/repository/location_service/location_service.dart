import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dweller/model/location/places.dart';
import 'package:dweller/services/controller/main_page/mainpage_controller.dart';
import 'package:dweller/services/repository/data_service/base_service/base_service.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;












class LocationService extends getx.GetxController {
  

  final baseService = getx.Get.put(BaseService());
  final mainPageController = Get.put(MainPageController());
  final FCMToken = LocalStorage.getFCMToken();
  final tokenExpDateInt = LocalStorage.getTokenExpDate() ?? 0;
  final userId = LocalStorage.getUserID();
  final isLoading = false.obs;  

  final longitudeValue = 0.0.obs;
  final latitudeValue = 0.0.obs;
  final placeId = ''.obs;


  //places list
  final suggestionsList = <Place>[].obs;


  //FETCH QUERIED LOCATION FROM GOOGLE PLACES API
  Future<List<Place>> fetchPlacesEndpoint({
    required BuildContext context,
    required String input,
    required String apiKey,
    required List<Place> suggestions,
    }) async {
    isLoading.value = true;
    try {

      //http.Response res = await baseService.httpGet(endPoint: "users/me",);
      final res = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey'),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');

        
        //decode response from the server
        final dynamic data = jsonDecode(res.body);
        /*Place jsonResponse = Place.fromJson(json.decode(res.body));
        return jsonResponse;*/
        List<dynamic> predictionList = data['predictions'];
        
        List<Place> result = predictionList.map((e) => Place.fromJson(e)).toList();

        suggestions
        ..clear()
        ..addAll(result);
        
        return result;
      }
      else{
        isLoading.value = false;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        baseService.showErrorMessage(context: context, httpStatusCode: res.statusCode);
        throw Exception("failed to fetch queried location");
      }
    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  
  }


  //FETCH A PLACE DETAILS QUERIED BY THE PLACEID FROM GOOGLE PLACES API
  Future<Map<String, dynamic>> getPlaceDetails({
    required String placeId,
    required String apiKey,
  }) async {

    final res = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey'
      ),
      );

    if (res.statusCode == 200 || res.statusCode == 201) {

      final data = json.decode(res.body);
      debugPrint('this is response status ==> ${res.statusCode}');
      debugPrint('this is response body (place details) ==> ${res.body}');

      if (data['status'] == 'OK') {

        return data['result']['geometry']['location'];
      } else {
        throw Exception('Failed to load place details');
      }
    } else {
      throw Exception('Failed to load place details');
    }
  }

  //EXTRACT LAT & LONG FROM GOOGLE PLACES API
  Future<void> fetchPlaceDetails({
    required BuildContext context,
    required String placeId,
    required String apiKey,
  }) async {
    try {
      final details = await getPlaceDetails(placeId: placeId, apiKey: apiKey);
      log('Place details: $details');
      longitudeValue.value = details['lng'];
      latitudeValue.value = details['lat'];

    } catch (e, stackTrace) {
      log('Failed to fetch place details: $e =>  $stackTrace');
    }
  }


  
}