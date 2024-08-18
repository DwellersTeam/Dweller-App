import 'dart:convert';
import 'dart:developer';
import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/services/controller/main_page/mainpage_controller.dart';
import 'package:dweller/services/repository/create_profile_service/create_profile_service.dart';
import 'package:dweller/services/repository/data_service/base_service/base_service.dart';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/model/auth/google_signin_response.dart';
import 'package:dweller/model/auth/login_response.dart';
import 'package:dweller/model/auth/register_response.dart';
import 'package:dweller/model/auth/verify_email_response.dart';
import 'package:dweller/services/repository/notification_service/notification_service.dart';
import 'package:dweller/services/repository/notification_service/push_notifications.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/view/auth/login/page/login_page.dart';
import 'package:dweller/view/create_profile/page/intro/welcome_page.dart';
import 'package:dweller/view/main/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as diox;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';










class AuthService extends getx.GetxController {
  

  final baseService = getx.Get.put(BaseService());
  final mainPageController = Get.put(MainPageController());
  final pushNotiController = Get.put(PushNotificationController());
  final notificationService = Get.put(NotificationService());

  final userController = Get.put(CreateProfileService());
  final FCMToken = LocalStorage.getFCMToken();
  final tokenExpDateInt = LocalStorage.getTokenExpDate() ?? 0;
  final userId = LocalStorage.getUserID();
  final isLoading = false.obs;  




  //Log out / Sign Out from Google
  Future<GoogleSignInAccount?> signOutWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    return googleUser;
  }


  //to log a user out locally and simultaneously with google
  Future<dynamic> logoutUser() async {
    isLoading.value = true;
    await LocalStorage.deleteToken();
    await LocalStorage.deleteXrefreshToken();
    await LocalStorage.deleteUserID();
    await LocalStorage.deleteUserEmail();
    await LocalStorage.deleteUsername();
    await LocalStorage.deleteCloudinaryUrl();
    await LocalStorage.deleteKYCDoc();
    await LocalStorage.deleteDeviceLatitude();
    await LocalStorage.deleteDeviceLongitude();
    await LocalStorage.deleteDwellerType();
    await signOutWithGoogle();

    isLoading.value = false;
    getx.Get.offAll(() => const LoginPage());
  }


  //Login with Google
  Future<void> signInWithGoogle({required BuildContext context}) async {
    try {

      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'profile',
        ],
      ); // Add desired scopes

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        log("Google fetched user successfully");
        // User signed in successfully
        // You can also fetch additional information if needed
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken
        );


        log("accessToken: ${credential.accessToken}");
        log("google user raw accessToken: ${googleAuth.accessToken}");
        log("displayName: ${googleUser.displayName}");
        log("email: ${googleUser.email}");
        log("googleUser: ${googleUser.id}");
        log("photourl: ${googleUser.photoUrl}");

        await restAPIGoogleLogin(
          context: context,
          email: googleUser.email,
          displayName: googleUser.displayName!,
          accessToken: credential.accessToken,
        );
        

      } 
      else {
        log("Google user is null");
      }

    }
    on PlatformException catch (e) {
      isLoading.value = false;
      if (e.code == GoogleSignIn.kNetworkError) {
        //network error
        log(e.message!);
        log(e.code);
        showMessagePopup(
          title: 'Error',
          message: e.code,
          buttonText: 'Dismiss',
          context: context
        );
      }
      else if (e.code == GoogleSignIn.kSignInCanceledError) {
        //user cancelled the sign-in process
        log(e.message!);
        log(e.code);
        showMessagePopup(
          title: 'Error',
          message: e.code,
          buttonText: 'Dismiss',
          context: context
        );
      }
      else if (e.code == GoogleSignIn.kSignInFailedError) {

        //sign in failure
        log(e.message!);
        log(e.code);
        showMessagePopup(
          title: 'Error',
          message: e.code,
          buttonText: 'Dismiss',
          context: context
        );
      }
      else {        
        String errorMessage = "Something went wrong.";
        showMessagePopup(
          title: 'Error',
          message: errorMessage,
          buttonText: 'Dismiss',
          context: context
        );
      }
    }
    catch (e, stackTrace) {
      isLoading.value = false;
      log("Error during Google Sign-In: $e => $stackTrace");
      // Handle errors gracefully
      showMessagePopup(
        title: 'Error',
        message: '$e',
        buttonText: 'Dismiss',
        context: context
      );
    }

  }


  //Sign Up with Google
  Future<void> signUpWithGoogle({required BuildContext context}) async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'profile',
        ],
      ); // Add desired scopes
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {

        log("Google fetched user successfully");
        // User signed in successfully
        // You can also fetch additional information if needed
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken
        );

        log("accessToken: ${credential.accessToken}");
        log("google user raw accessToken: ${googleAuth.accessToken}");
        log("displayName: ${googleUser.displayName}");
        log("email: ${googleUser.email}");
        log("googleUser id: ${googleUser.id}");
        log("photourl: ${googleUser.photoUrl}");
        
        await restAPIGoogleSignUp(
          context: context,
          email: googleUser.email,
          displayName: googleUser.displayName!,
          accessToken: credential.accessToken,
        );

      } 
      else {
        log("Google user is null");
      }

    }
    on PlatformException catch (e) {
      isLoading.value = false;
      if (e.code == GoogleSignIn.kNetworkError) {
        //network error
        log(e.message!);
        log(e.code);
        showMessagePopup(
          title: 'Error',
          message: e.code,
          buttonText: 'Dismiss',
          context: context
        );
      }
      else if (e.code == GoogleSignIn.kSignInCanceledError) {
        //user cancelled the sign-in process
        log(e.message!);
        log(e.code);
        showMessagePopup(
          title: 'Error',
          message: e.code,
          buttonText: 'Dismiss',
           context: context
        );
      }
      else if (e.code == GoogleSignIn.kSignInFailedError) {

        //sign in failure
        log(e.message!);
        log(e.code);
        showMessagePopup(
          title: 'Error',
          message: e.code,
          buttonText: 'Dismiss',
          context: context
        );
      }
      else {        
        String errorMessage = "Something went wrong.";
        showMessagePopup(
          title: 'Error',
          message: errorMessage,
          buttonText: 'Dismiss',
          context: context
        );
      }
    }
    catch (e, stackTrace) {
      isLoading.value = false;
      log("Error during Google Sign-In: $e => $stackTrace");
      showMessagePopup(
        title: 'Error',
        message: '$e',
        buttonText: 'Dismiss',
        context: context
      );
    }
  }

  
  //MUYIWA'S GOOGLE AUTH (LOGIN)
  Future<void> restAPIGoogleLogin({
    required BuildContext context,
    required String? accessToken,
    required String email,
    required String displayName
  }) async {
    isLoading.value = true;
    try {

      final body = {
        "googleUserAccessToken": accessToken ?? "no token",
        "fcmToken": FCMToken ?? "no token"
      };
      
      http.Response res = await baseService.httpPostGoogle(endPoint: "auth/google/signin", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        
        //decode response from the server
        GoogleSigninResponse jsonResponse = GoogleSigninResponse.fromJson(json.decode(res.body)); 
        
        String accessToken = jsonResponse.accessToken;
        String refreshToken = jsonResponse.refreshToken;
        LocalStorage.saveToken(accessToken);
        LocalStorage.saveXrefreshToken(refreshToken);
        FlutterSessionJwt.saveToken(refreshToken);

        
        // Decode the JWT token with the awesome package {JWT Decoder}
        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);

        //Access the payload
        if (decodedToken != null) {
          log("Token payload: $decodedToken");
          // Access specific claims
          // Replace 'sub' with the actual claim you want
          String userId = decodedToken['_id'];
        
          int expDate = decodedToken['exp'];
          String dwellerKind = decodedToken['dwellerKind'] ?? 'non';
          LocalStorage.saveDwellerType(dwellerKind);
          await LocalStorage.saveTokenExpDate(expDate);
          await LocalStorage.saveUserID(userId);
          await LocalStorage.saveUserEmail(email);
          await LocalStorage.saveUsername(displayName);
        } 
        else {
          log("Failed to decode JWT token.");
        }

        //navigate to home
        mainPageController.navigateToMainpageAtIndex(page: const MainPage(), index: 0);


        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkPurpleColor,
          message: "sign in successful"
        );
          
      } 
      else {
        isLoading.value = false;
        //debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        return baseService.showErrorMessage(context: context, httpStatusCode: res.statusCode);
      }
    }
    on FormatException catch(e, stackTrace){
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (fmt)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
    on Exception catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (exc)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
  }



  //MUYIWA'S GOOGLE AUTH (SIGN UP)
  Future<void> restAPIGoogleSignUp({
    required BuildContext context,
    required String? accessToken,
    required String email,
    required String displayName
  }) async {
    isLoading.value = true;
    try {

      final body = {
        "googleUserAccessToken": accessToken ?? "no token",
        "fcmToken": FCMToken ?? "no token"
      };
      
      http.Response res = await baseService.httpPostGoogle(endPoint: "auth/google/signup", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        
        //decode response from the server
        GoogleSigninResponse jsonResponse = GoogleSigninResponse.fromJson(json.decode(res.body)); 
    

        String accessToken = jsonResponse.accessToken;
        String refreshToken = jsonResponse.refreshToken;
        await LocalStorage.saveToken(accessToken);
        await LocalStorage.saveXrefreshToken(refreshToken);
        await FlutterSessionJwt.saveToken(refreshToken);
        
        // Decode the JWT token with the awesome package {JWT Decoder}
        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
        //Access the payload
        if (decodedToken != null) {
          log("Token payload: $decodedToken");
          // Access specific claims
          // Replace 'sub' with the actual claim you want
          String userId = decodedToken['_id'];
          int expDate = decodedToken['exp'];
          LocalStorage.saveTokenExpDate(expDate);
          LocalStorage.saveUserID(userId);
          LocalStorage.saveUserEmail(email);
          LocalStorage.saveUsername(displayName);
        } 
        else {
          log("Failed to decode JWT token.");
        }

        await notificationService.createNotification(
          userId: userId,
          title: "Welcome to Dweller 🎊 $displayName", 
          subtitle: "Take a seat and enjoy the ride with us.", 
          type: "internal", 
          onSuccess: () async{
            print('notification created in db');
            await pushNotiController.sendNotification(
              targetUserToken: FCMToken, 
              title: 'Hey, $displayName', 
              body: 'welcome to Dweller. 🎊', 
              type: 'home' //navigate to home screen
            );
          }
        );

        getx.Get.offAll(() =>  const WelcomePage());
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkPurpleColor,
          message: "sign in successful"
        ); 

      } 
      else {
        isLoading.value = false;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.body}');
        return baseService.showErrorMessage(context: context, httpStatusCode: res.statusCode);
      }
    }
    on FormatException catch(e, stackTrace){
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (fmt)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
    on Exception catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (exc)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
  }

  
  Future<void> registerEndpoint({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
    required VoidCallback onSuccess,
  }) async {
    isLoading.value = true;
    try {

      final body = {
        "firstname": firstName,
        "lastname": lastName,
        "phone": phone,
        "email": email,
        "password": password,
        "passwordConfirmation": confirmPassword,
        "fcmToken": FCMToken ?? "no token"
      };
      
      diox.Response res = await baseService.httpPostAuth(endPoint: "auth/signup", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.data}');
        
        //decode response from the server
        RegisterResponse jsonResponse = RegisterResponse.fromJson(json.decode(res.data)); 

        String accessToken = jsonResponse.accessToken;
        String refreshToken = jsonResponse.refreshToken;
        LocalStorage.saveToken(accessToken);
        LocalStorage.saveXrefreshToken(refreshToken);
        FlutterSessionJwt.saveToken(refreshToken);
        
        // Decode the JWT token with the awesome package {JWT Decoder}
        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
        //Access the payload
        if (decodedToken != null) {
          log("Token payload: $decodedToken");
          // Access specific claims
          // Replace 'sub' with the actual claim you want
          String userId = decodedToken['_id'];
          int expDate = decodedToken['exp'];
          LocalStorage.saveTokenExpDate(expDate);
          LocalStorage.saveUserID(userId);
          LocalStorage.saveUserEmail(email);
          LocalStorage.saveUsername("$firstName $lastName");
        } 
        else {
          log("Failed to decode JWT token.");
        }

        await notificationService.createNotification(
          userId: userId,
          title: "Welcome to Dweller 🎊 $firstName $lastName", 
          subtitle: "Take a seat and enjoy the ride with us.", 
          type: "internal", 
          onSuccess: () async{
            print('notification created in db');
            await pushNotiController.sendNotification(
              targetUserToken: FCMToken, 
              title: 'Hey, $firstName $lastName', 
              body: 'welcome to Dweller. 🎊', 
              type: 'home' //navigate to home screen
            );
          }
        );

        //void call back
        onSuccess();

        //send push notification
        await pushNotiController.sendNotification(
          targetUserToken: FCMToken, 
          title: 'Hey, $firstName $lastName', 
          body: 'welcome to Dweller.🎊', 
          type: 'home' //navigate to home screen
        );

        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkPurpleColor,
          message: "registration successful"
        );
        

      } 
      else {
        isLoading.value = false;
        debugPrint('this is response body ==>${res.data}');
        debugPrint('this is response status ==>${res.statusCode}');
        //debugPrint('this is response reason ==> ${res.reasonPhrase}');
        return baseService.showErrorMessage(context: context, httpStatusCode: res.statusCode!);
      }
    }
    on FormatException catch(e, stackTrace){
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (fmt)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
    on Exception catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (exc)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
  }


  
  Future<void> loginEndpoint({
    required BuildContext context,
    required String email,
    required String password,
    required VoidCallback onSuccess,
  }) async {
    isLoading.value = true;
    try {

      final body = {
        "email": email,
        "password": password,
        "fcmToken": FCMToken ?? "no token"
      };
      
      diox.Response res = await baseService.httpPostAuth(endPoint: "auth/login", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        log('this is response body  ==> ${res.data}');

        // Decode response from the server
        LoginResponse jsonResponse = LoginResponse.fromJson(jsonDecode(res.data));

        String accessToken = jsonResponse.accessToken;
        String refreshToken = jsonResponse.refreshToken;
        LocalStorage.saveToken(accessToken);
        LocalStorage.saveXrefreshToken(refreshToken);
        FlutterSessionJwt.saveToken(refreshToken);
       
        // Decode the JWT token with the awesome package {JWT Decoder}
        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);

        // Access the payload
        if (decodedToken != null) {
          log("Token payload: $decodedToken");
          String userId = decodedToken['_id'];
          int expDate = decodedToken['exp'];
          String dwellerKind = decodedToken['dwellerKind'] ?? 'non';
          LocalStorage.saveDwellerType(dwellerKind);
          LocalStorage.saveTokenExpDate(expDate);
          LocalStorage.saveUserID(userId);
          LocalStorage.saveUserEmail(email);
        } else {
          log("Failed to decode JWT token.");
        }

        // Void callback
        onSuccess();
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkPurpleColor,
          message: "login successful"
        );
      
      }
      
      else {
        isLoading.value = false;
        //debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.statusMessage}');
        return baseService.showErrorMessage(context: context, httpStatusCode: res.statusCode!);
      }
    }

    on FormatException catch(e, stackTrace){
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (fmt)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
    on Exception catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (exc)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
  }


  //sent OTP to user email (upon account creation)
  Future<void> sendEmailOTPEndpoint({
    required BuildContext context,
    required String email,
    required String firstName,
    required String lastName,
    required Widget nextPage,
  }) async {
    isLoading.value = true;
    try {

      final body = {
        "email": email,
        "firstname": firstName,
        "lastname": lastName,
        //"type": 'email',
      };
      
      diox.Response res = await baseService.httpPostAuth(endPoint: "auth/sendVerification", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.data}');
        
        //decode response from the server
        /*VerifyEmailResponse jsonResponse = VerifyEmailResponse.fromJson(json.decode(res.body)); 

        String OTP = jsonResponse.otp;
        String refreshToken = jsonResponse.refreshToken;*/

        //otpTextController = OTP;
        //log(otpTextController);

        getx.Get.to(() =>  nextPage);
        
      } 
      
      else {
        isLoading.value = false;
        debugPrint('this is response body ==>${res.data}');
        debugPrint('this is response status ==>${res.statusCode}');
        //debugPrint('this is response reason ==> ${res.reasonPhrase}');
        return baseService.showErrorMessage(context: context, httpStatusCode: res.statusCode!);
      }
    }
    on FormatException catch(e, stackTrace){
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (fmt)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
    on Exception catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (exc)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
  }



  //verify email with the given OTP 
  Future<void> veryEmailEndpoint({
    required BuildContext context,
    required String otp,
    required String email,
    required String firstName,
    required String lastName,
    required VoidCallback onSuccess,
  }) async {
    isLoading.value = true;
    try {

      final body = {
        'code': otp,
        "email": email,
        "firstname": firstName,
        "lastname": lastName,
      };
      
      diox.Response res = await baseService.httpPostAuth(endPoint: "auth/verifyAccount", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.data}');
        
        //decode response from the server
        onSuccess();
        
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response body ==>${res.data}');
        debugPrint('this is response status ==>${res.statusCode}');
        //debugPrint('this is response reason ==> ${res.reasonPhrase}');
        return baseService.showErrorMessage(context: context, httpStatusCode: res.statusCode!);
      }
  
    }
    on FormatException catch(e, stackTrace){
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (fmt)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
    on Exception catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (exc)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
  }


  
  //forgot password 
  Future<void> forgotPasswordEndpoint({
    required BuildContext context,
    required String email,
    required Widget nextPage,
  }) async {
    isLoading.value = true;
    try {

      final body = {
        'email': email,
      };
      
      diox.Response res = await baseService.httpPostAuth(endPoint: "auth/forgotPassword", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.data}');
        
        //decode response from the server
        getx.Get.to(() =>  nextPage);
        
      } 
      
      else {
        isLoading.value = false;
        debugPrint('this is response body ==>${res.data}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.statusMessage}');
        return baseService.showErrorMessage(context: context, httpStatusCode: res.statusCode!);
      }

    }
    on FormatException catch(e, stackTrace){
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (fmt)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
    on Exception catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (exc)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
  }



  //reset password
  Future<void> resetPasswordEndpoint({
    required BuildContext context,
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
    required VoidCallback onSuccess,
  }) async {
    isLoading.value = true;
    try {

      final body = {
        'email': email,
        'code': otp,
        'password': password,
        'passwordConfirmation': confirmPassword,
      };
      
      diox.Response res = await baseService.httpPostAuth(endPoint: "auth/resetPassowrd", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.data}');
        
        //decode response from the server
        onSuccess();
        
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response body ==>${res.data}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.data}');
        return baseService.showErrorMessage(context: context, httpStatusCode: res.statusCode!);
      }
    }
    on FormatException catch(e, stackTrace){
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (fmt)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
    on Exception catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (exc)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
  }


  
  //change password
  Future<void> changeInAppPasswordEndpoint({
    required BuildContext context,
    required String old_password,
    required String new_password,
    required String confirmPassword,
    required VoidCallback onSuccess,
  }) async {
    isLoading.value = true;
    try {

      final body = {
        "oldPassword": old_password,
        "newPassword": new_password,
        "passwordNewConfirmation": confirmPassword
      };
      
      http.Response res = await baseService.httpPost(endPoint: "users/me/password", body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        
        //decode response from the server
        onSuccess();
        
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        return baseService.showErrorMessage(context: context, httpStatusCode: res.statusCode);
      }
    }
    on FormatException catch(e, stackTrace){
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (fmt)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
    on Exception catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (exc)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
  }



  //logout (delete request)
  Future<void> logoutEndpoint({
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {
    isLoading.value = true;
    try {
      
      http.Response res = await baseService.httpDelete(endPoint: "auth/logout",);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        
        //decode response from the server
        onSuccess();
        
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        return baseService.showErrorMessage(context: context, httpStatusCode: res.statusCode);
      }
    }
    on FormatException catch(e, stackTrace){
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (fmt)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
    on Exception catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      showMessagePopup(
        title: 'Error (exc)',
        message: "$e",
        buttonText: 'Dismiss',
        context: context
      );
    }
  }


}