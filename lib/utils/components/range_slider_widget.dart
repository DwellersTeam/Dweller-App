import 'dart:developer';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';






class RangeSliderWidget extends StatelessWidget {
  const RangeSliderWidget({super.key, required this.maximumRange, required this.lowervalue, required this.uppervalue});
  final double maximumRange;
  final RxDouble lowervalue;
  final RxDouble uppervalue;

  @override
  Widget build(BuildContext context) {
    return FlutterSlider(
      //touchSize: ,
      //lockDistance: ,
      /*foregroundDecoration: BoxDecoration(
        color: AppColor.blueColor,
      ),*/
      /*decoration: BoxDecoration(
        color: AppColor.blueColor,
        borderRadius: BorderRadius.circular(10.r),
      ),*/
      values: const [0, 40],
      rangeSlider: true,
      max: maximumRange,
      min: 0,
      onDragStarted: (handlerIndex, lowerValue, upperValue) {
        log('starting lower val: $lowerValue');
        log('starting upper val: $upperValue');
      },
      onDragging: (handlerIndex, lowerValue, upperValue) {
        lowervalue.value = lowerValue;
        uppervalue.value = upperValue;
        log('lower val: $lowerValue');
        log('upper val: $upperValue');
      },
      onDragCompleted: (handlerIndex, lowerValue, upperValue) {
        log('finished lower val: $lowerValue');
        log('finaished upper val: $upperValue');
      },
    );
  }
}



class SingleRangeSliderWidget extends StatelessWidget {
  const SingleRangeSliderWidget({super.key, required this.maximumRange, required this.lowervalue, required this.uppervalue});
  final double maximumRange;
  final RxDouble lowervalue;
  final RxDouble uppervalue;

  @override
  Widget build(BuildContext context) {
    return FlutterSlider(
      //touchSize: ,
      //lockDistance: ,
      /*foregroundDecoration: BoxDecoration(
        color: AppColor.blueColor,
      ),*/
      /*decoration: BoxDecoration(
        color: AppColor.blueColor,
        borderRadius: BorderRadius.circular(10.r),
      ),*/
      hatchMark: FlutterSliderHatchMark(),
      values: const [0, 50],
      rangeSlider: false,
      max: maximumRange,
      min: 0,
      onDragStarted: (handlerIndex, lowerValue, upperValue) {
        log('starting lower val: $lowerValue');
        log('starting upper val: $upperValue');
      },
      onDragging: (handlerIndex, lowerValue, upperValue) {
        lowervalue.value = lowerValue;
        uppervalue.value = upperValue;
        log('lower val: $lowerValue');
        log('upper val: $upperValue');
      },
      onDragCompleted: (handlerIndex, lowerValue, upperValue) {
        log('finished lower val: $lowerValue');
        log('finaished upper val: $upperValue');
      },
    );
  }
}