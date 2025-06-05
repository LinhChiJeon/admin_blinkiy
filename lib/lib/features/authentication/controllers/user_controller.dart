import 'package:admin_blinkiy/lib/data/repositories/user/user_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../utils/popups/loaders.dart';
import '../../personalization/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRepository = Get.put(UserRepository());

  Future<UserModel> fetchUserDetails () async{
    try {
      final user = await userRepository.fetchAdminDetails();
      return user;
    } catch (e){
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
      return UserModel.empty();
    }
  }
}