import 'dart:convert';
import 'dart:developer';

import 'package:dweller/model/chat/chatlist_model.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/view/chat/message_widget/message_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;






class ChatList extends StatefulWidget {
  const ChatList({super.key,});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {


  //
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  late IO.Socket socket;
  final List<ChatListResponse> _listofChats = [];
  final String accessToken = LocalStorage.getToken();
  final String refreshToken = LocalStorage.getXrefreshToken();

  @override
  void initState() {
    _refresh();
    connectToServer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //socket.dispose();
  }



  void connectToServer() {

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
      .build()
    );
    
    //connect manually since autoConnect is set to false
    socket.connect();
    
    //check if connection is established
    socket.onConnect((_) {
      log('Connected to server $_');
    });
    
    //listening from backend
    socket.on('chats', (data) {
      log("chat list data: $data");
      if(data is String){
        data = jsonDecode(data);
      }
      final List<dynamic> chatList = data;
      final result = chatList.map((e) => ChatListResponse.fromJson(e)).toList();
      setState(() {
        _listofChats.addAll(result); 
      });
    });
    
    //listening to disconnections
    socket.onDisconnect((_) => print('Disconnected from server'));
    socket.onConnectError((_) => print("connection error: $_"));
    socket.onConnectTimeout((_) => print("connection timed out: $_"));
    socket.onError((_) => print("error: $_"));
  }

  

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator.adaptive(
        color: AppColor.whiteColor,
        backgroundColor: AppColor.darkPurpleColor,
        onRefresh: () => _refresh(),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: _listofChats.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          //separatorBuilder: (context, index) => SizedBox(height: 20.h),
          //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          itemBuilder: (context, index) {
            final data = _listofChats[index];

            return InkWell(
              onTap: () {
                Get.to(() => MessageScreen(
                  receipientId: data.userId,
                  receipientName: data.name,
                  receipientPicture: data.picture,
                  online: data.online,
                ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    data.picture.isEmpty ?
                    CircleAvatar(
                      radius: 27.r, //24.r,
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      child: Text(
                        getFirstLetter(data.name),
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                    :CircleAvatar(
                      radius: 27.r, //24.r,
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      backgroundImage: NetworkImage(data.picture),
                      
                    ),
                    SizedBox(width: 20.w,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //1
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    data.name,
                                    style: GoogleFonts.bricolageGrotesque(
                                      color: AppColor.blackColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(width: 10.w,),
                                  Icon(
                                    color: AppColor.blueColor,
                                    size: 15.r,
                                    CupertinoIcons.checkmark_seal_fill
                                  )
                                ],
                              ),

                              //blue notification icon
                              Icon(
                                color: AppColor.deepBlueColor,
                                size: 15.r,
                                CupertinoIcons.circle_fill
                              )
                              
                            ],
                          ),

                          SizedBox(height: 10.h,),

                          InkWell(
                            child: Text(
                              data.lastMessage,
                              //"Hello 👋, i noticed you stay in NYC. you seem really cool and i'd love to know you",
                              style: GoogleFonts.poppins(
                                color: AppColor.chatGreyColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
                      
          }
        ),
      ),
    );
  }
}
