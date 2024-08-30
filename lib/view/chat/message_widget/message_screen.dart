import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dweller/model/chat/messages_model.dart';
import 'package:dweller/services/controller/chat/chat_controller.dart';
import 'package:dweller/services/repository/chat_service/socket_service.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/services/repository/notification_service/push_notifications.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/view/chat/message_widget/chat_menu.dart';
import 'package:dweller/view/chat/message_widget/mesage_textfield.dart';
import 'package:dweller/view/chat/message_widget/message_body.dart';
import 'package:dweller/view/chat/message_widget/message_header.dart';
import 'package:dweller/view/home/widget/profiel_by_id/get_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;







class MessageScreen extends StatefulWidget {
  MessageScreen({super.key, required this.receipientId, required this.receipientName, required this.receipientPicture, required this.online, required this.receipientFCMToken, required this.onRefresh});
  final String receipientId;
  final String receipientName;
  final String receipientPicture;
  final String receipientFCMToken;
  final VoidCallback onRefresh;
  bool online;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  

  //DEPENDENCY INJECTION
  final SocketService socketService = Get.find<SocketService>();

  final List<MessageResponse> _messages = [];

  late StreamController<List<MessageResponse>> _messagesStreamController;
  
  
  final controller = Get.put(ChatPageController());
  final notificationService = Get.put(PushNotificationController());
  final String myName = LocalStorage.getUsername();
  final String myId = LocalStorage.getUserID();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //initialize the stream controller
    _messagesStreamController = StreamController<List<MessageResponse>>.broadcast();
    
    //call this function to open the socket
    initiateMessages();

    //show pop up dialog if it your chat buddy blocked you
    if(controller.isBlocked.value == true && controller.theBlockedUser.value == myId) {
      showMessagePopup(
        title: "You have been blocked by ${getFirstName(fullName: widget.receipientName)}", 
        message: "you can no longer send messages to him/her", 
        buttonText: "Okay"
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!socketService.socket.connected) {
      log('Global Socket disconnected, reconnecting...');
      socketService.reconnect();
    } else {
      log('Global Socket is still connected');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }



  void initiateMessages() {

    //emit first
    socketService.emit('past-messages', {"id": widget.receipientId});
    //listening from backend for direct receipient
    socketService.on('past-messages-${widget.receipientId}', (data) {
      log("past-messages $data");
      if (data is String) {
        data = jsonDecode(data);
      }
      final List<Map<String, dynamic>> messageList = List<Map<String, dynamic>>.from(data);
      final result = messageList.map((e) => MessageResponse.fromJson(e)).toList();
      //setState(() {
        _messages
        ..clear()
        ..addAll(result);
      //});
      _messagesStreamController.add(result);
    });

    socketService.on('direct-message', (data) {
      log("direct message $data");
      if (data is String) {
        data = jsonDecode(data);
      }
      final Map<String, dynamic> messages = data;
      final result = MessageResponse.fromJson(messages);
      _messages.add(result);  //add json object subsequently
      _messagesStreamController.add(_messages);
    });

    socketService.on('blocked', (data) {
      log("blocked data: $data");
      if (data is String) {
        data = jsonDecode(data);
      }
      final Map<String, dynamic> response = data;
      //{id: theUserId, blocked: true}
      log("$response");
      controller.isBlocked.value = data["blocked"] ?? false;
      controller.theBlockedUser.value = data["theUserId"] ?? "";
    });
  }

  void sendMessage({required TextEditingController messageController}) async{
    if(controller.notiCount.value == 3){
      controller.notiCount.value = 0;
    
      //send text messages
      if (messageController.text.isNotEmpty) {

        socketService.emit(
          'direct-message', 
          controller.imageUrlController.value.isEmpty ?
          {
            //'from': widget.userId,
            'to': widget.receipientId,
            'content': messageController.text,
          }
          :{
            //'from': widget.userId,
            'to': widget.receipientId,
            'content': messageController.text,
            'imageUrl': controller.imageUrlController.value,
          }
        );

        //socketService.emit('chats', {});

        //send push notification
        await notificationService.sendNotification(
          targetUserToken: widget.receipientFCMToken, 
          title: myName, 
          body: controller.imageUrlController.value.isNotEmpty ? "📷 photo" : messageController.text, 
          type: "chat"
        );

        widget.onRefresh();
      
        //clear the clearables
        messageController.clear();
        controller.imageUrlController.value = "";
      }
      else{
        if(controller.imageUrlController.value.isEmpty) {
          log("do nothing");
        }
        else{
          socketService.emit(
            'direct-message', 
            {
              //'from': widget.userId,
              'to': widget.receipientId,
              'content': "",
              'imageUrl': controller.imageUrlController.value,
            }
          );

          //send push notification
          await notificationService.sendNotification(
            targetUserToken: widget.receipientFCMToken, 
            title: myName,  //widget.receipientName, 
            body: "📷 photo", 
            type: "chat"
          );

          widget.onRefresh();
          //clear the image url
          controller.imageUrlController.value = "";
        }
      }
    }
    else {
      //Increment the count
      controller.notiCount.value++;
      //send text messages
      if (messageController.text.isNotEmpty) {

        socketService.emit(
          'direct-message', 
          controller.imageUrlController.value.isEmpty ?
          {
            //'from': widget.userId,
            'to': widget.receipientId,
            'content': messageController.text,
          }
          :{
            //'from': widget.userId,
            'to': widget.receipientId,
            'content': messageController.text,
            'imageUrl': controller.imageUrlController.value,
          }
        );

        //socketService.emit('chats', {});

        widget.onRefresh();
      
        //clear the clearables
        messageController.clear();
        controller.imageUrlController.value = "";
      }
      else{
        if(controller.imageUrlController.value.isEmpty) {
          log("do nothing");
        }
        else{
          socketService.emit(
            'direct-message', 
            {
              //'from': widget.userId,
              'to': widget.receipientId,
              'content': "",
              'imageUrl': controller.imageUrlController.value,
            }
          );

          widget.onRefresh();
          //clear the image url
          controller.imageUrlController.value = "";
        }
      }
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
              menuBar: ChatMenu(
                onOpenProfile: () {
                  Get.to(() => GetUserByIdPage(userId: widget.receipientId,));
                },
                onClearChats: () {
                  _messagesStreamController.add([]);
                  socketService.emit('clear-chats', {"id": widget.receipientId});
                },
                isUserBlocked: controller.isBlocked.value,
                onBlockUser: () {
                  if(controller.isBlocked.value) {
                    socketService.emit('block-user', {"id": widget.receipientId});
                  }
                  else{
                    socketService.emit('unblock-user', {"id": widget.receipientId});
                  }
                },
              ),
              status: widget.online ? "Online" : "Offline",
            ),
        
            //MESSAGELIST HERE(Wrap with container and then add the background image)
            MessageBody(
              messagesStream: _messagesStreamController.stream,
              receipientName: widget.receipientName,
              receipientPicture: widget.receipientPicture,
            ),
        
            //CUSTOM TEXTFIELD HERE
            MessageTextField(
              receipientId: widget.receipientId,
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