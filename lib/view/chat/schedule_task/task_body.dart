import 'package:dweller/services/controller/chat/chat_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/chat/schedule_task/edit_task/delete_dialogue.dart';
import 'package:dweller/view/chat/schedule_task/edit_task/edit_task_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';








class TaskBody extends StatefulWidget {
  const TaskBody({super.key});

  @override
  State<TaskBody> createState() => _TaskBodyState();
}

class _TaskBodyState extends State<TaskBody> {

  final ChatPageController controller = Get.put(ChatPageController());

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
          itemCount: 2,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          separatorBuilder: (context, index) => SizedBox(height: 30.h),
          itemBuilder: (context, index) {
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
                        text: '22 June, 2024  ',
                        style: GoogleFonts.poppins(
                          color: AppColor.semiDarkGreyColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                      TextSpan(
                        text: '7:00 PM',
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
                              'Arrange Laundry',
                              style: GoogleFonts.poppins(
                                color: AppColor.blackColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500
                              )
                            ),
                            //SvgPicture.asset('assets/svg/check_done.svg'),
                            InkWell(
                              onTap: () {},
                              child: Icon(
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
                          controller: controller,
                          taskName: 'Arrange Laundry',
                          taskDescription: 'Bla Bla Bla description',
                          dueDate: '22 june, 2024',
                          dueTime: '7:00 PM'
                        );
                      },
                      child: SvgPicture.asset('assets/svg/edit_icon.svg'),
                    ),
                    
                    SizedBox(width: 20.w,),
                    
                    InkWell(
                      onTap: () {
                        deleteTaskDialog(
                          taskName: 'Arrange Laundry',
                          onCancel: () {},
                          onConfirm: () {},
                        );
                      },
                      child: SvgPicture.asset('assets/svg/delete_icon.svg'),
                    ),
                    
                  ],
                )
              ],
            );
          }
        ),
      ),
    );
  }
}