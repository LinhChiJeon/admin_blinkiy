
// lib/features/shop/controllers/order/order_controller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../lib/data/repositories/order/order_repository.dart';
import '../../models/order_model.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();

  RxBool isLoading = true.obs;
  RxList<OrderModel> orders = <OrderModel>[].obs;
  RxInt orderCount = 0.obs;
  RxDouble salesTotal = 0.0.obs;
  RxDouble averageOrderValue = 0.0.obs;
  final _orderRepository = OrderRepository();

  @override
  void onInit() {
    fetchOrders();
    fetchOrderCount();
    fetchSalesTotal();
    fetchAverageOrderValue();
    super.onInit();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      final fetched = await _orderRepository.getAllOrders();
      orders.assignAll(fetched);
    } catch (e) {
      // Handle error, e.g., show snackbar
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createOrder(OrderModel order) async {
    try {
      isLoading.value = true;
      await _orderRepository.createOrder(order);
      await fetchOrders();
      await fetchOrderCount();
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOrderCount() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('Orders').get();
      print('Order docs: ${snapshot.docs.length}'); // Debug print
      orderCount.value = snapshot.size;
    } catch (e) {
      orderCount.value = 0;
      print('Error fetching order count: $e');
    }
  }

  Future<void> fetchSalesTotal() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('Orders').get();
      double total = 0.0;
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final amount = double.tryParse((data['TotalAmount'] ?? 0).toString()) ?? 0.0;
        total += amount;
      }
      salesTotal.value = total;
    } catch (e) {
      salesTotal.value = 0.0;
    }
  }

  Future<void> fetchAverageOrderValue() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('Orders').get();
      double total = 0.0;
      int count = snapshot.size;
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final amount = double.tryParse((data['TotalAmount'] ?? 0).toString()) ?? 0.0;
        total += amount;
      }
      averageOrderValue.value = count > 0 ? total / count : 0.0;
    } catch (e) {
      averageOrderValue.value = 0.0;
    }
  }
}