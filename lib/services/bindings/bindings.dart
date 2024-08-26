import 'package:dweller/services/repository/chat_service/socket_service.dart';
import 'package:get/get.dart';




class MyBindings implements Bindings{


  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SocketService(), fenix: true);
  }
  
}