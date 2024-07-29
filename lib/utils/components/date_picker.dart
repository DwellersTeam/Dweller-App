import 'dart:developer';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/converters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';






Future<void> selectDate({
  required BuildContext context,
  required RxString selectedDate,
  }) async {
  //final ThemeData theme = Theme.of(context);
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1970, 1),
    lastDate: DateTime(2101),
    builder: (BuildContext? context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      );
    },
  );
  if (picked != null) {
    String formattedDate = formatDate(picked);
    log(formattedDate);
    selectedDate.value = formattedDate;
  }
  return;
}





final List<DateTime> validDates = [
  DateTime(2024, 5, 1),
  DateTime(2024, 5, 5),
  DateTime(2024, 5, 10),
  DateTime(2024, 5, 15),
  DateTime(2024, 5, 20),
  DateTime(2024, 5, 25),
];

///CUSTOMIZED MY OWN DATE PICKER TO SHOW LIST OF DATETIME OBJECTS AND BLACK OUT THE REST
class CustomDatePicker extends StatelessWidget {
  final List<DateTime> validDates;
  final ValueChanged<DateTime> onDateSelected;

  const CustomDatePicker({super.key, 
    required this.validDates,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(15.0.r),
      ),
      child: CalendarDatePicker(
        initialDate: validDates.first,
        firstDate: validDates.first,
        lastDate: validDates.last,
        selectableDayPredicate: (date) => validDates.contains(date),
        onDateChanged: onDateSelected,
      ),
    );
  }
}

Future<DateTime?> showCustomDatePicker({
  required BuildContext context,
  required List<DateTime> validDates,
  }) async {
  return await showDialog<DateTime>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: CustomDatePicker(
          validDates: validDates,
          onDateSelected: (date) {
            Navigator.of(context).pop(date);
          },
        ),
      );
    },
  );
}



Future<void> selectDateFromCustomCalendar({
  required BuildContext context,
  required RxString selectedDate,
  required List<DateTime> validDates,
  }) async {
  //final ThemeData theme = Theme.of(context);
  final DateTime? picked = await showCustomDatePicker(
    context: context,
    validDates: validDates
  );
  if (picked != null) {
    String formattedDate = formatDate(picked);
    log(formattedDate);
    selectedDate.value = formattedDate;
  }
  return;
}
