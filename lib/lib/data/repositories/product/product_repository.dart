// lib/data/repositories/product/product_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../../features/shop/models/product_model.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection("Products").get();
      return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await _db.collection("Products").add(product.toJson());
    } catch (e) {
      throw 'Failed to add product: $e';
    }
  }


}