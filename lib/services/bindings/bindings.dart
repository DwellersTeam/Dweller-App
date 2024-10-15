import 'package:dweller/services/repository/chat_service/socket_service.dart';
import 'package:dweller/services/repository/notification_service/push_notifications.dart';
import 'package:get/get.dart';




class MyBindings implements Bindings{


  @override
  void dependencies() {
    // TODO: implement dependencies
    //Get.put<SocketService>(SocketService(), permanent: true);
    Get.lazyPut(() => SocketService(), fenix: true);
    Get.put(PushNotificationController());
  }
  
}