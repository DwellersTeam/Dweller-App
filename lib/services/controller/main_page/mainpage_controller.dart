import 'dart:developer';
import 'package:dweller/main.dart';
import 'package:dweller/view/bookmark/page/bookmark_page.dart';
import 'package:dweller/view/chat/page/chat_page.dart';
import 'package:dweller/view/home/page/homepage.dart';
import 'package:dweller/view/match/page/matchpage.dart';
import 'package:dweller/view/search/page/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as getx;








class MainPageController extends getx.GetxController {

  //selected index
  getx.RxInt selectedIndex = 0.obs;

  //widget options
  final List<Widget> widgetOptions = <Widget>[
    const HomePage(),
    SearchPage(),
    MatchPage(),
    BookmarkPage(),
    ChatPage(),

  ];

  dynamic setIndex(int setindex) {
    selectedIndex.value = setindex;
    log("index: $setindex");
    update();
  }



  Future<void> navigateToMainpageAtIndex({required Widget page, required int index}) async{
    // Use Navigator to push to onto the navigation stack
    setIndex(index);
    navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute(
        builder: (context) => page,
      )
    );
  }



  //navbar items
  List<BottomNavigationBarItem> navBarsItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/svg/home_active.svg'),
        icon: SvgPicture.asset('assets/svg/home.svg'),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/svg/filter.svg'), //search_active.svg
        icon: SvgPicture.asset('assets/svg/filter_inactive.svg'),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/svg/match_active.svg'),
        icon:  SvgPicture.asset('assets/svg/match.svg'),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/svg/bookmark_active.svg'),
        icon:  SvgPicture.asset('assets/svg/bookmark.svg'),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/svg/chat_active.svg'),
        icon: SvgPicture.asset('assets/svg/chat.svg'),
        label: '',
      ),
    ];
  }

}