import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;








class SocketService extends GetxController {  //GetxService


  late IO.Socket socket;
  
  final String refreshToken = LocalStorage.getXrefreshToken();
  final String accessToken = LocalStorage.getToken();
  final String myId = LocalStorage.getUserID();

  @override
  void onInit() {
    super.onInit();
    _initSocket();
  }

  // Initialize the socket connection
  void _initSocket() {
    socket = IO.io(
      //'https://dweller-node-api.onrender.com', 
      "https://dweller-api-61110ae7ceda.herokuapp.com",
      IO.OptionBuilder()
        .setTransports(["websocket"])
        .disableAutoConnect()
        .setExtraHeaders({
          "accessToken": accessToken,
          "refreshToken": refreshToken
        })
        .build(),
    );

    log('Socket initialized, attempting to connect...');
    socket.connect();
    
    // Set up event listeners
    socket.onConnect((_) => log('Connected to socket server'));
    socket.onConnecting((_) => log('Connecting to server...'));
    socket.onConnectError((err) => log('Connection error: $err'));
    socket.onDisconnect((_) => log('Disconnected from server'));
    socket.onError((err) => log('Socket error: $err'));
  }

  // Listen to an event
  void on(String event, Function(dynamic) callback) {
    socket.on(event, callback);
  }

  // Emit an event
  void emit(String event, dynamic data) {
    socket.emit(event, data);
  }

  // Disconnect socket connection
  void disconnect() {
    //socket.disconnect();
    socket.dispose();
  }

  // Reconnect socket connection
  void reconnect() {
    socket.connect();
  }

  @override
  void onClose() {
    disconnect();
    super.onClose();
  }
}




