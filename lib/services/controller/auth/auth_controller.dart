import 'package:dweller/view/auth/onboarding/page/first_page.dart';
import 'package:dweller/view/auth/onboarding/page/fourth_page.dart';
import 'package:dweller/view/auth/onboarding/page/second_page.dart';
import 'package:dweller/view/auth/onboarding/page/third_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';








class AuthController extends getx.GetxController {


  //ONBOARDING SECTION//
  int activePage = 0;
  final List<Widget> pages = [
    const FirstPage(),
    const SecondPage(),
    const ThirdPage(),
    const FourthPage(),
  ];

  //REGULAR EXPRESSIONS (REGEX)
  final emailRegex = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'
  );


  //LOGIN SECTION//
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();


  //REGISTRATION SECTION//
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailOTPController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  //phone number selector
  var phone_code = "".obs; 
  void onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    phone_code.value = countryCode.dialCode.toString();
    //phone_code.isEmpty ? "+234" : phone_code.value;
    debugPrint("New Country selected: ${phone_code.value}");
    update();
  }

  //FORGOT PASSWORD SECTION//
  TextEditingController forgotPasswordEmailController = TextEditingController();
  TextEditingController forgotPasswordOTPController = TextEditingController();
  TextEditingController forgotPasswordNewPasswordController = TextEditingController();
  TextEditingController forgotPasswordConfirmNewPasswordController = TextEditingController();
  
  
  //VALIDATORS
  String? validateFirstName({required String value}) {
    if(value.isEmpty) {
      return "First name is required";
    }
    if (GetUtils.isLengthLessThan(value.trim(), 3)) {
      return "First name is too short";
    } 
    return null;
  }

  String? validateLastName({required String value}) {
    if(value.isEmpty) {
      return "Last name is required";
    }
    if (GetUtils.isLengthLessThan(value.trim(), 3)) {
      return "Last name is too short";
    }
    return null;
  }


  String? validateEmail({required String value}) {
    if(value.isEmpty) {
      return "Email address is required";
    }
    if (!emailRegex.hasMatch(value) && !GetUtils.isEmail(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? validatePhoneNumber({required String value}) {
    if(value.isEmpty) {
      return "Phone number is required";
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return "Please enter a valid phone number";
    }
    if (GetUtils.isLengthLessThan(value.trim(), 6)) { //8
      return "Phone number must be atleast 6 characters long";
    }
    return null;
  }

  String? validatePassword({required String value}) {
    if(value.isEmpty) {
      return "Password is required";
    }
    if (GetUtils.isLengthLessThan(value.trim(), 8)) {
      return "Password must be atleast 8 characters long";
    } 
    if (GetUtils.isAlphabetOnly(value)) {
      return "Password must be alphanumeric";
    } 
    if (GetUtils.isNumericOnly(value)) {
      return "Password must be alphanumeric";
    } 
    if (GetUtils.isPhoneNumber(value)) {
      return "Password can not be a phone number";
    } 
    return null;
  }

  String? validateConfirmPassword({required String firstValue, required String secondValue}) {
    if (GetUtils.isAlphabetOnly(secondValue)) {
      return "Password must be alphanumeric";
    } 
    if (GetUtils.isNumericOnly(secondValue)) {
      return "Password must be alphanumeric";
    } 
    if (GetUtils.isPhoneNumber(secondValue)) {
      return "Password can not be a phone number";
    }
    if(secondValue.isEmpty) {
      return "Password is required";
    }
    if (firstValue.trim() != secondValue.trim()) {
      return "Password do not match";
    }
    return null;
  }




  @override
  void dispose() {
    // TODO: implement dispose
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    emailOTPController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
 
    forgotPasswordEmailController.dispose();
    forgotPasswordOTPController.dispose();
    forgotPasswordNewPasswordController.dispose();
    forgotPasswordConfirmNewPasswordController.dispose();

    loginEmailController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }

}