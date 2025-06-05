import 'package:admin_blinkiy/lib/data/repositories/authentication/authentication_repository.dart';
import 'package:admin_blinkiy/lib/features/authentication/controllers/user_controller.dart';
import 'package:admin_blinkiy/utils/local_storage/storage_utility.dart';
import 'package:admin_blinkiy/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../personalization/models/user_model.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final hidePassword = true.obs;
  final rememeberMe = false.obs;
  final localStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onInit(){
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// handle email and password sign in process
  Future<void> emailAndPasswordSignIn() async {
    try{
      TFullScreenLoader.openLoadingDialog('Registeing admin account', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }
      // validate form
      if(!loginFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      // save data if remember me is checked
      if(rememeberMe.value){
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // login user using email and password authentication
      await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // fetch user details and ssign to USerController
      final user = await UserController.instance.fetchUserDetails();

      TFullScreenLoader.stopLoading();

      // if user is not admin, logout and return
      if (user.role != AppRole.admin){
        await AuthenticationRepository.instance.logout();
        TLoaders.errorSnackBar(title: 'Access Denied', message: 'You do not have permission to access this area.');
      }
      else {
        AuthenticationRepository.instance.screenRedirect();
      }

    } catch (e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh shit', message: e.toString());
    }
  }

  /// handles registration of admin user
  Future<void> registerAdmin() async {
    try{
      TFullScreenLoader.openLoadingDialog('Registeing admin account', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      // register user using email and password authentication
      await AuthenticationRepository.instance.registerWithEmailAndPassword(TTexts.adminEmail, TTexts.adminPassword);

      // create admin record in firebase
      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(
          UserModel(
            id: AuthenticationRepository.instance.authUser!.uid,
            firstName: 'Admin',
            lastName: 'Blinkiy',
            email: TTexts.adminEmail,
            role: AppRole.admin,
            createdAt: DateTime.now(),
          )
      );
      TFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();

    } catch (e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh shit', message: e.toString());
    }
  }
}