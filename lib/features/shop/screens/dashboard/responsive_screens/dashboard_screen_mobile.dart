import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/formatters/formatter.dart';
import '../../../controllers/order/order_controller.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_type_card.dart';
import '../widgets/dashboard_chart_card.dart';

class DashboardScreenMobile extends StatelessWidget {
  const DashboardScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<OrderController>()) {
      Get.put(OrderController());
    }
    final orderController = OrderController.to;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          children: [
            const DashboardHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Obx(() => DashboardTypeCard(
                    icon: Icons.monetization_on,
                    iconBgColor: const Color(0xFF4563FF).withOpacity(0.1),
                    iconColor: const Color(0xFF4563FF),
                    title: "Sales total",
                    value: TFormatter.formatCurrency(orderController.salesTotal.value), // Use formatter here
                    percent: 100,
                    compareText: "Compared to 2024",
                  )),
                  const SizedBox(height: 14),
                  Obx(() => DashboardTypeCard(
                    icon: Icons.receipt_long,
                    iconBgColor: const Color(0xFF05C46B).withOpacity(0.10),
                    iconColor: const Color(0xFF05C46B),
                    title: "Average Order Value",
                    value: TFormatter.formatCurrency(orderController.averageOrderValue.value),
                    percent: 100,
                    compareText: "Compared to 2024",
                  )),
                  const SizedBox(height: 14),
                  Obx(() => DashboardTypeCard(
                    icon: Icons.shopping_bag_rounded,
                    iconBgColor: const Color(0xFF9C6BFF).withOpacity(0.11),
                    iconColor: const Color(0xFF9C6BFF),
                    title: "Total Orders",
                    value: orderController.orderCount.value.toString(),
                    percent: 100,
                    compareText: "Compared to 2024",
                  )),
                  const SizedBox(height: 14),
                  DashboardTypeCard(
                    icon: Icons.person_outline,
                    iconBgColor: const Color(0xFFFFD6B5).withOpacity(0.18),
                    iconColor: const Color(0xFFFF8C48),
                    title: "Sold Products",
                    value: "40",
                    percent: 100,
                    compareText: "Compared to 2024",
                  ),
                  const SizedBox(height: 14),
                  const DashboardChartCard(), // Biểu đồ doanh thu hàng tuần
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
