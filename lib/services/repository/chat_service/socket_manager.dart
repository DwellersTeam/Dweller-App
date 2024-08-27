// file: socket_manager.dart
import 'dart:developer';

import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketManager {
  
  static final SocketManager _instance = SocketManager._internal();


  late IO.Socket socket;
  
  final String refreshToken = LocalStorage.getXrefreshToken();
  final String accessToken = LocalStorage.getToken();
  final String myId = LocalStorage.getUserID();

  factory SocketManager() {
    return _instance;
  }

  SocketManager._internal() {
    _initSocket();
  }

  void _initSocket() {
    
    socket = IO.io(
      'https://dweller-node-api.onrender.com', 
      IO.OptionBuilder()
      .setTransports(["websocket"])
      .disableAutoConnect()
      .setExtraHeaders({
        "accessToken": accessToken,
        "refreshToken": refreshToken
      })
      .build()
    );

    log('Socket initialized, attempting to connect...');
    socket.connect();
    socket.onConnect((_) => log('Connected to socket server'));
    socket.onConnecting((_) => log('Connecting to server...'));
    socket.onConnectError((err) => log('Connection error: $err'));
    socket.onDisconnect((_) => log('Disconnected from server'));
    socket.onError((err) => log('Socket error: $err'));
  }

  void on(String event, Function(dynamic) callback) {
    socket.on(event, callback);
  }

  void emit(String event, dynamic data) {
    socket.emit(event, data);
  }

  void disconnect() {
    socket.dispose();
  }

  void reconnect() {
    socket.connect();
  }
}