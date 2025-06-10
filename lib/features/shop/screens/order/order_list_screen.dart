import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/formatters/formatter.dart';
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

    Color statusColor(String status) {
      switch (status.toLowerCase()) {
        case 'done':
        case 'đã giao':
          return Colors.green;
        case 'cancelled':
        case 'đã huỷ':
          return Colors.red;
        case 'processing':
          return Colors.yellow;
        default:
          return Colors.blueGrey;
      }
    }

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
          padding: const EdgeInsets.all(16),
          itemCount: orderController.orders.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final order = orderController.orders[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center, // Đảm bảo icon view ở giữa chiều dọc
                  children: [
                    // Thông tin đơn hàng bên trái
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order ID: ${order.id}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          if (order.address != null)
                            Text('Name: ${order.address!.name}', style: const TextStyle(fontSize: 15)),
                          const SizedBox(height: 4),
                          Text(
                            'Total: ${TFormatter.formatCurrency(order.totalAmount)}',
                            style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.indigo),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Text(
                                'Status: ',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: statusColor(order.status.name).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  order.status.name,
                                  style: TextStyle(
                                    color: statusColor(order.status.name),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Date: ${TFormatter.formatDate(order.orderDate)}',
                            style: const TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    // Icon View nằm ở giữa bên phải và to hơn
                    Container(
                      alignment: Alignment.center,
                      child: IconButton(
                        iconSize: 40, // tăng kích thước icon
                        icon: Icon(Icons.receipt_long, color: TColors.primary),
                        tooltip: 'View order details',
                        onPressed: () {
                          Get.toNamed('/order-detail', arguments: order);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const OrderFormScreen()),
        child: const Icon(Icons.add, color: TColors.primary),
        tooltip: 'Add Order',
      ),
    );
  }
}