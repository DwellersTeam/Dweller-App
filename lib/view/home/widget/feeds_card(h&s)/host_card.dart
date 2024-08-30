import 'dart:developer';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:dweller/model/listing/property_model.dart';
import 'package:dweller/services/controller/home/homepage_controller.dart';
import 'package:dweller/services/repository/bookmark_service/bookmark_service.dart';
import 'package:dweller/services/repository/home_service/home_service.dart';
import 'package:dweller/services/repository/match_service/match_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/home/widget/tab(h&s)/host_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class HostCard extends StatefulWidget {
  const HostCard({super.key, required this.isOnPro});
  final bool isOnPro;

  @override
  State<HostCard> createState() => _HostCardState();
}

class _HostCardState extends State<HostCard> {

  final HomePageController controller = Get.put(HomePageController());
  final HomeService service = Get.put(HomeService());
  final BookmarkService bookmarkService = Get.put(BookmarkService());
  final MatchService matchService = Get.put(MatchService());


  late Future<List<PropertyHostModel>> properties;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      controller.shakeCard();
    });
    properties = service.getHosts(context);
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

        if (service.propertyList.isEmpty) {
          return Center(
            child: Text(
              "No property/hosts found",
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
            if (targetIndex >= 0 && targetIndex < service.propertyList.length) {
              controller.swipeEnd(
                onSuccess: () async{
                  await matchService.sendMatchRequest(
                    context: context, 
                    userId: service.propertyList[previousIndex].propertyOwner.id,
                    onSuccess: () {
                      //call the notifications API to send a push notification and create data in db of the person
                      print('match sent');
                    },
                    onFailure: () {
                      Get.back();
                    },
                  );
                },
                previousIndex: previousIndex,
                targetIndex: targetIndex,
                activity: activity,
                context: context,
                userModel: service.propertyList[previousIndex].propertyOwner, //change back to previous index
              );
              //reset the picture index back to zero
              //controller.currentIndex.value = 0;
            }
          },
          
          onEnd: () => controller.onEnd(context: context, isUserPro: widget.isOnPro),
        

          cardCount: service.propertyList.length,
          cardBuilder: (BuildContext context, int index) {
            if (index < 0 || index >= service.propertyList.length) {
              return const SizedBox.shrink();
            }
        
            final item = service.propertyList[index];
            final propertyId = item.id; // String propertyId

            // Get the current image index, defaulting to 0 if not yet set
            var currentImageIndex = controller.imageIndex[propertyId] ?? 0;
        
            return InkWell(
              onTap: () {
                setState(() {
                  currentImageIndex = controller.imageIndex[propertyId] ?? 0;
                  controller.nextImageForHost(propertyList: service.propertyList, index:  index);
                });
              },
              child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: const ColorFilter.mode(AppColor.darkGreyColor, BlendMode.softLight),
                        image: NetworkImage(
                          item.propertyPics[currentImageIndex], //controller.imageIndex[index]
                        ),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                      color: AppColor.darkPurpleColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                backgroundColor: AppColor.semiDarkGreyColor,
                                valueColor: const AlwaysStoppedAnimation<Color>(AppColor.whiteColor),
                                value: (currentImageIndex + 1) / item.propertyPics.length,
                                minHeight: 1.5,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
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
                                    userId: item.propertyOwner.id, 
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
                        Positioned(
                          bottom: 7.h,
                          left: 0.w,
                          right: 0.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item.location.address}",
                                style: GoogleFonts.bricolageGrotesque(
                                  color: AppColor.whiteColor,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset('assets/svg/space_icon.svg'),
                                        SizedBox(width: 10.w),
                                        Text(
                                          item.rooms <= 1 ? '${item.rooms} room' : '${item.rooms} rooms',
                                          style: GoogleFonts.bricolageGrotesque(
                                            color: AppColor.whiteColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset('assets/svg/floor_icon.svg'),
                                        SizedBox(width: 10.w),
                                        Text(
                                          item.floors <= 1 ? '${item.floors} floor' : '${item.floors} floors',
                                          style: GoogleFonts.bricolageGrotesque(
                                            color: AppColor.whiteColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset('assets/svg/sqm_icon.svg'),
                                        SizedBox(width: 10.w),
                                        Text(
                                          '${item.size} sqm',
                                          style: GoogleFonts.bricolageGrotesque(
                                            color: AppColor.whiteColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
        
        
                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        
                              //here
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
        
                                  item.propertyOwner.displayPicture.isNotEmpty
                                  ?CircleAvatar(
                                    radius: 24.r,
                                    backgroundColor: Colors.grey.withOpacity(0.1),
                                    backgroundImage: NetworkImage(item.propertyOwner.displayPicture),
                                  )
                                  :CircleAvatar(
                                    radius: 24.r,
                                    backgroundColor: Colors.grey.withOpacity(0.1),
                                    child: Text(
                                      getFirstLetter(item.propertyOwner.firstname),
                                      style: GoogleFonts.poppins(
                                        color: AppColor.blackColor,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
        
                                  SizedBox(width: 10.w),
        
                                  //expanded
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${item.propertyOwner.firstname} ${item.propertyOwner.lastname}",
                                            style: GoogleFonts.poppins(
                                              color: AppColor.whiteColor,
                                              fontSize: 16.sp,
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
                                          "${item.propertyOwner.age}",
                                          style: GoogleFonts.poppins(
                                            color: AppColor.whiteColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
        
                                  SizedBox(width: 15.w,),
        
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => HostTabPage(
                                        property: item, 
                                      ));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                                      decoration: BoxDecoration(
                                        color: AppColor.blueColorOp,
                                        borderRadius: BorderRadius.circular(30.r),
                                      ),
                                      child: 
                                      Text(
                                        'More',
                                        style: GoogleFonts.poppins(
                                          color: AppColor.blackColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                            
                                      /*Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'More',
                                            style: GoogleFonts.poppins(
                                              color: AppColor.blackColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(width: 5.w),
                                          Icon(
                                          size: 15.r,
                                            color: AppColor.blackColor,
                                            CupertinoIcons.chevron_forward,
                                          ),
                                        ],
                                      ),*/
        
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              
              
            );
          },
        );
      }),
    );
  }
}
