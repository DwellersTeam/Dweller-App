import 'dart:developer';

import 'package:dweller/model/bookmark/bookmark_response.dart';
import 'package:dweller/services/repository/bookmark_service/bookmark_service.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/services/repository/match_service/match_service.dart';
import 'package:dweller/services/repository/notification_service/notification_service.dart';
import 'package:dweller/services/repository/notification_service/push_notifications.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/bookmark/widget/empty_state.dart';
import 'package:dweller/view/bookmark/widget/popup_menu.dart';
import 'package:dweller/view/home/widget/profiel_by_id/get_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







class BookmarkList extends StatefulWidget {
  const BookmarkList({super.key});

  @override
  State<BookmarkList> createState() => _BookmarkListState();
}

class _BookmarkListState extends State<BookmarkList> {
  
  final bookService = Get.put(BookmarkService());
  final matchService = Get.put(MatchService());
  final notificationService = Get.put(PushNotificationController());
  final notiCreateService = Get.put(NotificationService());

  final String currentUsername = LocalStorage.getUsername();

  late Future<List<BookmarkResponse>> bookmarkFuture;

  @override
  void initState() {
    bookmarkFuture = _refresh();
    super.initState();
  }


  //REFRESH FUNCTIONALITY
  Future<List<BookmarkResponse>> _refresh() async{
    await Future.delayed(const Duration(seconds: 2));
    final bookmarkFuture = await bookService.getBookmarks();
    return bookmarkFuture;
  }


  Future<void> _handleRefresh() async{
    setState(() {
      bookmarkFuture = _refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<BookmarkResponse>>(
        future: bookmarkFuture,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const LoaderS();
          }
          if(snapshot.hasError){
            log("snapshot err: ${snapshot.error}");
            return BookmarkEmptyState(
              title: "You haven't bookmarked anyone yet",
              subtitle: "When you bookmark dwellers, they will show up here",
            );
          }
          if(!snapshot.hasData){
            log("snapshot has data?: ${snapshot.hasData}");
            return BookmarkEmptyState(
              title: "You haven't bookmarked anyone yet",
              subtitle: "When you bookmark dwellers, they will show up here",
            );
          }
          
          final data = snapshot.data!;
          if(data.isEmpty){
            return BookmarkEmptyState(
              title: "You haven't bookmarked anyone yet",
              subtitle: "When you bookmark dwellers, they will show up here",
            );
          }

          return RefreshIndicator.adaptive(
            color: AppColor.whiteColor,
            backgroundColor: AppColor.darkPurpleColor,
            onRefresh: () => _handleRefresh(),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => SizedBox(height: 20.h),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              itemBuilder: (context, index) {
                final item = data[index];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.blueColorLightest,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.lightGreyColor.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          item.profile.displayPicture.isNotEmpty 
                          ?CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            backgroundImage: NetworkImage(item.profile.displayPicture),
                          )
                          :CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            child: Text(
                              getFirstLetter(item.profile.firstname),
                              style: GoogleFonts.poppins(
                                color: AppColor.blackColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          BookmarkMenu(
                            onOpenProfile: () {
                              Get.to(() => GetUserByIdPage(userId: item.profile.id,));
                            },
                            onSendMatchRequest: () async{
                              await matchService.sendMatchRequest(
                                context: context, 
                                userId: item.profile.id, 
                                onSuccess: () {
                                  _handleRefresh();
                                  notificationService.sendNotification(
                                    type: 'match',
                                    targetUserToken: item.profile.fcmToken,
                                    title: 'Hey, ${item.profile.firstname}',
                                    body: 'you just got a match request from $currentUsername',
                                  );
                                  //create notification in the receiver db
                                }
                              );
                            },
                            onDeleteBookmark: () async{
                              _handleRefresh();
                              await bookService.deleteBookmark(
                                context: context, 
                                id: item.profile.id, 
                                onSuccess: () => _handleRefresh()
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              '${item.profile.firstname} ${item.profile.lastname}',
                              style: GoogleFonts.poppins(
                                color: AppColor.blackColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Icon(
                            CupertinoIcons.checkmark_seal_fill,
                            color: AppColor.blueColor,
                            size: 24.r,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            '${item.profile.age}',
                            style: GoogleFonts.poppins(
                              color: AppColor.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        item.profile.location.address,
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      ),
    );
  }
}
