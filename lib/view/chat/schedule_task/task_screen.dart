import 'package:dweller/services/controller/chat/chat_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/chat/schedule_task/add_task/add_task_overlay.dart';
import 'package:dweller/view/chat/schedule_task/task_body.dart';
import 'package:dweller/view/chat/schedule_task/task_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';






class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  final controller = Get.put(ChatPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.whiteColor,
      body: const SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //CUSTOM HEADER HERE
            TaskHeader(),
        
            //TASK LIST HERE(Wrap with container and then add the background image)
            TaskBody(),
        
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add task',
        enableFeedback: true,
        elevation: 3,
        foregroundColor: AppColor.blueColor,
        backgroundColor: AppColor.blueColor,
        onPressed: () {
          addTaskBottomsheet(
            context: context,
            controller: controller
          );
        },
        shape: const CircleBorder(),
        child: Icon(
          size: 24.r,
          color: AppColor.whiteColor,
          CupertinoIcons.add
        ),
      )    ,
    );
  }
}