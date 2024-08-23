import 'dart:developer';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/services/controller/settings/settings_controller.dart';
import 'package:dweller/services/repository/match_service/match_service.dart';
import 'package:dweller/services/repository/settings_service/settings_service.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/utils/invention/use_stripe_for_subscription.dart';
import 'package:dweller/view/home/widget/alert/right_swipe_alert.dart';
import 'package:dweller/view/subscription/widget/subscription_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;






class HomePageController extends getx.GetxController {
  
  final settingController = getx.Get.put(SettingsController());
  final settingService = getx.Get.put(SettingService());
  final subscriptionClass = StripeSubscriptionClass();

  final isOnPro = false.obs;
  final isBookmarked = false.obs;  


  getx.RxInt currentIndex = 0.obs;
  getx.RxInt rightSwipeCount = 0.obs; // Counter for right swipes

  List<String> imageUrls = [
    'assets/images/lionel.jpg',
    'assets/images/messi.png',
  ];

  void nextImage({required List<dynamic> imageList}) {
    currentIndex.value = (currentIndex.value + 1) % imageList.length;
    log("${currentIndex.value}");
    update();
  }
  

  

  

  //AppinioSwier Tools
  final AppinioSwiperController controller = AppinioSwiperController();
  void swipeEnd({
    required int previousIndex, 
    required int targetIndex, 
    required SwiperActivity activity,
    //add variables but make them nullable => [String? val, String? fil]
    required BuildContext context, 
    required VoidCallback onSuccess,
    required UserModel userModel
    }) {
    switch (activity) {
      case Swipe():
        log('The card was swiped to the : ${activity.direction.name}');
        log('previous index: $previousIndex, target index: $targetIndex');

        if (activity.direction.name == "right") {

          if (rightSwipeCount.value == 5) { 
            // Reset the counter back to default
            rightSwipeCount.value = 0;
            // If 7 right swipes, call the alert function
            rightSwipeAlert(context: context, user: userModel);
          }
          else if (rightSwipeCount.value <= 4){
            //call the api that matches straight up
            log('The card was swiped to the : ${activity.direction.name}');
            // Increment the right swipe count
            rightSwipeCount.value++;
            onSuccess();
          }
          else{
            log('nothing happening fam');
          }
        } 
        else {
          log("user swiped left (rejection)");
        }
        currentIndex.value = 0;

        break;
      case Unswipe():
        log('A ${activity.direction.name} swipe was undone.');
        log('previous index: $previousIndex, target index: $targetIndex');
        currentIndex.value = 0;
        break;
      case CancelSwipe():
        log('A swipe was cancelled');
        currentIndex.value = 0;
        break;
      case DrivenActivity():
        log('Driven Activity');
        //currentIndex.value = 0;
        break;
    }
  }

  void onEnd({required bool isUserPro, required BuildContext context}) {
    if(isUserPro){
      showMessagePopup(
        title: "You're all caught up!", 
        message: "refresh to see if there are new updates", 
        buttonText: "Okay", 
      );
      log('end reached! you are all caught up!');
    }
    else{
      subscriptionBottomsheetAdvancedSearch(
        context: context,
        settingsController: settingController,
        service: settingService,
        subscriptionService: subscriptionClass
      );
    }
    log('end reached!');
  }

  // Animates the card back and forth to teach the user that it is swipable.
  Future<void> shakeCard() async {
    const double distance = 30;
    // We can animate back and forth by chaining different animations.
    await controller.animateTo(
      const Offset(-distance, 0),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    await controller.animateTo(
      const Offset(distance, 0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    // We need to animate back to the center because `animateTo` does not center
    // the card for us.
    await controller.animateTo(
      const Offset(0, 0),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  





  //Host Property Facilities(Dummy List)
  List<Map<String, dynamic>> facilitiesList = [
    { 
      "icon": "assets/svg/storage.svg", //"📦",
      "facility": 'Storage',
    },
    {
      "icon": "assets/svg/gym.svg", //"🏋️‍♂️",
      "facility": 'Gym',
    },
    {
      "icon": "assets/svg/ev.svg", //"⛽",
      "facility": 'EV Charging',
    },
    {
      "icon": "assets/svg/park.svg", //"🚧",
      "facility": 'Parking',
    },
    {
      "icon": "assets/svg/wifi.svg", //"📡",
      "facility": 'Wifi',
    },
    {
      "icon": "assets/svg/kids.svg", //"🤸‍♂️",
      "facility": 'Kids Park',
    },
  ];
  
  //Host Profile Hobbies(Dummy List)
  List<String> mainHobbiesList = [
    'Gaming',
    'Reading',
    'Cooking',
  ];

  //Host Profile Lifestyle(Dummy List)
  List<String> mainLifestyleList = [
    'Zero noise',
    'Social drinker',
    'Early riser',
    "9-5"
  ];
  









  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}