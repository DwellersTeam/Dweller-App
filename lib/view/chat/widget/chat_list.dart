import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/chat/message_widget/message_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







class ChatList extends StatelessWidget {
  const ChatList({super.key});

  //
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator.adaptive(
        color: AppColor.whiteColor,
        backgroundColor: AppColor.darkPurpleColor,
        onRefresh: () => _refresh(),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 8,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          //separatorBuilder: (context, index) => SizedBox(height: 20.h),
          //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(() => MessageScreen());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 27.r, //24.r,
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      backgroundImage: const AssetImage("assets/images/lionel.jpg"),
                      /*child: Text(
                        'J',
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),*/
                    ),
                    SizedBox(width: 20.w,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //1
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pep Guardiola',
                                    style: GoogleFonts.bricolageGrotesque(
                                      color: AppColor.blackColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(width: 10.w,),
                                  Icon(
                                    color: AppColor.blueColor,
                                    size: 15.r,
                                    CupertinoIcons.checkmark_seal_fill
                                  )
                                ],
                              ),

                              //blue notification icon
                              Icon(
                                color: AppColor.deepBlueColor,
                                size: 15.r,
                                CupertinoIcons.circle_fill
                              )
                              
                            ],
                          ),

                          SizedBox(height: 10.h,),

                          InkWell(
                            child: Text(
                              "Hello 👋, i noticed you stay in NYC. you seem really cool and i'd love to know you",
                              style: GoogleFonts.poppins(
                                color: AppColor.chatGreyColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
                      
          }
        ),
      ),
    );
  }
}
