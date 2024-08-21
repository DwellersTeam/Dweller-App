import 'package:dweller/model/chat/tasks_response.dart';
import 'package:dweller/services/controller/chat/chat_controller.dart';
import 'package:dweller/services/repository/chat_service/chat_service.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/chat/schedule_task/add_task/add_task_overlay.dart';
import 'package:dweller/view/chat/schedule_task/task_body.dart';
import 'package:dweller/view/chat/schedule_task/task_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';






class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key, required this.receipientId});
  final String receipientId;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  final controller = Get.put(ChatPageController());
  final service = Get.put(ChatService());
  final String myId = LocalStorage.getUserID();

  late Future<List<TaskResponse>> taskFuture;

  @override
  void initState() {
    taskFuture = _refresh();
    super.initState();
  }


  //REFRESH FUNCTIONALITY
  Future<List<TaskResponse>> _refresh() async{
    await Future.delayed(const Duration(seconds: 2));
    final taskFuture = await service.getTaskWithBuddy(receipientId: widget.receipientId);
    return taskFuture;
  }


  Future<void> _handleRefresh() async{
    setState(() {
      taskFuture = _refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //CUSTOM HEADER HERE
            const TaskHeader(),
        
            //TASK LIST HERE(Wrap with container and then add the background image)
            TaskBody(
              service: service,
              myId: myId,
              taskFuture: taskFuture,
              onRefresh: () => _handleRefresh(),
            ),
        
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
            myId: myId,
            receipientId: widget.receipientId,
            context: context,
            controller: controller,
            service: service,
            onRefresh: () => _handleRefresh(),
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