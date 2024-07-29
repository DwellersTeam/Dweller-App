import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;






class MatchPageController extends getx.GetxController {

  //for the search textfield on the search page
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

}