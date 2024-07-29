import 'dart:developer';
import 'package:dweller/model/notification/notification_response.dart';
import 'package:dweller/services/repository/notification_service/notification_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/converters.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/auth/widgets/button/noti_button.dart';
import 'package:dweller/view/home/widget/notification/notification_emptystate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;




final notificationService = Get.put(NotificationService());


Future<void> notificationBottomsheet({
  required BuildContext context,

  }) async{
  //
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }
  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    useSafeArea: true,
    backgroundColor: AppColor.whiteColor,
    //barrierColor: Theme.of(context).colorScheme.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.r)
      )
    ),
    context: context, 
    builder: (context) {
      return Wrap(
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.75,
            //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Container(
                  alignment: Alignment.center,
                  height: 7.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: AppColor.greyColor,
                    borderRadius: BorderRadius.circular(15.r)
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Text(
                    'Notifications',
                    style: GoogleFonts.bricolageGrotesque(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                
                //SizedBox(height: 20.h),

                //EXPANDED LIST
                //NotificationEmptyState(),
                //wrap with Future builder
                Expanded(
                  child: RefreshIndicator.adaptive(
                    color: AppColor.whiteColor,
                    backgroundColor: AppColor.darkPurpleColor,
                    onRefresh: () => _refresh(),
                    child: FutureBuilder<List<NotificationResponse>>(
                      future: notificationService.getUserNotification(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return const LoaderS();
                        }
                        if(snapshot.hasError) {
                          log('snapshot err: ${snapshot.error}');
                          return const NotificationEmptyState();
                        }
                        if(!snapshot.hasData) {
                          log('snapshot has data?: ${snapshot.hasData}');
                          return const NotificationEmptyState();
                        }
                        final data = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final item = data[index];
                            return InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: index.isOdd ? AppColor.blueColorOp : AppColor.whiteColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 24.r, //24.r,
                                      backgroundColor: Colors.grey.withOpacity(0.1),
                                      //backgroundImage: const AssetImage("assets/images/lionel.jpg"),
                                      child: Text(
                                        getFirstLetter(item.title),
                                        style: GoogleFonts.poppins(
                                          color: AppColor.blackColor,
                                          fontSize: 13.sp, //16.sp,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15.w,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //1
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  item.title,
                                                  style: GoogleFonts.poppins(
                                                    color: AppColor.blackColor,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),
                                              SizedBox(width: 20.w,),
                                              //timeago
                                              Text(
                                                timeago.format(convertStringToDateTimeTimeAgo(item.timestamp)),
                                                //'2 hrs ago',
                                                style: GoogleFonts.poppins(
                                                  color: AppColor.semiDarkGreyColor,
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w500
                                                )
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h,),
                                          InkWell(
                                            child: Text(
                                              item.subtitle,
                                              style: GoogleFonts.poppins(
                                                color: AppColor.semiDarkGreyColor,
                                                fontSize: 8.sp,
                                                fontWeight: FontWeight.w400
                                              ),
                                              overflow: TextOverflow.clip,
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
                        );
                      }
                    ),
                  ),
                ),

                SizedBox(height: 30.h,),
                //CloseButton(),
                CloseNotiButton(
                  text: 'Close Notification',
                  width: 250.w,
                  onClosed: () {
                    Get.back();
                  },
                ),
                SizedBox(height: 40.h,),
              ],
            ),
          ),
        ],
      );
    }
  );
}

