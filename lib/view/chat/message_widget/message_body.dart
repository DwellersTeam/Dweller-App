import 'dart:developer';

import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/converters.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/chat/message_widget/chat_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../model/chat/messages_model.dart';






class MessageBody extends StatefulWidget {
  const MessageBody({super.key, required this.messagesStream, required this.receipientPicture, required this.receipientName});
  final Stream<List<MessageResponse>> messagesStream;
  final String receipientPicture;
  final String receipientName;

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {

  final ScrollController messageScrollController = ScrollController();
  final String userId = LocalStorage.getUserID();
  bool _isUserScrolling = false;

  @override
  void initState() {

    // Add a listener to track if the user is manually scrolling
    messageScrollController.addListener(() {
      if (messageScrollController.position.userScrollDirection != ScrollDirection.idle) {
        _isUserScrolling = true;
      }

      // If the user scrolls back to the bottom, reset the manual scroll flag
      if (messageScrollController.position.pixels >= messageScrollController.position.maxScrollExtent) {
        _isUserScrolling = false;
      }
    });

    widget.messagesStream.listen((messages) {
      // Auto-scroll only if the user is not manually scrolling
      if (!_isUserScrolling && messageScrollController.hasClients) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          messageScrollController.jumpTo(messageScrollController.position.maxScrollExtent);
        });
      }
    });
  
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    messageScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chat_bg.png'),
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover
          )
        ),
        child: StreamBuilder<List<MessageResponse>>(
          stream: widget.messagesStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoaderS();
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              log("snapshot has data?: ${snapshot.hasData}");
              return Center(
                child: Text(
                  'No messages yet',
                  style: GoogleFonts.poppins(
                    color: AppColor.darkPurpleColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500
                  )
                )
              );
            }
            if(snapshot.hasError) {
              log("snapshot err: ${snapshot.error}");
              return Center(
                child: Text(
                  'Something went wrong',
                  style: GoogleFonts.poppins(
                    color: AppColor.darkPurpleColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500
                  )
                )
              );
            }

            final messages = snapshot.data!;
            //for Auto-Scrolling just like WhatsApp
            SchedulerBinding.instance.addPostFrameCallback((_) {
              if (!_isUserScrolling && messageScrollController.hasClients) {
                messageScrollController.jumpTo(
                  messageScrollController.position.maxScrollExtent,
                );
              }
            });

            return ListView.separated(
              controller: messageScrollController,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: messages.length,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              separatorBuilder: (context, index) => SizedBox(height: 30.h),
              itemBuilder: (context, index) {
             
                final data = messages[index];

                // Check if the current message's date is different from the previous message's date
                bool showDateHeader = true;
                if (index > 0) {
                  var previousData = messages[index - 1];
                  var currentDate = transformDateString(data.createdAt);
                  var previousDate = transformDateString(previousData.createdAt);
                  showDateHeader = currentDate != previousDate;
                }
            
                return Dismissible(
                  key: UniqueKey(),
                  direction: data.to == userId ? DismissDirection.startToEnd : DismissDirection.endToStart,
                  onDismissed: (direction) {
                    //delete or reply message
                  },
                  child: Column(
                    crossAxisAlignment: data.from != userId  ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                    children: [
                      //date header here
                      // Show the date header if needed
                      if (showDateHeader)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 30.h, 
                            horizontal: 120.w
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            //height: 30.h,
                            //width: 150.w,
                            padding: EdgeInsets.symmetric(
                              vertical: 2.h, //20.h
                              horizontal: 5.w  //15.h
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.pureLightGreyColor,
                              borderRadius: BorderRadius.circular(10.r),
                              /*boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  //color: AppTheme().lightGreyColor,
                                  spreadRadius: 0.1.r,
                                  blurRadius: 8.0.r,
                                )
                              ],*/
                            ),
                            child: Text(
                              transformDateString(data.createdAt),
                              style: GoogleFonts.poppins(
                                color: AppColor.darkGreyColor,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),



                      data.from != userId 
                      ?ReceiverChatBox(
                        imageUrl: data.imageUrl,
                        content: data.content,
                        time: extractTimeIn12HourFormat(data.createdAt),
                        receipientName: widget.receipientName,
                        profilePicture: widget.receipientPicture,
                      ) 
                      :SenderChatBox(
                        imageUrl: data.imageUrl,
                        content: data.content,
                        time: extractTimeIn12HourFormat(data.createdAt),
                      ),
                    ],
                  )
                );
              }
            );
          }
        ),
      ),
    );
  }
}