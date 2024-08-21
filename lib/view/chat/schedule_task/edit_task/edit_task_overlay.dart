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
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';





void editTaskBottomsheet({
  required ChatPageController controller,
  required ChatService service,
  required String myId,
  required BuildContext context,
  required VoidCallback onRefresh,
  required String taskId,
  required String taskName,
  required String taskDescription,
  required String dueDate,
  required String dueTime,
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
                      await service.updateTask(
                        taskId: taskId,
                        taskName: controller.taskNameTextControllerEdit.text.isNotEmpty ? controller.taskNameTextControllerEdit.text : taskName, 
                        taskDescription: controller.taskDescriptionTextControllerEdit.text.isNotEmpty ? controller.taskDescriptionTextControllerEdit.text : taskDescription,
                        taskDueDate: controller.dueDateEdit.value.isNotEmpty ? controller.dueDateEdit.value : dueDate, 
                        taskDueTime: controller.dueTimeEdit.value.isNotEmpty ? controller.dueTimeEdit.value : dueTime,
                        onSuccess: () {
                          controller.taskNameTextControllerEdit.clear();
                          controller.taskDescriptionTextControllerEdit.clear();
                          controller.dueDateEdit.value = '';
                          controller.dueTimeEdit.value = '';
                          showMySnackBar(
                            context: context, 
                            message: "task updated successfully", 
                            backgroundColor: AppColor.greenColor
                          );
                          onRefresh();
                          Get.back();
                        },
                        onFailure: () {
                          controller.taskNameTextControllerEdit.clear();
                          controller.taskDescriptionTextControllerEdit.clear();
                          controller.dueDateEdit.value = '';
                          controller.dueTimeEdit.value = '';
                          showMySnackBar(
                            context: context, 
                            message: "failed to update task", 
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
                        color: AppColor.darkPurpleColor,
                        borderRadius: BorderRadius.circular(30.r)
                      ),
                      child: Obx(
                        () {
                          return service.isLoading.value ? CircularProgressIndicator.adaptive(backgroundColor: AppColor.whiteColor,) : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Mark as done',
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
        
              TaskTextInputfieldEdit(
                onChanged: (val) {
                  controller.taskNameTextControllerEdit.text = val;
                },
                onFieldSubmitted: (val) {
                  controller.taskNameTextControllerEdit.text = val;
                },
                hintText: 'Task name',
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                initialValue: taskName,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              TaskTextInputfieldEdit(
                onChanged: (val) {
                  controller.taskDescriptionTextControllerEdit.text = val;
                },
                onFieldSubmitted: (val) {
                  controller.taskDescriptionTextControllerEdit.text = val;
                },
                hintText: 'Task description',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                initialValue: taskDescription,
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
                            selectedDate: controller.dueDateEdit
                          );
                        },
                        svgasset: 'assets/svg/due_date.svg',
                        text: controller.dueDateEdit.value.isNotEmpty ? controller.dueDateEdit.value : dueDate,
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
                            controller.dueTimeEdit
                          );
                        },
                        svgasset: 'assets/svg/due_time.svg',
                        text: controller.dueTimeEdit.value.isNotEmpty ? controller.dueTimeEdit.value : dueTime,
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