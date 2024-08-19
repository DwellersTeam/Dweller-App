import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dweller/model/chat/chatlist_model.dart';
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

}