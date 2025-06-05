import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../features/authentication/screens/admin/admin_home_screen.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // firebase auth instance
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  // Get IsAuthenticated User
  bool get isAuthenticated => _auth.currentUser != null;

  @override
  void onReady(){
    _auth.setPersistence(Persistence.LOCAL);
  }

  void screenRedirect() async{
    final user = _auth.currentUser;
    if(user != null){
      // Get.offAllNamed(Routes.dashboard);
      Get.to(() => const AdminHomeScreen());
    }
    else{
      Get.offAllNamed(Routes.login);
    }
  }

  /// login
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_) {
      throw const TFormatException();
    }
    on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// register
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  /// logout
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(Routes.login);

    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }




}