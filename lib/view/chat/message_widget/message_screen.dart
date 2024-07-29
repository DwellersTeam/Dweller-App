import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/chat/message_widget/chat_menu.dart';
import 'package:dweller/view/chat/message_widget/mesage_textfield.dart';
import 'package:dweller/view/chat/message_widget/message_body.dart';
import 'package:dweller/view/chat/message_widget/message_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';






class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

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
              name: 'Pep Guardiola',
              menuBar: ChatMenu(),
              status: 'Online',
            ),
        
            //MESSAGELIST HERE(Wrap with container and then add the background image)
            const MessageBody(),
        
            //CUSTOM TEXTFIELD HERE
            MessageTextField(),
          ],
        ),
      ),
    );
  }
}