import 'package:dweller/services/controller/auth/auth_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/auth/onboarding/page/intro_page.dart';
import 'package:dweller/view/auth/widgets/button/get_started_button.dart';
import 'package:dweller/view/auth/widgets/button/next_button.dart';
import 'package:dweller/view/auth/widgets/button/skip_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';











class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightCreamColor,
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {

    var controller = Get.put(AuthController());
    final size = MediaQuery.of(context).size;
    //int activePage = 0;
    final PageController pageViewController = PageController(initialPage: controller.activePage);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          colors: [
            AppColor.blueColorOpacity,
            AppColor.lightCreamColor,
          ]
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [        
          SizedBox(height: MediaQuery.of(context).size.height * 0.12,), //100.h
          //PageView.builder() Widget
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.67, //550 //445.h,
            width: size.width,  //double.infinity
            child: PageView.builder( 
              scrollDirection: Axis.horizontal,
              itemCount: controller.pages.length,
              controller: pageViewController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  controller.activePage = value;
                });
                debugPrint('${controller.activePage}');
              },
              itemBuilder: (context, index) {
                return controller.pages[index];
              }
            ),
          ),
          //SizedBox(height: 30),
          //SmoothPageIndicator
          SmoothPageIndicator(
            //activeIndex: activePage,
            controller: pageViewController, 
            count: controller.pages.length,  
            onDotClicked: (index) {
              pageViewController.animateToPage(
                index, 
                duration: const Duration(milliseconds: 300), 
                curve: Curves.elasticInOut
              );
            }, 
            effect: const WormEffect(
              dotHeight: 8.0,  //8
              dotWidth: 20.0, //10.0
              dotColor: AppColor.lightGreyColor,
              activeDotColor: AppColor.blueColor,
              type: WormType.normal,
            ),
          ),                  
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          //buttons
          controller.activePage != 3 ?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OnbNextButton(
                onNext: () {
                  setState(() {
                    controller.activePage++; //= cont
                  });
                  if(controller.activePage <= 3) {
                    pageViewController.animateToPage(
                      controller.activePage, 
                      duration: const Duration(milliseconds: 300), 
                      curve: Curves.elasticInOut
                    );
                  }
                    
                  
                },
              ),
              SizedBox(height: 20.h,),
              OnbSkipButton(
                onSkip: () {
                  Get.offAll(() => const IntroPage(), transition: Transition.rightToLeft);
                },
              ),  
            ],
          )
          :Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
            child: GetStartedButton(
              onGetStarted: () {
                Get.offAll(() => const IntroPage(), transition: Transition.rightToLeft);
              },
            )
          )
            
        ],  
      ),
    );
  }
  
}