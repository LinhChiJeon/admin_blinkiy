// lib/features/shop/screens/order/orders_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/order/order_controller.dart';
import '../../models/order_model.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<OrderController>()) {
      Get.put(OrderController());
    }
    final controller = OrderController.to;

    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.orders.isEmpty) {
          return const Center(child: Text('No orders found.'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.orders.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final order = controller.orders[index];
            return Card(
              child: ListTile(
                title: Text('Order #${order.id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User: ${order.userId}'),
                    Text('Total: \$${order.totalAmount.toStringAsFixed(2)}'),
                    Text('Payment: ${order.paymentMethod}'),
                    Text('Shipping: ${order.address?.street ?? ''}'),
                    Text('Products: ${order.items.length} items'),                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}