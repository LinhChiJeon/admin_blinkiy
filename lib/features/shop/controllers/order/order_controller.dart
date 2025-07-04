
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
  RxList<double> weeklySales = RxList.generate(7, (index) => 0.0);
  RxList<bool> showRevenue = RxList.generate(7, (index) => false);

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
      calculateWeeklySales(); // Tính toán doanh thu hàng tuần
    } catch (e, stackTrace) {
      // Add logging to see the actual error in the console
      print('Error fetching orders: $e');
      print('Stack trace: $stackTrace');
      Get.snackbar('Error', 'Failed to load orders. Please try again.');
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

  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('Orders')
          .doc(orderId)
          .update({'Status': newStatus.name});
      await fetchOrders(); // Refresh list
    } catch (e) {
      print('Error updating order status: $e');
      Get.snackbar('Error', 'Failed to update order status.');
    }
  }

  // Tính toán doanh thu hàng tuần từ các đơn hàng trong 7 ngày gần nhất
  void calculateWeeklySales() {
    // Lấy ngày hiện tại
    DateTime now = DateTime.now();

    // Khởi tạo mảng doanh thu mỗi ngày (7 ngày gần nhất)
    List<double> sales = List.generate(7, (index) => 0.0);

    // Lặp qua các đơn hàng để tính doanh thu mỗi ngày
    for (var order in orders) {
      if (order.orderDate.isAfter(now.subtract(Duration(days: 7)))) {
        int dayIndex = now.difference(order.orderDate).inDays; // Tính toán khoảng cách ngày
        if (dayIndex >= 0 && dayIndex < 7) {
          sales[6 - dayIndex] += order.totalAmount; // Cộng doanh thu cho ngày tương ứng
        }
      }
    }

    weeklySales.assignAll(sales); // Cập nhật doanh thu hàng tuần
  }
  // Hàm để thay đổi trạng thái hiển thị doanh thu của cột khi nhấn vào cột
  void toggleShowRevenue(int index) {
    showRevenue[index] = !showRevenue[index]; // Thay đổi trạng thái hiển thị doanh thu
    update(); // Cập nhật giao diện
  }
}

