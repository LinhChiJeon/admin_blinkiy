import 'package:cloud_firestore/cloud_firestore.dart';

import 'address_model.dart';
import 'cart_item_model.dart';


enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
  returned,
}

class OrderModel {
  String id;
  String userId;
  OrderStatus status;
  double totalAmount;
  DateTime orderDate;
  String paymentMethod;
  AddressModel? address;
  DateTime? deliveryDate;
  List<CartItemModel> items;

  OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    required this.paymentMethod,
    this.address,
    this.deliveryDate,
    required this.items,
  });

  /// Empty Order
  static OrderModel empty() => OrderModel(
    id: '',
    userId: '',
    status: OrderStatus.pending,
    totalAmount: 0.0,
    orderDate: DateTime.now(),
    paymentMethod: '',
    address: null,
    deliveryDate: null,
    items: [],
  );

  /// Convert Order to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'UserId': userId,
      'Status': status.name,
      'TotalAmount': totalAmount,
      'OrderDate': orderDate,
      'PaymentMethod': paymentMethod,
      'Address': address?.toJson(),
      'DeliveryDate': deliveryDate,
      'Items': items.map((e) => e.toJson()).toList(),
    };
  }

  /// Create Order from Firestore DocumentSnapshot
  factory OrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() == null) return OrderModel.empty();
    final data = doc.data()!;
    return OrderModel(
      id: doc.id,
      userId: data['UserId'] ?? '',
      status: OrderStatus.values.firstWhere(
            (e) => e.name == (data['Status'] ?? 'pending'),
        orElse: () => OrderStatus.pending,
      ),
      totalAmount: double.parse((data['TotalAmount'] ?? 0.0).toString()),
      orderDate: (data['OrderDate'] is Timestamp)
          ? (data['OrderDate'] as Timestamp).toDate()
          : DateTime.tryParse(data['OrderDate'] ?? '') ?? DateTime.now(),
      paymentMethod: data['PaymentMethod'] ?? '',
      address: data['Address'] != null
          ? AddressModel.fromMap(Map<String, dynamic>.from(data['Address']))
          : null,
      deliveryDate: data['DeliveryDate'] != null
          ? (data['DeliveryDate'] is Timestamp
          ? (data['DeliveryDate'] as Timestamp).toDate()
          : DateTime.tryParse(data['DeliveryDate']))
          : null,
      items: (data['Items'] as List<dynamic>? ?? [])
          .map((e) => CartItemModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
}