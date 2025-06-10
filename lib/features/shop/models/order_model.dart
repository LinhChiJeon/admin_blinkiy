// order_model.dart
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

  factory OrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() == null) return OrderModel.empty();
    final data = doc.data()!;

    DateTime? parseDate(dynamic dateValue) {
      if (dateValue == null) return null;
      if (dateValue is Timestamp) return dateValue.toDate();
      if (dateValue is String && dateValue.isNotEmpty) return DateTime.tryParse(dateValue);
      return null;
    }

    return OrderModel(
      id: doc.id,
      userId: data['UserId'] as String? ?? '',
      status: OrderStatus.values.firstWhere(
            (e) => e.name == (data['Status'] as String? ?? ''),
        orElse: () => OrderStatus.pending,
      ),
      totalAmount: (data['TotalAmount'] is num)
          ? (data['TotalAmount'] as num).toDouble()
          : double.tryParse(data['TotalAmount']?.toString() ?? '0.0') ?? 0.0,
      orderDate: parseDate(data['OrderDate']) ?? DateTime.now(),
      deliveryDate: parseDate(data['DeliveryDate']),
      paymentMethod: data['PaymentMethod'] as String? ?? '',
      address: data['Address'] is Map
          ? AddressModel.fromMap(Map<String, dynamic>.from(data['Address']))
          : null,
      items: (data['Items'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map((e) => CartItemModel.fromJson(e))
          .toList(),
    );
  }
}