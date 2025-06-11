import 'package:admin_blinkiy/lib/data/repositories/user/user_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../utils/popups/loaders.dart';
import '../../personalization/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRepository = Get.put(UserRepository());

  RxList<UserModel> allUsers = <UserModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchAllUsers();
    super.onInit();
  }

  Future<void> fetchAllUsers() async {
    try {
      isLoading.value = true;
      final users = await userRepository.fetchAllUsers();
      allUsers.assignAll(users);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<UserModel> fetchUserDetails () async{
    try {
      final user = await userRepository.fetchAdminDetails();
      return user;
    } catch (e){
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
      return UserModel.empty();
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('Users').doc(userId).delete();
      allUsers.removeWhere((user) => user.id == userId);
      Get.snackbar('Success', 'User deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete user');
    }
  }

}