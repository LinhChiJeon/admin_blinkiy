// lib/data/repositories/order/order_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../features/shop/models/order_model.dart';

class OrderRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> getAllOrders() async {
    final snapshot = await _db.collection('Orders').get();
    print('Fetched documents: ${snapshot.docs.length}');

    final List<OrderModel> orders = [];
    for (final doc in snapshot.docs) {
      try {
        orders.add(OrderModel.fromSnapshot(doc));
      } catch (e) {
        // Log the error for the specific document that failed
        print('Error parsing order with ID: ${doc.id}. Skipping. Error: $e');
      }
    }


    print('Successfully parsed orders: ${orders.length}');
    return orders;
  }

  Future<void> createOrder(OrderModel order) async {
    await _db.collection('Orders').add(order.toJson());
  }
}