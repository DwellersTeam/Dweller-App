import 'dart:developer';
import 'package:dweller/model/settings/settings_response.dart';
import 'package:dweller/services/controller/settings/settings_controller.dart';
import 'package:dweller/services/repository/auth_service/auth_service.dart';
import 'package:dweller/services/repository/settings_service/settings_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_appbar.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/settings/page/account_settings.dart';
import 'package:dweller/view/settings/page/kyc_settings.dart';
import 'package:dweller/view/settings/page/legal_settings.dart';
import 'package:dweller/view/settings/page/profile_type/profile_settings_seeker.dart';
import 'package:dweller/view/settings/widget/kyc_settings/kyc_card.dart';
import 'package:dweller/view/settings/widget/general/selector.dart';
import 'package:dweller/view/settings/widget/general/switch_widget.dart';
import 'package:dweller/view/settings/widget/logout/logout_overlay.dart';
import 'package:dweller/view/subscription/page/subscription_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';










class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final controller = Get.put(SettingsController());
  final authService = Get.put(AuthService());
  final settingsService = Get.put(SettingService());

  late Future<SettingsResponse> settingsFuture;

  @override
  void initState() {
    settingsFuture = _refresh();
    super.initState();
  }


  //REFRESH FUNCTIONALITY
  Future<SettingsResponse> _refresh() async{
    await Future.delayed(const Duration(seconds: 2));
    final settingsFuture = await settingsService.getUserSettings(context);
    return settingsFuture;
  }


  Future<void> _handleRefresh() async{
    setState(() {
      settingsFuture = _refresh();
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: CustomPaint(
          painter: TopRedSectionPainter(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //appbar
              DwellerAppBar(
                actionIcon: SvgPicture.asset('assets/svg/settings_icon.svg'),
              ),
              //SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Settings',
                  style: GoogleFonts.bricolageGrotesque(
                    color: AppColor.darkPurpleColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              SizedBox(height: 15.h,),
              Expanded(
                child: FutureBuilder<SettingsResponse>(
                  future: settingsFuture,
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const LoaderS();
                    }
                    if(snapshot.hasError){
                      log("snapshot err: ${snapshot.error}");
                      return Center(
                        child: Text(
                          'An error occured.',
                          style: GoogleFonts.bricolageGrotesque(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      );
                    }
                    if(!snapshot.hasData) {
                      log("snapshot has data?: ${snapshot.hasData}");
                      return Center(
                        child: Text(
                          'No settings data found.',
                          style: GoogleFonts.bricolageGrotesque(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      );
                    }
                    
                    final data = snapshot.data!;

                    return RefreshIndicator.adaptive(
                      color: AppColor.whiteColor,
                      backgroundColor: AppColor.darkPurpleColor,
                      onRefresh: () => _handleRefresh(),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            data.kyc.status == 'pending' ? const PurpleKYCCard() : data.kyc.status == "accepted" ? const SuccessPurpleKYCCard() : 
                            KYCCard(
                              onStartKyc: () {
                                Get.to(()=> KYCSettings(
                                  service: settingsService,
                                  onRefresh: () => _handleRefresh(),
                                ));
                              },
                            ),
                          
                            
                            SizedBox(height: 40.h,),
                            SettingsSelector(
                              onTap: () {
                                Get.to(() => AccountSettingsPage(
                                  userId: data.user,
                                ));
                              },
                              svgImage: SvgPicture.asset("assets/svg/acc.svg"),
                              text: "Account Settings",
                              icon: Icon(
                                color: AppColor.profileBlackColor,
                                size: 24.r,
                                CupertinoIcons.chevron_forward
                              )
                            ),
                            /*SizedBox(height: 50.h,),
                            SettingsSelector(
                              onTap: () {
                                Get.to(()=> ProfileSettingSeeker());
                              },
                              svgImage: SvgPicture.asset("assets/svg/profile.svg"),
                              text: "Profile Settings",
                              icon: Icon(
                                color: AppColor.profileBlackColor,
                                size: 24.r,
                                CupertinoIcons.chevron_forward
                              )
                            ),*/
                            SizedBox(height: 50.h,),
                            SettingsSelector2(
                              onTap: () {},
                              svgImage: SvgPicture.asset("assets/svg/notification.svg"),
                              text1: "Notifications",
                              text2: "Enable Push notifications",
                              text3: "While turned on, you'll receive notifications about messgaes, matches and updates on your phone even while outside the app.",
                              text4: "Enable Email notifications",
                              text5: "While turned on, you'll receive updates and information in your email inbox. You can turn this on/off at any time",
                              switchWidget1: SwitchWidget(
                                onChanged: (value) {
                                  //controller.isPushNotiToggled.value = value;
                                  //log("${controller.isPushNotiToggled.value}");
                                  data.pushNotification = value;
                                  settingsService.updatePushNotification(
                                    context: context, 
                                    pushNotification: value, 
                                    onSuccess: () {
                                      _handleRefresh();
                                    }
                                  );
                                
                                }, 
                                isToggled: data.pushNotification
                              ),
                              switchWidget2: SwitchWidget(
                                onChanged: (value) {
                                  //controller.isEmailNotiToggled.value = value;
                                  //log("${controller.isEmailNotiToggled.value}");
                                  data.emailNotification = value;
                                  settingsService.updateEmailNotification(
                                    context: context,
                                    emailNotification: value,
                                    onSuccess: () {
                                      _handleRefresh();
                                    }
                                  );
                                      
                                }, 
                                isToggled: data.emailNotification
                              ),   
                            
                            ),
                            //notification sub widgets
                            /*SizedBox(height: 50.h,),
                            SettingsSelector(
                              onTap: () {},
                              svgImage: SvgPicture.asset("assets/svg/preference.svg"),
                              text: "Preferences",
                            ),*/
                            //preference sub widgets
                            SizedBox(height: 50.h,),
                            SettingsSelector2(
                              onTap: () {},
                              svgImage: SvgPicture.asset("assets/svg/privacy.svg"),
                              text1: "Privacy Settings",             
                              text2: "Show me on Dweller",
                              text3: "While turned off, you'll not be shown on the card stack. You can still view and match with profiles",
                              text4: "Online indicator",
                              text5: "While turned off, Dwellers won't know if you're online or not in the chat room",
                              switchWidget1: SwitchWidget(
                                onChanged: (value) {
                                  //controller.isShowMeOnDwellerToggled.value = value;
                                  //log("${controller.isShowMeOnDwellerToggled.value}");
                                  data.showOnDweller = value;
                                  settingsService.updateShowMeOnDweller(
                                    context: context,
                                    showOnDweller: value,
                                    onSuccess: () {
                                      _handleRefresh();
                                    }
                                  );
                                }, 
                                isToggled: data.showOnDweller
                              ),
                              switchWidget2: SwitchWidget(
                                onChanged: (value) {
                                  //controller.isOnlineStatusToggled.value = value;
                                  //log("${controller.isOnlineStatusToggled.value}");
                                  data.showOnline = value;
                                  settingsService.updateShowMeOnline(
                                    context: context,
                                    showOnline: value,
                                    onSuccess: () {
                                      _handleRefresh();
                                    },
                                  );
                                    
                                }, 
                                isToggled: data.showOnline
                              ),
                            ),
                            
                            
                            //privacy sub widgets
                            SizedBox(height: 50.h,),
                            SettingsSelector(
                              onTap: () {
                                Get.to(() => SubscriptionPage());
                              },
                              svgImage: SvgPicture.asset("assets/svg/subscription.svg"),
                              text: "Subscriptions and Payments",
                              icon: Icon(
                                color: AppColor.profileBlackColor,
                                size: 24.r,
                                CupertinoIcons.chevron_forward
                              )
                            ),
                            SizedBox(height: 50.h,),
                            SettingsSelector(
                              onTap: () {
                                Get.to(() => const LegalSettings());
                              },
                              svgImage: SvgPicture.asset("assets/svg/legal.svg"),
                              text: "Legal",
                              icon: Icon(
                                color: AppColor.profileBlackColor,
                                size: 24.r,
                                CupertinoIcons.chevron_forward
                              )
                            ),
                            SizedBox(height: 50.h,),
                            SettingsSelector(
                              onTap: () {
                                showLogoutDialog(
                                  onCancel: () {
                                    Get.back();
                                  },
                                  onConfirm: () {
                                    authService.logoutUser();
                                  },
                                );
                              },
                              svgImage: SvgPicture.asset("assets/svg/logout.svg"),
                              text: "Logout",
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                )
              ),
              SizedBox(height: 50.h,),
                
          
            ],
          ),
        ),
      ),
    );
  }
}