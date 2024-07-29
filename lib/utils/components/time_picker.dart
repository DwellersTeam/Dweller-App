// Function to show the time picker and set the selected time
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';





Future<void> selectTime(
  BuildContext context, 
  RxString selectedTime,
  ) async {

  // Determine if the user prefers 24-hour format
  bool use24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;

  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: use24HourFormat),
        child: child!,
      );
    },
  );

  if (picked != null) {
    String formattedTime = picked.format(context);
    selectedTime.value = formattedTime;
    log(selectedTime.value);
  } 

}