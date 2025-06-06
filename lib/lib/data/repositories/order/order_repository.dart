// lib/data/repositories/order/order_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../features/shop/models/order_model.dart';

class OrderRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> getAllOrders() async {
    final snapshot = await _db.collection('Orders').get();
    print('Fetched orders: ${snapshot.docs.length}');
    return snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
  }

  Future<void> createOrder(OrderModel order) async {
    await _db.collection('Orders').add(order.toJson());
  }
}