import 'package:get/get.dart';

import '../../../../lib/data/repositories/order/order_repository.dart';
import '../../models/order_model.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();

  RxBool isLoading = true.obs;
  RxList<OrderModel> orders = <OrderModel>[].obs;
  final _orderRepository = OrderRepository();

  @override
  void onInit() {
    fetchOrders();
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
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

}