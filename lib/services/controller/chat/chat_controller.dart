import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;






class ChatPageController extends getx.GetxController {

  //for the message textfield on the chat page
  final TextEditingController messageTextController = TextEditingController();
  final getx.RxBool isIconTapped = false.obs;

  //for adding todo/tasks
  final TextEditingController taskNameTextController = TextEditingController();
  final TextEditingController taskDescriptionTextController = TextEditingController();
  final getx.RxString dueDate = ''.obs;
  final getx.RxString dueTime = ''.obs;
  final getx.RxString assignTask = ''.obs;

  //for edit todo/tasks
  final TextEditingController taskNameTextControllerEdit = TextEditingController();
  final TextEditingController taskDescriptionTextControllerEdit = TextEditingController();
  final getx.RxString dueDateEdit = ''.obs;
  final getx.RxString dueTimeEdit = ''.obs;
  final getx.RxString assignTaskEdit = ''.obs;


  @override
  void dispose() {
    messageTextController.dispose();
    
    taskNameTextController.dispose();
    taskDescriptionTextController.dispose();
    taskNameTextControllerEdit.dispose();
    taskDescriptionTextControllerEdit.dispose();
    super.dispose();
  }

}