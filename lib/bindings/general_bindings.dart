import 'package:admin_blinkiy/utils/helpers/network_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../features/authentication/controllers/user_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
  }
}