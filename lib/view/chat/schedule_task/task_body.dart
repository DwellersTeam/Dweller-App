import 'dart:developer';

import 'package:dweller/model/chat/tasks_response.dart';
import 'package:dweller/services/controller/chat/chat_controller.dart';
import 'package:dweller/services/repository/chat_service/chat_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/converters.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/view/chat/schedule_task/edit_task/delete_dialogue.dart';
import 'package:dweller/view/chat/schedule_task/edit_task/edit_task_overlay.dart';
import 'package:dweller/view/search/widget/filter_bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';








class TaskBody extends StatefulWidget {
  const TaskBody({super.key, required this.service, required this.myId, required this.onRefresh, required this.taskFuture});
  final Future<List<TaskResponse>> taskFuture;
  final VoidCallback onRefresh;
  final ChatService service;
  final String myId;

  @override
  State<TaskBody> createState() => _TaskBodyState();
}

class _TaskBodyState extends State<TaskBody> {

  final ChatPageController controller = Get.put(ChatPageController());
  final ScrollController messageScrollController = ScrollController();
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

    widget.taskFuture.whenComplete(() {
      // Auto-scroll only if the user is not manually scrolling
      if (!_isUserScrolling && messageScrollController.hasClients) {
        SchedulerBinding.instance.addPostFrameCallback((timestamp) {
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chat_bg.png'),
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover
          )
        ),
        child: FutureBuilder<List<TaskResponse>>(
          future: widget.taskFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoaderS();
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              log("snapshot has data?: ${snapshot.hasData}");
              return Center(
                child: Text(
                  'No tasks yet',
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

            final tasks = snapshot.data!;
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
              itemCount: tasks.length,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              separatorBuilder: (context, index) => SizedBox(height: 30.h),
              itemBuilder: (context, index) {
                final data = tasks[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Due  ',
                            style: GoogleFonts.poppins(
                              color: AppColor.blackColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600
                            )
                          ),
                          TextSpan(
                            text: '${data.taskDueDate}  ',
                            style: GoogleFonts.poppins(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500
                            )
                          ),
                          TextSpan(
                            text: data.taskDueTime,
                            style: GoogleFonts.poppins(
                              color: AppColor.semiDarkGreyColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500
                            )
                          ),
                        ]
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //blue container
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            //height: 50.h,
                            //width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                            decoration: BoxDecoration(
                              color: AppColor.blueColorOp,   //AppColor.blueColorOp, //Color.fromRGBO(231, 231, 236, 1)
                              borderRadius: BorderRadius.circular(15.r)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data.taskName,
                                  style: GoogleFonts.poppins(
                                    color: AppColor.blackColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500
                                  )
                                ),
                                //SvgPicture.asset('assets/svg/check_done.svg'),
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.check,
                                    //CupertinoIcons.check_mark,
                                    color: AppColor.blackColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
            
                        SizedBox(width: 20.w,),
            
                        InkWell(
                          onTap: () {
                            editTaskBottomsheet(
                              context: context,
                              onRefresh: widget.onRefresh,
                              controller: controller,
                              service: widget.service,
                              myId: widget.myId,
                              taskId: data.taskId,
                              taskName: data.taskName,
                              taskDescription: data.taskDescription,
                              dueDate: data.taskDueDate,
                              dueTime: data.taskDueTime
                            );
                          },
                          child: SvgPicture.asset('assets/svg/edit_icon.svg'),
                        ),
                        
                        SizedBox(width: 20.w,),
                        
                        InkWell(
                          onTap: () {
                            deleteTaskDialog(
                              taskName: data.taskName,
                              onCancel: () {
                                Get.back();
                              },
                              onConfirm: () async{
                                await widget.service.deleteTask(
                                  context: context, 
                                  taskId: data.taskId, 
                                  onSuccess: () {
                                    Get.back();
                                    showMySnackBar(
                                      context: context, 
                                      message: "task deleted successfully", 
                                      backgroundColor: AppColor.greenColor
                                    );
                                  }, 
                                  onFailure: () {
                                    Get.back();
                                    showMySnackBar(
                                      context: context, 
                                      message: "failed to delete task", 
                                      backgroundColor: AppColor.redColor
                                    );
                                  }
                                  
                                );
                              },
                            );
                          },
                          child: SvgPicture.asset('assets/svg/delete_icon.svg'),
                        ),
                        
                      ],
                    )
                  ],
                );
              }
            );
          }
        ),
      ),
    );
  }
}