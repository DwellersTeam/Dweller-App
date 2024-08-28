import 'dart:async';
import 'dart:developer';
import 'package:dweller/services/repository/chat_service/socket_manager.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/view/chat/message_widget/message_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dweller/model/chat/chatlist_model.dart';
import 'package:dweller/services/controller/chat/chat_controller.dart';
import 'package:dweller/services/repository/chat_service/socket_service.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







class ChatListNew extends StatefulWidget {
  const ChatListNew({super.key});

  @override
  State<ChatListNew> createState() => _ChatListNewState();
}

class _ChatListNewState extends State<ChatListNew> {  //with WidgetsBindingObserver

  //final SocketService socketService = Get.put(SocketService());
  final SocketService socketService = Get.find<SocketService>();
  //final SocketManager socketService = SocketManager();
  
  final String myId = LocalStorage.getUserID();
  late StreamController<List<ChatListResponse>> chatStreamController;

  @override
  void initState() {
    super.initState();
    // Add observer for app lifecycle changes
    //WidgetsBinding.instance.addObserver(this);

    // Initialize the stream controller
    chatStreamController = StreamController<List<ChatListResponse>>.broadcast();

    // Emit an event to fetch chats when the screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      socketService.emit('chats', {}); //{"id": myId}
    });

    // Listen to 'chats' event from the socket
    socketService.socket.on('chats', (data) {
      log('data: $data');
      List<dynamic> chatData = data;
      List<ChatListResponse> chatList = chatData.map((item) => ChatListResponse.fromJson(item)).toList();
      chatStreamController.add(chatList);
    });
  }

  @override
  void dispose() {
    // Remove observer when the widget is disposed
    //WidgetsBinding.instance.removeObserver(this);

    // Disconnect the socket and close the stream when disposing the screen
    //socketService.disconnect();
    //chatStreamController.close();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!socketService.socket.connected) {
      log('Socket disconnected, reconnecting...');
      socketService.reconnect();
    } else {
      log('Socket is still connected');
    }
  }


  /*@override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        log("App resumed, reconnecting socket...");
        socketService.reconnect();
        break;
      case AppLifecycleState.paused:
        log("App paused, disconnecting socket...");
        socketService.disconnect();
        break;
      case AppLifecycleState.inactive:
        log("App inactive");
        socketService.disconnect();
        break;
      case AppLifecycleState.detached:
        log("App detached");
        socketService.disconnect();
        break;
      default:
        break;
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<ChatListResponse>>(
        stream: chatStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoaderS();
          }

          if (snapshot.hasError) {
            log("socket err: ${snapshot.error}");
            return Center(
              child: Text(
                'Something went wrong',
                style: GoogleFonts.poppins(
                  color: AppColor.darkPurpleColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No chats yet',
                style: GoogleFonts.poppins(
                  color: AppColor.darkPurpleColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          final chatList = snapshot.data!;

          return RefreshIndicator.adaptive(
            color: AppColor.whiteColor,
            backgroundColor: AppColor.darkPurpleColor,
            onRefresh: _handleRefresh,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: chatList.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final data = chatList[index];

                return InkWell(
                  onTap: () {
                    if (data.senderOfLastMessage != myId) {
                      socketService.emit('seen', {"id": data.senderOfLastMessage});
                    }

                    Get.to(() => MessageScreen(
                      onRefresh: _handleRefresh,
                      receipientFCMToken: data.fcmToken,
                      receipientId: data.userId,
                      receipientName: data.name,
                      receipientPicture: data.picture,
                      online: data.online,
                    ));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 27.r,
                          backgroundColor: data.picture.isEmpty ? Colors.grey.withOpacity(0.1) : null,
                          backgroundImage: data.picture.isNotEmpty ? NetworkImage(data.picture) : null,
                          child: data.picture.isEmpty
                              ? Text(
                                  getFirstLetter(data.name),
                                  style: GoogleFonts.poppins(
                                    color: AppColor.blackColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : null,
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        data.name,
                                        style: GoogleFonts.bricolageGrotesque(
                                          color: AppColor.blackColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Icon(
                                        CupertinoIcons.checkmark_seal_fill,
                                        color: AppColor.blueColor,
                                        size: 15.r,
                                      ),
                                    ],
                                  ),
                                  if (!data.seen)
                                    Icon(
                                      CupertinoIcons.circle_fill,
                                      color: AppColor.deepBlueColor,
                                      size: 15.r,
                                    ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                data.lastMessage.isNotEmpty ? data.lastMessage : "📷 photo",
                                style: GoogleFonts.poppins(
                                  color: AppColor.chatGreyColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleRefresh() async {
    log("Refreshing chat list...");
    // Implement your refresh logic here
  }
}
