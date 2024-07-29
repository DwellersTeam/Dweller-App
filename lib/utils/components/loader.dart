import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class LoaderWhite extends StatelessWidget {
  const LoaderWhite({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeRotatingDots(
        color: AppColor.whiteColor,
        size: 35.r, //55.r
      ),
    );
  }
}


class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeRotatingDots(
        color: AppColor.darkPurpleColor,
        size: 35.r, //55.r
      ),
    );
  }
}


class LoaderS extends StatelessWidget {
  const LoaderS({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeRotatingDots(
        color: AppColor.darkPurpleColor,
        size: 25.r, //55.r
      ),
    );
  }
}



class Loader2 extends StatelessWidget {
  const Loader2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.waveDots( 
        color: AppColor.darkPurpleColor,
        size: 35.r, //55.r
      ),
    );
  }
}

class ErrorLoader extends StatelessWidget {
  const ErrorLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.waveDots( 
        color: AppColor.redColor,
        size: 35.r, //55.r
      ),
    );
  }
}