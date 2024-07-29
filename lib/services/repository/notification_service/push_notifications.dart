import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dweller/services/controller/main_page/mainpage_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/main/mainpage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart' as getx;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;







class PushNotificationController extends getx.GetxController {

  
  //mainpage host controller
  final controller = getx.Get.put(MainPageController());

  final getx.RxString accessTokenString = ''.obs;

  //get oAuth2.0 access token
  Future<String> getAccessToken() async {

    final accountCredentials = ServiceAccountCredentials.fromJson(
      //File(serviceAccountPath).readAsStringSync(),
      {
        "type": "service_account",
        "project_id": "dwellers-61d22",
        "private_key_id": "ce489f5fcf15dd549c8fd2b4b3fa313ba64f4d37",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCbIT7HHS7xvQd0\nyWCX3ClSU5y6NDhh1sEx/Mu6Sv7aDD4jyT3z6m9bxOaDBvCWoUJm9wRwRxE4L5yt\nGhUOT7MgT8LJcHX10Un4CsjV00lyvltdvLyUolfwOvyzngHt3Q03iTPV8jGduBA/\n+gW3zRyUEAS/UrlVCCZw3u2GRgfK6k0r/6vGxCq1FMgp2f8Z08IAge7evScdX5cF\n9/lwbV+Wp8KQTwVcxiU1ytFfmeEyOw3qxj0enCussop09/CudsOtGESuf0Xs0c12\nqY4hzfN3UQ0l7pql9cTJHfN+oiyhXLfbzieF0H828/MXsUPYIII9Z/UH7BTUgilm\n9Aevw383AgMBAAECggEABR0w9R50rDp3kvWKjicPY6vm+Ep9a1hJkSzMyIztXuHV\ncJeTR8W8OxHAKaSibMzPJBbTmiH1ot0K9Lft5sVg2dlXSg2/jcWDAz7TxRzMiJBW\n8b2ll97MOFqxdvhoBt/pLiIDR/POh+0H+Bv1cUw9O3JVvbrr6i41GjZ3LRyE6D8I\n7ndnw/qu5VlGCHZ8BvR5l6Ky8garLXKu+Vk+43sCedipgVqZoRq0dfZ6TUPi+28H\nwxbqUlTEnHLDQbjWeYOlc/fApt29IdHXFB2UV+0rPz1opln3pkgrrCAl32d3DuYs\n2Oges9WycEzV2gbZm65Xjq82HJZuFIFoNGI3KQf0iQKBgQDbGXbHtagNS0lG6B/v\n8pbNZvDJMQok1gJOav/GjwqNKtWdM9zEhpk30N1aNL7AUVU5Bwr1zLuXB2yPefjO\nrr5Zfug0nHf6vGmPwyAcwB08DEb+RKJYXOsp9PSaaqKC/OSDEPF+yoVSGtO4M4Rm\nhShGDC4bRf/xwGo6RuTcNRzGuQKBgQC1QbapA0Cf/JXXqwEJWrjkPClW4ohjIaQ1\ns8RzBDwFctrQOS7GSuirMnUqamdzqnMb6Sk/tQsvXoyTqHTUlR+QrS+TG4VPJtAN\nIA5V5BaZJ4pHT2vlW9f0jPg7zf1bRtV9Hxztdjmql57R3YQO2YWva/c5OdSYv27h\ns4foNMl9bwKBgQCfKeNw9xUq+yszWIOC8y777jEzZu2gjttEDlTa8KTQonJl7fwN\nxF3f/1oeIr0DxtHrSKN8posMDzedDxVhR+4944RaW+SJAICLEEvutt1F9wFHy6JI\nINAxPaLH3nlKQN7cG93jpsmtOJHfeYVQWKFGKakA5RwmigphZYjyM59A+QKBgQCJ\nfqnDF7aEJiS8jvmgUPOEHqb1Q65WFITuP8m7vfCR6YhW/6mdveE1THdYj5KeSSQ8\nfehObVVov34/3D+TqvNg2h8Gpo+/dR/JdRGq0fTahQX+Bh9AwyTUW8NKCn4wKVF1\nMo7NCyu/XniZlkHAyf0BDxNgk5/TpxPDnl5wJOrbfQKBgGghbzN0cJVYHbel+MDW\nVk0MADDSWmQ83+Fhi2LYICtH36aZ1DMqV7PPMYqeGZkyGKrK94UswPzMBJHmD1CC\nyry+NzTBrwb5N2JCkhuSHTNurPJu2MNSfZutrYWfpOd3LnRIxeuvaPzcsUr1wZxw\n9JK8hxOoOg+NXaRcLBzgAIoZ\n-----END PRIVATE KEY-----\n",
        "client_email": "firebase-adminsdk-pp489@dwellers-61d22.iam.gserviceaccount.com",
        "client_id": "102466481432661226081",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-pp489%40dwellers-61d22.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }
    );

    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final client = http.Client();
    final authClient = await clientViaServiceAccount(accountCredentials, scopes);

    final accessToken = authClient.credentials.accessToken;
    client.close();
    log(accessToken.data);
    accessTokenString.value = accessToken.data;
    return accessToken.data;
  }

  //will use this for future purpose
  Future<void> sendNotification({
    required String targetUserToken,
    required String title,
    required String body,
    required String type,
  }) async {
    try {
      // Replace 'YOUR_SERVER_KEY' with your actual FCM server key
      //String serverKey = 'YOUR_SERVER_KEY';

      // Construct the FCM endpoint URL
      String endpoint = 'https://fcm.googleapis.com/v1/projects/dwellers-61d22/messages:send';

      // Construct the FCM payload to target multiple platforms and a specific device as well
      dynamic payload = {
        "message":{
          "token":targetUserToken,
          "notification":{
            "body": body,
            "title": title,
          }
        },
        //
        /*"data": {
          "story_id": "story_12345"
        },
        "android": {
          "notification": {
            "click_action": "TOP_STORY_ACTIVITY"
          }
        },
        "apns": {
          "payload": {
            "aps": {
              "category" : "NEW_MESSAGE_CATEGORY"
            }
          }
        }*/
        //
      };

      //Send the FCM request
      http.Response res  = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessTokenString.value}', //'key=$serverKey',
          'Accept': '/',
        },
        body: jsonEncode(payload),
      );

      //Check if the request was successful
      if(res.statusCode == 200 || res.statusCode == 201) {
        log('response code:  ${res.statusCode}');
        log('response body:  ${res.body}');
        log('Notification sent successfully to $targetUserToken');
      }
      else {
        print('response status:  ${res.statusCode}');
        print('response body:  ${res.body}');
        print("Failed to send notification to user");
      }

    }


    catch(e, stacktrace) {
      throw Exception("$e || $stacktrace");
    }
  }
  ///////////////////////////////////////////////


  void displayNotification(RemoteMessage message) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Instantiate setting for (Android/iOS)
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher'); //'app_icon'
    const DarwinInitializationSettings iosInitializationSetting = DarwinInitializationSettings(
      requestAlertPermission: true, 
      requestBadgePermission: true, 
      requestSoundPermission: true
    );
  
    //join "Android/iOS" instantiation together
    const InitializationSettings initializationSettings =
      InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: iosInitializationSetting
      );
    
    //Initialize the plugin  (Android/iOS)
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    // Create the notification details for android
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'default_channel',
        'Default Channel',
        channelDescription: 'Default Notification Channel',
        color: AppColor.darkPurpleColor,
        ledColor: Colors.white,
        enableLights: true,
        enableVibration: true,
        playSound: true,
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
        ledOnMs: 1000, // Specify LED on duration in milliseconds
        ledOffMs: 500, 
      );

      // Create the notification details for iOS
      const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
          presentSound: true,
          presentAlert: true
        );
  
      //join both notification details together
      final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      
      if(notification != null && android != null) {

        // Display the notification
        await flutterLocalNotificationsPlugin.show(
          notification.hashCode, 
          notification.title, 
          notification.body, 
          platformChannelSpecifics,
        );

      }

    }

  Future<void> initFCM({
    required Future<void> Function(RemoteMessage) backgroundHandler
  }) async {

  
    //FCM Instance
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    //Get Unique FCM DEVICE TOKEN AND SAVE TO GETSTORAGE()
    String? token = await messaging.getToken();
    //await LocalStorage.saveFCMToken(token!);
    debugPrint("My Device FCMToken: $token"); //save to firebase
    //debugPrint("local storage fcmtoken: ${LocalStorage.getFCMToken()}");

    //grant permission for Android/iOS (Android is always automatic)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');

    //grant permission for iOS
    if (Platform.isIOS) {
      await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }

    //FCM method that listens to foreground notification messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      //you can save to db
      debugPrint('Message data: ${message.data}');
      //display notification
      displayNotification(message);
    });

    //Enable foreground Notifications for iOS
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    //FCM method that listens to background notification messages
    // Enable Background Notification to retrieve any message which caused the application to open from a terminated state
    RemoteMessage? initialMessage = await messaging.getInitialMessage();

    // This handles routing to a secific page when there's a click event on the notification
    void handleMessage(RemoteMessage message) {
      //specify message data types here /
      //home, match & chat
      if (message.data['type'] == 'home') {
        //getx.Get.to(() => const MainPageHost());
        controller.navigateToMainpageAtIndex(index: 0, page: MainPage());
      }
      else if(message.data['type'] == 'search') {
        controller.navigateToMainpageAtIndex(index: 1, page: MainPage());
      }
      else if(message.data['type'] == 'match') {
        controller.navigateToMainpageAtIndex(index: 2, page: MainPage());
      }
      else if(message.data['type'] == 'chat') {
        controller.navigateToMainpageAtIndex(index: 4, page: MainPage());
      }

    }

    if (initialMessage != null) {
      handleMessage(initialMessage);
    }

    // This handles background notifications when the app is not terminated
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    //This handles background notifications when the app is terminated
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    //////////////////////////////////////////////

  }
  
  @override
  void onInit() {
    // TODO: implement onInit
    getAccessToken();
    super.onInit();
  }

}