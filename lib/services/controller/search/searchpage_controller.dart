import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;






class SearchPageController extends getx.GetxController {

  //for the search textfield on the search page
  final TextEditingController locationController = TextEditingController();
  final TextEditingController roomsController = TextEditingController();
  
  //Room Size
  final getx.RxDouble uppervalueRM = 0.0.obs;
  final getx.RxDouble lowervalueRM = 0.0.obs;

  //Price
  final getx.RxDouble uppervaluePR = 0.0.obs;
  final getx.RxDouble lowervaluePR = 0.0.obs;

  //Distance
  final getx.RxDouble uppervalueDS = 0.0.obs;
  final getx.RxDouble lowervalueDS = 0.0.obs; //only save this to db

  //Age
  final getx.RxDouble uppervalueAge = 0.0.obs;
  final getx.RxDouble lowervalueAge = 0.0.obs;


  //FILTER BY MAIN HOBBIES/INTERESTS
  //Main Hobbies and Interests
  List<String> mainHobbiesList = [
    'Gaming',
    'Arts & Crafts',
    'Music',
    'Travelling',
    'Outdoor activities',
    'Hiking',
    'Concerts',
    'Reading',
    'Cooking',
    'Sports',
  ];
  List<String> selectedMainHobbiesList = []; //SAVE TO DB

  //Facilities
  List<String> facilitiesList = [
    'Parking',
    'Wifi',
    'Gym',
    'Storage',
    'EV Charging',
    'Kids Park',
  ];
  List<String> selectedFacilitiesList = []; //SAVE TO DB

  //Pets
  int selectedPetsIndex = -1;
  final List<String> petList = [
    'Cat',
    'Dog',
    'Others',
    'None',
  ];
  //(save to db)
  final TextEditingController selectedPetController = TextEditingController();
  void onPetsSelected({required int index}) {
    selectedPetController.text = petList[index];
    print('Selected Pet: ${selectedPetController.text}');
    // You can perform any other actions based on the selected animal here
  }

  //Gender
  final List<String> genderList = [
    'Male',
    'Female',
    'Others',
  ];
  List<String> selectedGenderList = []; //SAVE TO DB
  int selectedGenderIndex = -1;
  //(save to db)
  /*final TextEditingController selectedGenderController = TextEditingController();
  void onGenderSelected({required int index}) {
    selectedGenderController.text = genderList[index];
    print('Selected Gender: ${selectedGenderController.text}');
    // You can perform any other actions based on the selected animal here
  }*/



  @override
  void dispose() {
    locationController.dispose();
    roomsController.dispose();
    selectedPetController.dispose();
    super.dispose();
  }

}