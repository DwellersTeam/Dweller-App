import 'dart:developer';
import 'package:dweller/model/profile/jwt_response.dart';
import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/services/controller/home/homepage_controller.dart';
import 'package:dweller/services/controller/settings/settings_controller.dart';
import 'package:dweller/services/repository/auth_service/auth_service.dart';
import 'package:dweller/services/repository/create_profile_service/create_profile_service.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/services/repository/notification_service/push_notifications.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/view/create_profile/page/intro/welcome_page.dart';
import 'package:dweller/view/home/widget/feeds_card(h&s)/host_card.dart';
import 'package:dweller/view/home/widget/feeds_card(h&s)/seeker_card.dart';
import 'package:dweller/view/home/widget/notification/notification_sheet.dart';
import 'package:dweller/view/settings/page/profile_type/profile_settings_host.dart';
import 'package:dweller/view/settings/page/profile_type/profile_settings_seeker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:google_fonts/google_fonts.dart';








class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  
  final CreateProfileService profileService = Get.put(CreateProfileService());
  final HomePageController controller = Get.put(HomePageController());
  final SettingsController settingsController = Get.put(SettingsController());
  final PushNotificationController notiController = Get.put(PushNotificationController());

  final authService = Get.put(AuthService());

  //get dweller kind
  final String dwellerKind = LocalStorage.getDwellerType();

                  
  late Future<JwtModel> profileFuture;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      controller.shakeCard();
    });
    profileFuture = _refresh();
    
    super.initState();
  }


  //REFRESH FUNCTIONALITY
  Future<JwtModel> _refresh() async{
    await Future.delayed(const Duration(seconds: 2));
    final profileFuture = await profileService.fetchUserDetailFromJWT(context);
    controller.isOnPro.value = profileFuture.pro;
    controller.hasProperty.value = profileFuture.property ?? false;
    log("does current user have property ? ${controller.hasProperty.value}");
    log("is current user on dweller pro ? ${controller.isOnPro.value}");
    if(controller.hasProperty.value) {
      showPropertyAlertPopup(
        onTap: () {
          Get.back();
          Get.to(() => ProfilePageHost(
            property: profileFuture.property,
            userId: profileFuture.id,
          ));
        },
      );
    }
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
      body: dwellerKind.isEmpty || dwellerKind == null ? const WelcomePage() : SafeArea(
        child: CustomPaint(
          painter: TopRedSectionPainter(),
          //wrap with profile GET request FutureBuilder
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 18.h,),    //20.h
              //HEADER
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ 
    
                    InkWell(
                      onTap: () {
                        notificationBottomsheet(context: context);  
                        //authService.logoutUser();
                        //Get.to(() => const WelcomePage());
                      },
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
                            //child: const LoaderS()
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

                            //Get.to(() => WelcomePage());

                            /*showPropertyAlertPopup(
                              onTap: () {
                                Get.back();
                                Get.to(() => AddListingPage());
                              },
                            );*/

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
            
              //SizedBox(height: size.height * 0.01,),
                  
              //main body(wrap with Swipes GET Futurebuilder)
              Expanded(
                //(wrap with Swipes GET Futurebuilder)
                child: Padding(
                  //physics: const BouncingScrollPhysics(),
                  //scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                  //CHECK IF THE LOGGED-IN USER IS A HOST OR SEEKER
                  child: dwellerKind == 'seeker' ? HostCard(isOnPro: controller.isOnPro.value,) : SeekerCard(isOnPro: controller.isOnPro.value),

                  //child: SeekerCard(isOnPro: controller.isOnPro.value)
                ),
              ), 
                   
            ],
          ),
        ),
      ),
    );
  }
}

