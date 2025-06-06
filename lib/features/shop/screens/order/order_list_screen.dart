import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/order/order_controller.dart';
import 'order_form_screen.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<OrderController>()) {
      Get.put(OrderController());
    }
    final orderController = OrderController.to;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Orders'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
          tooltip: 'Back',
        ),
      ),
      body: Obx(() {
        if (orderController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (orderController.orders.isEmpty) {
          return const Center(child: Text('No orders found.'));
        }
        return ListView.separated(
          itemCount: orderController.orders.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final order = orderController.orders[index];
            return ListTile(
              title: Text('User: ${order.userId}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total: \$${order.totalAmount.toStringAsFixed(2)}'),
                  Text('Status: ${order.status.name}'),
                  Text('Date: ${order.orderDate.toLocal()}'),
                ],
              ),
              isThreeLine: true,
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const OrderFormScreen()),
        child: const Icon(Icons.add),
        tooltip: 'Add Order',
      ),
    );
  }
}