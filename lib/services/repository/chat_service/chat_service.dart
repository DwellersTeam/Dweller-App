import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dweller/model/chat/chatlist_model.dart';
import 'package:dweller/model/chat/tasks_response.dart';
import 'package:dweller/model/settings/credit_card_response.dart';
import 'package:dweller/services/controller/main_page/mainpage_controller.dart';
import 'package:dweller/services/repository/data_service/base_service/base_service.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;






class ChatService extends getx.GetxController {
  

  final baseService = getx.Get.put(BaseService());
  final mainPageController = Get.put(MainPageController());
  final isLoading = false.obs;  


  final String refreshToken = LocalStorage.getXrefreshToken();
  final String accessToken = LocalStorage.getToken();
  final StreamController<List<ChatListResponse>> chatsStreamController = StreamController<List<ChatListResponse>>.broadcast();

  //WEB SOCKET FOR CHAT LIST CONFIG
  late IO.Socket socket;
  bool _isConnected = false;

  Future<void> connect() async {
    // ... your existing socket creation logic ...
    //1
    socket = IO.io(
      'https://dweller-node-api.onrender.com', 
      IO.OptionBuilder()
      .setTransports(["websocket"])
      .disableAutoConnect()
      //.enableAutoConnect()
      .setExtraHeaders({
        //"foo": "bar",
        "accessToken": accessToken,
        "refreshToken": refreshToken
      })
      .build()
    );
    
    //connect manually since autoConnect is set to false
    socket.connect();
    _isConnected = true;
    socket.onConnect((_) => print('Connected to server'));
    // ... listen for events
    //listening from backend
    socket.on('chats', (data) {
      log("chat list data: $data");
      if(data is String){
        data = jsonDecode(data);
      }
      final List<dynamic> chatList = data;
      final result = chatList.map((e) => ChatListResponse.fromJson(e)).toList();
      //_listofChats.addAll(result); 
      chatsStreamController.add(result);
    });
    
    //listening to disconnections
    socket.onDisconnect((_) => print('Disconnected from server'));
    socket.onConnectError((_) => print("connection error: $_"));
    socket.onConnectTimeout((_) => print("connection timed out: $_"));
    socket.onError((_) => print("error: $_"));
  }

  void disconnect() {
    if (_isConnected) {
      socket.dispose();
      _isConnected = false;
    }
  }

  bool get isConnected => _isConnected;



  //SCHEDULE TASK APIS
  //1
  Future<void> createTask({
    // BuildContext context,
    required String receipientId,
    required String creatorId,
    required String taskName,
    required String taskDescription,
    required String taskDueDate,
    required String taskDueTime,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
    }) async {
    isLoading.value = true;
    try {

      final body = {
        "with": receipientId,
        "assigned": [
          "",
        ],
        "description": taskDescription,
        "name": taskName,
        "dueDate": taskDueDate,
        "dueTime": taskDueTime
      };

      http.Response res = await baseService.httpPost(endPoint: "tasks", body: body);

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
        throw Exception("failed to create task");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }

  //2
  Future<void> updateTask({
    //required BuildContext context,
    required String taskId,
    required String taskName,
    required String taskDescription,
    required String taskDueDate,
    required String taskDueTime,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
    }) async {
    isLoading.value = true;
    try {

      final body = {
        "name": taskName,
        "description": taskDescription,
        "dueDate": taskDueDate,
        "dueTime": taskDueTime
      };

      http.Response res = await baseService.httpPatch(endPoint: "tasks/$taskId", body: body);

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
        throw Exception("failed to update task");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }

  //3
  Future<void> deleteTask({
    required BuildContext context,
    required String taskId,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
    }) async {

    isLoading.value = true;

    try {

      http.Response res = await baseService.httpDelete(endPoint: "tasks/$taskId",);

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
        throw Exception("failed to delete task");
      }

    }
    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  }


  //4
  //FETCH CURRENT USER TASK WITH THE SIGNIFICANT OTHER
  Future<List<TaskResponse>> getTaskWithBuddy({required String receipientId}) async {
    isLoading.value = true;
    try {

      http.Response res = await baseService.httpGet(endPoint: "tasks/with/$receipientId",);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //decode response from the server
        final List<dynamic> taskList = json.decode(res.body);
        final List<TaskResponse> finalResult = taskList.map((e) => TaskResponse.fromJson(e)).toList();

        return finalResult;

      }
      else{
        isLoading.value = false;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        //.showErrorMessage(httpStatusCode: res.statusCode, context: context);
        throw Exception("failed to fetch task list with your chat buddy");
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