import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dweller/model/chat/chatlist_model.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;





class SocketService extends GetxService {

  IO.Socket? socket;
  final StreamController<List<ChatListResponse>> chatsStreamController = StreamController<List<ChatListResponse>>.broadcast();
  final String refreshToken = LocalStorage.getXrefreshToken();
  final String accessToken = LocalStorage.getToken();
  final String myId = LocalStorage.getUserID();
  final int maxReconnectAttempts = 10; // Maximum reconnection attempts
  final Duration reconnectDelay = Duration(seconds: 1); // Delay between reconnection attempts



  Future<void> connectToServer() async {

    if (socket != null) {
      log('Socket already initialized');
      return;
    }
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

    socket!.connect();

    socket!.onConnect((_) {
      log('Connected to server $_');
    });

    socket!.on('chats', (data) {
      log("Received chat data: $data");
      if (data is String) data = jsonDecode(data);
      final List<dynamic> chatList = data;
      final result = chatList.map((e) => ChatListResponse.fromJson(e)).toList();
      chatsStreamController.add(result);
    });

    socket!.onDisconnect((_) => log('Disconnected from server'));
    socket!.onConnectError((error) => log("Connection error: $error"));
    socket!.onError((error) => log("Socket error: $error"));
  }

  // Reconnect logic
  int _reconnectAttempts = 0;
  Future<void> attemptReconnect() async {
    if (_reconnectAttempts < maxReconnectAttempts) {
      _reconnectAttempts++;
      log('Reconnecting in ${reconnectDelay.inSeconds} seconds...');
      await Future.delayed(reconnectDelay);
      try {
        await connectToServer();
      } catch (e) {
        log('Reconnection failed: $e');
        attemptReconnect(); // Retry connection
      }
    } else {
      log('Max reconnection attempts reached. Giving up.');
    }
  }

  void disconnect() {
    socket?.disconnect();
  }

  @override
  void onInit() {
    super.onInit();
    connectToServer();
  }

  @override
  void onClose() {

    socket?.disconnect();
    socket?.dispose();
    chatsStreamController.close();
    super.onClose();
    super.onClose();
  }
}
