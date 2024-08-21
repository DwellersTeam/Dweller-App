import 'package:dweller/services/controller/chat/chat_controller.dart';
import 'package:dweller/services/repository/chat_service/chat_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/date_picker.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/utils/components/time_picker.dart';
import 'package:dweller/view/chat/schedule_task/add_task/tap_card.dart';
import 'package:dweller/view/search/widget/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







void addTaskBottomsheet({
  required ChatPageController controller,
  required ChatService service,
  required String myId,
  required String receipientId,
  required VoidCallback onRefresh,
  required BuildContext context,
}) {
  Get.bottomSheet(
    isDismissible: true,
    backgroundColor: AppColor.whiteColorForSubSheet,
    Wrap(
      children: [
        Container(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: AppColor.whiteColorForSubSheet,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 7.h,
                width: 50.w,
                decoration: BoxDecoration(
                  color: AppColor.greyColor,
                  borderRadius: BorderRadius.circular(15.r)
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async{
                      await service.createTask(
                        receipientId: receipientId, 
                        creatorId: myId, 
                        taskName: controller.taskNameTextController.text, 
                        taskDescription:controller.taskDescriptionTextController.text,
                        taskDueDate: controller.dueDate.value, 
                        taskDueTime: controller.dueTime.value, 
                        onSuccess: () {
                          controller.taskNameTextController.clear();
                          controller.taskDescriptionTextController.clear();
                          controller.dueDate.value = '';
                          controller.dueTime.value = '';
                          showMySnackBar(
                            context: context, 
                            message: "task created successfully", 
                            backgroundColor: AppColor.greenColor
                          );
                          onRefresh();
                          Get.back();
                        },
                        onFailure: () {
                          controller.taskNameTextController.clear();
                          controller.taskDescriptionTextController.clear();
                          controller.dueDate.value = '';
                          controller.dueTime.value = '';
                          showMySnackBar(
                            context: context, 
                            message: "failed to create task", 
                            backgroundColor: AppColor.redColor
                          );
                          Get.back();
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      //height: 7.h,
                      //width: 100.w,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(55, 203, 237, 1),
                        borderRadius: BorderRadius.circular(30.r)
                      ),
                      child: Obx(
                        () {
                          return service.isLoading.value ? const CircularProgressIndicator.adaptive(backgroundColor: AppColor.whiteColor,) : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Add task',
                                style: GoogleFonts.poppins(
                                  color: AppColor.whiteColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              SizedBox(width: 5.w,),
                              Icon(
                                size: 24.r,
                                color: AppColor.whiteColor,
                                CupertinoIcons.check_mark
                                //Icons.check
                              ),
                            ],
                          );
                        }
                      ),
                    ),
                  ),
                ],
              ),
        
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        
              TaskTextInputfield(
                onChanged: (val) {
                  controller.taskNameTextController.text = val;
                }, 
                onFieldSubmitted: (val) {},
                hintText: 'Task name',
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                textController: controller.taskNameTextController,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              TaskTextInputfield(
                onChanged: (val) {
                  controller.taskDescriptionTextController.text = val;
                },
                onFieldSubmitted: (val) {},
                hintText: 'Task description',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textController: controller.taskDescriptionTextController,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () {
                      return TaskCard(
                        onTap: () {
                          selectDate(
                            context: context,
                            selectedDate: controller.dueDate
                          );
                        },
                        svgasset: 'assets/svg/due_date.svg',
                        text: controller.dueDate.value.isNotEmpty ? controller.dueDate.value :  'Due date',
                      );
                    }
                  ),
                  SizedBox(width: 10.w,),
                  Obx(
                    () {
                      return TaskCard(
                        onTap: () {
                          selectTime(
                            context,
                            controller.dueTime
                          );
                        },
                        svgasset: 'assets/svg/due_time.svg',
                        text: controller.dueTime.value.isNotEmpty ? controller.dueTime.value  : 'Due time',
                      );
                    }
                  ),
                  /*SizedBox(width: 10.w,),
                  TaskCard(
                    onTap: () {},
                    svgasset: 'assets/svg/assign.svg',
                    text: 'Assign',
                  ),*/
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        
        
            ],
          ),
        ),
      ],
    ),
  );
}