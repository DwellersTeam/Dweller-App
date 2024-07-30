import 'dart:developer';

import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/services/controller/create_profile/create_profile_controller.dart';
import 'package:dweller/services/controller/settings/settings_controller.dart';
import 'package:dweller/services/repository/create_profile_service/create_profile_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_appbar.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/settings/page/edit_bio_settings.dart';
import 'package:dweller/view/settings/page/edit_hobbies_lifestyle_settings.dart';
import 'package:dweller/view/settings/page/host_listing/add_property_screen.dart';
import 'package:dweller/view/settings/page/host_listing/edit_property_screeen.dart';
import 'package:dweller/view/settings/page/host_listing/view_property_screen.dart';
import 'package:dweller/view/settings/page/main/settings_page.dart';
import 'package:dweller/view/settings/widget/general/all_buttons.dart';
import 'package:dweller/view/settings/widget/general/success_sheet_acc.dart';
import 'package:dweller/view/settings/widget/profile_settings/add_photos_bottomsheet.dart';
import 'package:dweller/view/settings/widget/profile_settings/bio_card.dart';
import 'package:dweller/view/settings/widget/profile_settings/display_pictures_list.dart';
import 'package:dweller/view/settings/widget/profile_settings/hobbies_card.dart';
import 'package:dweller/view/settings/widget/profile_settings/profile_card.dart';
import 'package:dweller/view/settings/widget/profile_settings/update_displaypic_bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';











class ProfilePageHost extends StatelessWidget {
  const ProfilePageHost({super.key, required this.property, required this.userId});
  final bool property; //check if host has uploaded a property or not.
  final String userId;


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

              //appbar
              DwellerAppBar(
                actionIcon: InkWell(
                  onTap: () {
                    Get.to(() => const SettingsPage());
                  },
                  child: SvgPicture.asset('assets/svg/settings_icon.svg')
                ),
              ),
            
              SizedBox(height: size.height * 0.01,),
            
              HostProfileTab(property: property, userId: userId,)
                   
            ],
          ),
        ),
      ),
    );
  }
}








class HostProfileTab extends StatefulWidget {
  const HostProfileTab({super.key, required this.property, required this.userId,});
  final bool property; //check if host has uploaded a property or not.
  final String userId;



  @override
  State<HostProfileTab> createState() => _HostProfileTabState();
}

class _HostProfileTabState extends State<HostProfileTab> with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70.w), //50.w
            child: AnimatedContainer(
              //padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.blueColorOp,
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(color: AppColor.blueColorOp)
              ),
              duration: const Duration(milliseconds: 100),
              child: Column(
                children: [
                  //added
                  TabBar(                    
                    physics: const BouncingScrollPhysics(),
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h), //3.w, 3.h
                    indicatorColor: AppColor.blackColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: AppColor.whiteColor,
                    //indicatorWeight: 0.1,
                    labelStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    unselectedLabelColor: AppColor.blackColor,
                    labelColor: AppColor.whiteColor,
                    //padding: EdgeInsets.symmetric(horizontal: 10),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: AppColor.blackColor,
                      shape: BoxShape.rectangle,
                    ),
                    controller: tabController,
                    isScrollable: false,
                    tabs: const [
                      Tab(text: 'Profile',),
                      Tab(text: 'Property',),
                    ],
                  ),
                ],
              ),
            ),
          ),
                
          SizedBox(height:20.h),
                      
          //tabbar content here //wrap with future builder
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: const BouncingScrollPhysics(),
              children: [
                ProfileSettingHost(
                  context: context,
                ),
                //AddListingPage(),
                widget.property ? ViewListingPage(userId: widget.userId,):  const AddListingPage(),
      
              ]
            ),
          ),

        ],
      ),
    );
  }
}




class ProfileSettingHost extends StatefulWidget {
  const ProfileSettingHost({super.key, required this.context});

  final BuildContext context;


  @override
  State<ProfileSettingHost> createState() => _ProfileSettingHostState();
}

class _ProfileSettingHostState extends State<ProfileSettingHost> {

  final settingController = Get.put(SettingsController());

  final profileService = Get.put(CreateProfileService());

  final profileController = Get.put(CreateProfileController());

  //REFRESH FUNCTIONALITY
  late Future<UserModel> userFuture;

  Future<UserModel> _refresh() async{
    await Future.delayed(Duration(seconds: 2));
    final userModel = await profileService.getCurrentUserEndpoint(context);
    return userModel;
  }

  @override
  void initState() {
    // TODO: implement initState
    userFuture = _refresh();
    super.initState();
  }

  Future<void> _handleRefresh() async{
    setState(() {
      userFuture = _refresh();
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
            
              Expanded(
                child: FutureBuilder<UserModel>(
                  future: userFuture,
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }
                    if(snapshot.hasError) {
                      log("snapshot err: ${snapshot.error}");
                      return Center(
                        child: Text(
                          'something went wrong',
                          style: GoogleFonts.poppins(
                          color: AppColor.darkPurpleColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    if(!snapshot.hasData) {
                      log("snapshot err: ${snapshot.error}");
                      return Center(
                        child: Text(
                          'no data found',
                          style: GoogleFonts.poppins(
                          color: AppColor.darkPurpleColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    final data = snapshot.data!;
                    return RefreshIndicator.adaptive(
                      color: AppColor.whiteColor,
                      backgroundColor: AppColor.darkPurpleColor,
                      onRefresh: () =>  _handleRefresh(),  //_refresh(),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Profile',
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.darkPurpleColor,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 20.h,),
                            //PROFILE CARD
                            ProfileCard(
                              displayName: "${data.firstname} ${data.lastname}",
                              displayPic: data.displayPicture,
                              age: data.age.toString(),
                              zodiac: data.zodiac,
                              onEditPhoto: () {
                                updateProfilePhotoBottomsheet(
                                   onRefresh: () => _handleRefresh(),
                                  context: context,
                                  controller: profileController,
                                  service: profileService
                                );
                              },
                            ),
                            SizedBox(height: 40.h,),
                      
                            //BIO CARD
                            BioCard(
                              onEdit: () {
                                Get.to(() => EditBioSettings(
                                  onRefresh: () => _handleRefresh(),
                                  dwellerKind: data.dwellerKind,
                                  bio: data.bio,
                                  address: data.location.address,
                                  job: data.job,
                                  placeId: data.location.placeId,
                                  latitude: data.location.latitude,
                                  longitude: data.location.longitude,
                                ));
                              },
                              bioText: '"${data.bio}"',
                              jobText: data.job,
                              locationText: data.location.address,
                            ),
                            SizedBox(height: 40.h,),
                                  
                            HobbiesCard(
                              onEdit: () {
                                Get.to(() => EditLifestylePage(
                                  onRefresh: () => _handleRefresh(),
                                  noiseLevel: data.preferences.noise,
                                  alcohol: data.preferences.alcohol,
                                  smoke: data.preferences.smoke,
                                  sleepSchedule: data.preferences.sleepSchedule,
                                  workSchedule: data.preferences.workStudySchedule,
                                  visitors: data.preferences.visitors,
                                  pets: data.preferences.pets,
                                  interests: data.preferences.interests,
                                  livelihood: data.preferences.livelihood,
                                ));
                              },
                              interests: data.preferences.interests,
                              livelihood: data.preferences.livelihood,
                            ),
                            SizedBox(height: 40.h,),
                            Text(
                              'Display pictures',
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.blackColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            
                            SizedBox(height: 20.h,),
                            NoteBox(
                              text: 'Tap to select the picture you want to keep so the rest gets deleted'
                            ),
                            SizedBox(height: 20.h,),

                            DisplayPicList(
                              onDelete: () {
                                profileService.updateUserDisplayPhotosEndpoint(
                                  context: context, 
                                  pictures: profileController.selectedPicsForDeletion,
                                  onSuccess: () {
                                    profileController.selectedPicsForDeletion.clear();
                                    _handleRefresh();
                                    //Get.back();
                                    successBottomsheet(
                                      context: context,
                                      title: 'Media updated successfully'
                                    );
                                  }
                                );

                              },
                              onAdd: () {
                                addDisplayPhotosBottomsheet(
                                  onRefresh: () => _handleRefresh(),
                                  context: context,
                                  controller: settingController,
                                  profileController: profileController,
                                  profileService: profileService
                                );
                              },
                              displayPicturesList: data.pictures,
                            ),
                            SizedBox(height: 40.h,),
                          ]
                        )
                      ),
                    );
                  }
                ),
              ),
    
            ]
          ),
        )
      )
    );
  }
}