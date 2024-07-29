import 'dart:io';
import 'package:dweller/services/repository/data_service/local_storage/local_storage.dart';
import 'package:dweller/firebase_options.dart';
import 'package:dweller/services/repository/location_service/location_service.dart';
import 'package:dweller/services/repository/notification_service/push_notifications.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/auth/login/page/login_page.dart';
import 'package:dweller/view/auth/splashscreen/splash_screen_updated.dart';
import 'package:dweller/view/auth/onboarding/screen/onboarding_screen.dart';
import 'package:dweller/view/main/mainpage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:intl/intl.dart';










//to display EURO currency
NumberFormat currency(context) {
  //String os = Platform.operatingSystem;
  //if(Platform.isAndroid)
  Locale locale = Localizations.localeOf(context);
  var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: "EUR");
  //print("CURRENCY SYMBOL: ${format.currencySymbol}");
  //print("CURRENCY NAME: ${format.currencyName}");
  return format;
}

// Define a GlobalKey<NavigatorState> for functional navigation
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

var controller = Get.put(PushNotificationController());
//Top level non-anonymous function for FCM push notifications for background mode
Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message ${message.data}');
  controller.displayNotification(message);
}

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //AppColor.blueColorOpacity, // Set your desired color here
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColor.blackColor, //AppColor.whiteColor,
    ),
  );

  //initialize get_storage
  await GetStorage.init();

  //initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  //FCM Instance
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //Get Unique FCM DEVICE TOKEN AND SAVE TO GETSTORAGE()
  String? token = await messaging.getToken();
  
  await LocalStorage.saveFCMToken(token!);
  await LocalStorage.getToken();
  debugPrint("raw fcm token: $token"); //save to firebase
  debugPrint("jwt token: ${LocalStorage.getToken()}");
  debugPrint("jwt refresh token: ${LocalStorage.getXrefreshToken()}");

  runApp(const MyApp());
}






class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final token = LocalStorage.getXrefreshToken();
  final controller = Get.put(PushNotificationController());
  final locationService = Get.put(LocationService());


  bool isExpiredVal = false;
  //checks if the token is expired
  Future<bool> isTokenExpired() async{
    bool isExpired = await FlutterSessionJwt.isTokenExpired();
    setState(() {
      isExpiredVal = isExpired;
    });
    print("is token expired: $isExpiredVal");
    return isExpired;
  }

  @override
  void initState() {
    super.initState();
    //initialize firebase cloud messaging
    controller.initFCM(backgroundHandler: backgroundHandler);
    isTokenExpired();
  }
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, child) {
        return child!;
      },
      child: GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Dweller',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.blueColor),
          useMaterial3: true,
        ),
        defaultTransition: Transition.rightToLeft,
        
        //check if token is expired here with tenary operators
        home: token == null ? const SplashScreenUpdated(next_screen: OnBoardingPage(),) : isExpiredVal ? const SplashScreenUpdated(next_screen: LoginPage(),) : const SplashScreenUpdated(next_screen: MainPage(),),
      ),
    );
  }
}


