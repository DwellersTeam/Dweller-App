import 'dart:developer';

import 'package:dweller/model/profile/jwt_response.dart';
import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/services/controller/bookmark/bookmark_controller.dart';
import 'package:dweller/services/repository/create_profile_service/create_profile_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/chat/widget/chat_list_new.dart';
import 'package:dweller/view/home/widget/notification/notification_sheet.dart';
import 'package:dweller/view/settings/page/profile_type/profile_settings_host.dart';
import 'package:dweller/view/settings/page/profile_type/profile_settings_seeker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;






class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final controller = Get.put(BookmarkPageController());
  final profileService = Get.put(CreateProfileService());
  
  late Future<JwtModel> profileFuture;
  

  @override
  void initState() {
    profileFuture = _refresh();
    super.initState();
  }


  //REFRESH FUNCTIONALITY
  Future<JwtModel> _refresh() async{
    await Future.delayed(const Duration(seconds: 2));
    final profileFuture = await profileService.fetchUserDetailFromJWT(context);
    return profileFuture;
  }


  Future<void> _handleRefresh() async{
    setState(() {
      profileFuture = _refresh();
    });
  }





  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        //wrap with profile GET request FutureBuilder
        child: CustomPaint(
          painter: TopRedSectionPainter(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h,),    
              //HEADER
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => notificationBottomsheet(context: context),    
                      child: SvgPicture.asset('assets/svg/noti_icon.svg')
                    ),

                    FutureBuilder<JwtModel>(
                      future: profileFuture,
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            //backgroundImage: const AssetImage("assets/images/lionel.jpg"),
                            //child: LoaderS()
                          );
                        }
                        if(snapshot.hasError){
                          log("snapshot err: ${snapshot.error}");
                          return CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            //backgroundImage: const AssetImage("assets/images/lionel.jpg"),
                            //child: LoaderS()
                          );
                        }
                        if(!snapshot.hasData) {
                          log("snapshot err: ${snapshot.error}");
                          return CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            //backgroundImage: const AssetImage("assets/images/lionel.jpg"),
                            //child: LoaderS()
                          );
                        }
                        final data = snapshot.data!;
                        return InkWell(
                          onTap: () {
                            if(data.dwellerKind == 'seeker') {
                              Get.to(() => ProfileSettingSeeker(
                                context: context,
                              ));
                            }
                            else {
                              Get.to(() => ProfilePageHost(
                                property: data.property,
                                userId: data.id,
                              ));
                            }
                          },
                          child: data.displayPicture.isEmpty ? CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            //backgroundImage: const AssetImage("assets/images/lionel.jpg"),
                            child: Text(
                              getFirstLetter(data.firstname),
                              style: GoogleFonts.poppins(
                                color: AppColor.blackColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          )
                          :CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            backgroundImage: NetworkImage(data.displayPicture),
                          ),
                        );
                      }
                    ),
                
                  ],
                ),
              ),

              SizedBox(height: 20.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                child: Text(
                  'Chats',
                  style: GoogleFonts.bricolageGrotesque(
                    color: AppColor.blackColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  
              //main body(wrap with Swipes GET Futurebuilder)
              /*BookmarkEmptyState(
                title: "You haven't saved anyone's profile yet",
                subtitle: "When you bookmark your interests, they'll show up here.",
                /*button: PetiteButton(
                  backgroundColor: AppColor.blackColor,
                  text: 'Start swiping!',
                  onPressed: () {},
                ),*/
              ),*/

              ChatListNew(), //ChatList
  
                   
            ],
          ),
        ),
      ),
    );
  }
}