import 'dart:developer';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/services/controller/home/homepage_controller.dart';
import 'package:dweller/services/repository/bookmark_service/bookmark_service.dart';
import 'package:dweller/services/repository/home_service/home_service.dart';
import 'package:dweller/services/repository/match_service/match_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/home/widget/tab(h&s)/seek_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SeekerCard extends StatefulWidget {
  const SeekerCard({super.key});

  @override
  State<SeekerCard> createState() => _SeekerCardState();
}

class _SeekerCardState extends State<SeekerCard> {


  final HomePageController controller = Get.put(HomePageController());
  final HomeService service = Get.put(HomeService());
  final BookmarkService bookmarkService = Get.put(BookmarkService());
  final MatchService matchService = Get.put(MatchService());

  late Future<List<UserModel>> seekersFuture;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      controller.shakeCard();
    });
    seekersFuture = service.getSeekers(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.78,
      child: Obx(() {
        if (service.isLoading.value) {
          return const LoaderS();
        }

        if (service.seekersList.isEmpty) {
          return Center(
            child: Text(
              "No seekers found",
              style: GoogleFonts.poppins(
                color: AppColor.darkPurpleColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }

        if (service.hasError.value) {
          return Center(
            child: Text(
              "An error occurred",
              style: GoogleFonts.poppins(
                color: AppColor.darkPurpleColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }

        return AppinioSwiper(
          backgroundCardScale: 0.9,
          backgroundCardOffset: const Offset(-2, 0),
          maxAngle: 20,
          invertAngleOnBottomDrag: true,
          backgroundCardCount: 3,
          swipeOptions: const SwipeOptions.only(left: true, right: true),
          controller: controller.controller,
          onCardPositionChanged: (SwiperPosition position) {
            debugPrint(
              '${position.offset.toAxisDirection()},'
              '${position.offset}, '
              '${position.angle}'
            );
          },
          onSwipeEnd: (int previousIndex, int targetIndex, SwiperActivity activity) {
            if (previousIndex >= 0 && previousIndex < service.seekersList.length) {
              controller.swipeEnd(
                onSuccess: () async{
                  await matchService.sendMatchRequest(
                    context: context, 
                    userId: service.seekersList[previousIndex].id,
                    onSuccess: () {
                      //call the notifications API to send a push notification and create data in db of the person
                      print('match sent');
                    }
                  );
                },
                previousIndex: previousIndex,
                targetIndex: targetIndex,
                activity: activity,
                context: context,
                userModel: service.seekersList[previousIndex],
              );
            }
          },
          onEnd: controller.onEnd,
          cardCount: service.seekersList.length,
          cardBuilder: (BuildContext context, int index) {
        
            if (index < 0 || index >= service.seekersList.length) {
              return const SizedBox.shrink();
            }
        
            final item = service.seekersList[index];
        
            return InkWell(
              onTap: () {
                controller.nextImage(imageList: item.pictures);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: const ColorFilter.mode(AppColor.darkGreyColor, BlendMode.softLight),
                    image: NetworkImage(
                      item.pictures[controller.currentIndex.value],
                    ),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                  color: AppColor.darkPurpleColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Stack(
                  children: [
                    // Linear progress Indicator
                    Positioned(
                      top: 5.h,
                      left: 0.w,
                      right: 0.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              backgroundColor: AppColor.semiDarkGreyColor,
                              valueColor: const AlwaysStoppedAnimation<Color>(AppColor.whiteColor),
                              value: (controller.currentIndex.value + 1) / item.pictures.length,
                              minHeight: 1.5,
                              borderRadius: BorderRadius.circular(20.r),
                            )
                          ),
                          SizedBox(width: 30.w),
                          InkWell(
                            onTap: () async{
                              setState(() {
                                controller.isBookmarked.value = !controller.isBookmarked.value;
                              });
                              
                              if(controller.isBookmarked.value){
                                await bookmarkService.createBookmark(
                                  context: context, 
                                  userId: item.id, 
                                  onSuccess: () {
                                    //send a push notification
                                    log('bookmark successful');
                                  }
                                );
                              }
                            },
                            child: Icon(
                              controller.isBookmarked.value ? CupertinoIcons.bookmark_solid : CupertinoIcons.bookmark,
                              color: AppColor.whiteColor,
                              size: 24.r,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Seeker information
                    Positioned(
                      bottom: 20.h,
                      left: 0.w,
                      right: 0.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
        
                              //expanded
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${item.firstname} ${item.lastname}",
                                        style: GoogleFonts.poppins(
                                          color: AppColor.whiteColor,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Icon(
                                      CupertinoIcons.checkmark_seal_fill,
                                      color: AppColor.blueColor,
                                      size: 22.r,
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "${item.age}",
                                      style: GoogleFonts.poppins(
                                        color: AppColor.whiteColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
        
                              SizedBox(width: 15.w,),
        
                              //expanded
                              InkWell(
                                onTap: () {
                                  Get.to(() => SeekerTabPage(user: item));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                                  decoration: BoxDecoration(
                                    color: AppColor.blueColorOp,
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'More',
                                        style: GoogleFonts.poppins(
                                          color: AppColor.blackColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Icon(
                                        size: 15.r,
                                        color: AppColor.blackColor,
                                        CupertinoIcons.chevron_forward,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Text(
                            item.location.address,
                            style: GoogleFonts.poppins(
                              color: AppColor.whiteColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
