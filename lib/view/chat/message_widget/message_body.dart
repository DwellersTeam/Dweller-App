import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/chat/message_widget/chat_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/scheduler.dart';






class MessageBody extends StatefulWidget {
  const MessageBody({super.key});

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {

  final ScrollController messageScrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    //it makes messages list automatically scroll up after a message has been sent
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
        child: ListView.separated(
          controller: messageScrollController,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          separatorBuilder: (context, index) => SizedBox(height: 30.h),
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              //direction: data['senderId'] == authController.userID ? DismissDirection.endToStart : DismissDirection.endToStart,
              //onDismissed: (direction) => chatServiceController.deleteDirectMessages(messageId: data['messageId'], receiverId: widget.receiverId),
              child: Column(
                //crossAxisAlignment: data['senderId'] == authController.userID ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                crossAxisAlignment: index.isEven ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  //date header here
                  index.isEven ? ReceiverChatBox() : SenderChatBox(),
                ],
              )
            );
          }
        ),
      ),
    );
  }
}