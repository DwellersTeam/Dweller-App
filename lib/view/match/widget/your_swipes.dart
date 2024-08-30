import 'dart:developer';
import 'package:dweller/model/match/match_response.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/services/repository/match_service/match_service.dart';
import 'package:dweller/services/repository/notification_service/notification_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/chat/message_widget/message_screen.dart';
import 'package:dweller/view/home/widget/profiel_by_id/get_profile_page.dart';
import 'package:dweller/view/match/widget/empty_state.dart';
import 'package:dweller/view/match/widget/popup_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class YourSwipes extends StatefulWidget {
  const YourSwipes({super.key});

  @override
  State<YourSwipes> createState() => _YourSwipesState();
}

class _YourSwipesState extends State<YourSwipes> {

  final matchService = Get.put(MatchService());
  final notiCreateService = Get.put(NotificationService());

  final String accessToken = LocalStorage.getToken();
  final String refreshToken = LocalStorage.getXrefreshToken();

  late Future<List<MatchResponse>> yourSwipesFuture;

  @override
  void initState() {
    yourSwipesFuture = _refresh();
    super.initState();
  }


  //REFRESH FUNCTIONALITY
  Future<List<MatchResponse>> _refresh() async{
    await Future.delayed(const Duration(seconds: 2));
    final yourSwipesFuture = await matchService.getYourSwipes();
    return yourSwipesFuture;
  }


  Future<void> _handleRefresh() async{
    setState(() {
      yourSwipesFuture = _refresh();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Banner widget
        /*Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: TipsBanner(
            onCancelForLife: () {}, 
            onClose: () {}, 
            text: '"These are the Dwellers you want to match with.\nSend requests and sit tight for acceptance updates."',
          )
        ),
        SizedBox(height: 10.h),*/ // Spacer between banner and list/

        // ListView widget
        Expanded(
          child: FutureBuilder<List<MatchResponse>>(
            future: yourSwipesFuture,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const LoaderS();
              }
              if(snapshot.hasError){
                log("snapshot err: ${snapshot.error}");
                return const MatchEmptyState(
                  title: "You haven't matched with anyone yet",
                  subtitle: 'You need to swipe right on someone for them to appear on your match list',
                );
              }
              if(!snapshot.hasData){
                log("snapshot has data?: ${snapshot.hasData}");
                return const MatchEmptyState(
                  title: "You haven't matched with anyone yet",
                  subtitle: 'You need to swipe right on someone for them to appear on your match list',
                );
              }
              
              final data = snapshot.data!;
              if(data.isEmpty){
                return const MatchEmptyState(
                  title: "You haven't matched with anyone yet",
                  subtitle: 'You need to swipe right on someone for them to appear on your match list',
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
                              item.to.displayPicture.isNotEmpty 
                              ?CircleAvatar(
                                radius: 24.r,
                                backgroundColor: Colors.grey.withOpacity(0.1),
                                backgroundImage: NetworkImage(item.to.displayPicture),
                              )
                              :CircleAvatar(
                                radius: 24.r,
                                backgroundColor: Colors.grey.withOpacity(0.1),
                                child: Text(
                                  getFirstLetter(item.to.firstname),
                                  style: GoogleFonts.poppins(
                                    color: AppColor.blackColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              /*InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.more_horiz_rounded,
                                  color: AppColor.darkPurpleColor,
                                  size: 24.r,
                                ),
                              ),*/

                              MatchListYourSwipesMenu(
                                status: item.status,
                                onChat: () {
                                  Get.to(()=> MessageScreen(
                                    onRefresh: () {},
                                    receipientFCMToken: item.to.fcmToken,
                                    receipientId: item.to.id,
                                    receipientName: "${item.to.firstname} ${item.to.lastname}",
                                    receipientPicture: item.to.displayPicture,
                                    online: item.to.online,
                                  ));
                                },
                                onOpenProfile: () {
                                  Get.to(() => GetUserByIdPage(userId: item.to.id,));
                                },
                                onUndoMatch: () async {
                                  await matchService.deleteMatchRequest(
                                    context: context, 
                                    id: item.id, 
                                    onSuccess: () => _handleRefresh(),
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
                                  '${item.to.firstname} ${item.to.lastname}',
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
                                '${item.to.age}',
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
                            item.to.location.address,
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
        ),
      ],
    );
  }
}
