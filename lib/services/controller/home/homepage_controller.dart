import 'dart:developer';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/services/repository/match_service/match_service.dart';
import 'package:dweller/view/home/widget/alert/right_swipe_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;






class HomePageController extends getx.GetxController {
  

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
          log('The card was swiped to the : ${activity.direction.name}');
          // Increment the right swipe count
          rightSwipeCount.value++;
          onSuccess();

          //call the api that matches straight up
          if (rightSwipeCount.value == 5) { //5
            // If 7 right swipes, call the alert function
            rightSwipeAlert(context: context, user: userModel);
            // Reset the counter back to default
            rightSwipeCount.value = 0;
          }
        } 
        else {
          log("user swiped left (rejection)");
        }

        break;
      case Unswipe():
        log('A ${activity.direction.name} swipe was undone.');
        log('previous index: $previousIndex, target index: $targetIndex');
        break;
      case CancelSwipe():
        log('A swipe was cancelled');
        break;
      case DrivenActivity():
        log('Driven Activity');
        break;
    }
  }

  void onEnd() {
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