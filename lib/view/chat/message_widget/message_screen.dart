import 'dart:convert';
import 'dart:developer';

import 'package:dweller/model/chat/messages_model.dart';
import 'package:dweller/services/controller/chat/chat_controller.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/chat/message_widget/chat_menu.dart';
import 'package:dweller/view/chat/message_widget/mesage_textfield.dart';
import 'package:dweller/view/chat/message_widget/message_body.dart';
import 'package:dweller/view/chat/message_widget/message_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;







class MessageScreen extends StatefulWidget {
  MessageScreen({super.key, required this.receipientId, required this.receipientName, required this.receipientPicture, required this.online});
  final String receipientId;
  final String receipientName;
  final String receipientPicture;
  bool online;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {


  //final TextEditingController _messageController = TextEditingController();


  late IO.Socket socket;
  final List<MessageResponse> _messages = [];
  final controller = Get.put(ChatPageController());
  final String accessToken = LocalStorage.getToken();
  final String refreshToken = LocalStorage.getXrefreshToken();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initiateMessages();
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  void initiateMessages() {

    //1
    socket = IO.io(
      'https://dweller-node-api.onrender.com', 
      IO.OptionBuilder()
      .setTransports(["websocket"])
      .disableAutoConnect()
      .setExtraHeaders({
        //"foo": "bar",
        "accessToken": accessToken,
        "refreshToken": refreshToken
      })
      .build(),
    );

    //connect manually since autoConnect is set to false
    socket.connect();
    
    //check if connection is established
    socket.onConnect((_) {
      log('Connected to server $_');
      //emit to the server
      socket.emit('past-messages', {"id": widget.receipientId});
    });
    


    //listening from backend for direct receipient
    socket.on('past-messages-${widget.receipientId}', (data) {
      log("past-messages $data");
      if (data is String) {
        data = jsonDecode(data);
      }
      final List<Map<String, dynamic>> messageList = List<Map<String, dynamic>>.from(data);
      final result = messageList.map((e) => MessageResponse.fromJson(e)).toList();
      setState(() {
        _messages
        ..clear()
        ..addAll(result);
      });
    });

    socket.on('direct-message', (data) {
      log("direct message $data");
      if (data is String) {
        data = jsonDecode(data);
      }
      final Map<String, dynamic> messages = data;
      final result = MessageResponse.fromJson(messages);
      setState(() {
        _messages.add(result);  //add json object subsequently
      });
    });
    
    //listening to disconnections
    socket.onDisconnect((_) => print('Disconnected from server'));
    socket.onConnectError((_) => print("connection error: $_"));
    socket.onConnectTimeout((_) => print("connection timed out: $_"));
    socket.onError((_) => print("error: $_"));
  }

  void sendMessage({required TextEditingController messageController}) {
    if (messageController.text.isNotEmpty) {
      socket.emit('direct-message', {
        //'from': widget.userId,
        'to': widget.receipientId,
        'content': messageController.text,
        //'type': "text",
      });
      /*setState(() {
        _messages.add('You: ${_messageController.text}');
      });*/
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //wrap with Container and put the background image there
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //CUSTOM HEADER HERE
            MessageHeader(
              name: widget.receipientName,
              menuBar: ChatMenu(),
              status: widget.online ? "Online" : "Offline",
            ),
        
            //MESSAGELIST HERE(Wrap with container and then add the background image)
            MessageBody(
              messagesList: _messages,
              receipientName: widget.receipientName,
              receipientPicture: widget.receipientPicture,
            ),
        
            //CUSTOM TEXTFIELD HERE
            MessageTextField(
              onSend: () {
                sendMessage(messageController: controller.messageTextController);
              },
            ),
          ],
        ),
      ),
    );
  }
}