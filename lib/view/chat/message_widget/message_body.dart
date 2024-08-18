import 'dart:developer';

import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/converters.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/chat/message_widget/chat_box.dart';
import 'package:flutter/cupertino.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    //it makes messages list automatically scroll up after a message has been sen
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      messageScrollController.jumpTo(messageScrollController.position.maxScrollExtent);
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
            return ListView.separated(
              controller: messageScrollController,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: messages.length,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              separatorBuilder: (context, index) => SizedBox(height: 30.h),
              itemBuilder: (context, index) {
            
                final data = messages[index];
            
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
                      data.from != userId 
                      ? ReceiverChatBox(
                        type: data.type,
                        content: data.content,
                        time: extractTimeIn12HourFormat(data.createdAt),
                        receipientName: widget.receipientName,
                        profilePicture: widget.receipientPicture,
                      ) 
                      : SenderChatBox(
                        type: data.type,
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