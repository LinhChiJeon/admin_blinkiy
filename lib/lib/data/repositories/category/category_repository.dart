import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../features/shop/models/category_model.dart';
import '../../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //firebase firestore instance
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection("Categories").get();
      final result = snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
      return result;

    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    catch (e){
      throw 'Something went wrong. Please try again';
    }

  }

  Future<void> addCategory(CategoryModel category) async {
    final docRef = await _db.collection("Categories").add(category.toMap());
    // Cập nhật lại id cho document vừa tạo
    await _db.collection("Categories").doc(docRef.id).update({'Id': docRef.id});
  }

  Future<void> updateCategory(String categoryId, CategoryModel category) async {
    try {
      await _db.collection("Categories").doc(categoryId).update(category.toMap());
    } catch (e) {
      throw 'Failed to update category: $e';
    }
  }

  // lib/lib/data/repositories/category/category_repository.dart
  Future<void> deleteCategory(String categoryId) async {
    try {
      await _db.collection("Categories").doc(categoryId).delete();
    } catch (e) {
      throw 'Failed to delete category: $e';
    }
  }
}