import 'package:flutter/material.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_type_card.dart';
import '../widgets/dashboard_chart_card.dart';

class DashboardScreenMobile extends StatelessWidget {
  const DashboardScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
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
                  // Các card thống kê
                  DashboardTypeCard(
                    icon: Icons.monetization_on,
                    iconBgColor: Color(0xFF4563FF).withOpacity(0.1),
                    iconColor: Color(0xFF4563FF),
                    title: "Sales total",
                    value: "\$21145.00",
                    percent: 100,
                    compareText: "Compared to 2024",
                  ),
                  const SizedBox(height: 14),
                  DashboardTypeCard(
                    icon: Icons.receipt_long,
                    iconBgColor: Color(0xFF05C46B).withOpacity(0.10),
                    iconColor: Color(0xFF05C46B),
                    title: "Average Order Value",
                    value: "\$704.83",
                    percent: 100,
                    compareText: "Compared to 2024",
                  ),
                  const SizedBox(height: 14),
                  DashboardTypeCard(
                    icon: Icons.shopping_bag_rounded,
                    iconBgColor: Color(0xFF9C6BFF).withOpacity(0.11),
                    iconColor: Color(0xFF9C6BFF),
                    title: "Total Orders",
                    value: "30",
                    percent: 100,
                    compareText: "Compared to 2024",
                  ),
                  const SizedBox(height: 14),
                  DashboardTypeCard(
                    icon: Icons.person_outline,
                    iconBgColor: Color(0xFFFFD6B5).withOpacity(0.18),
                    iconColor: Color(0xFFFF8C48),
                    title: "Sold Products",
                    value: "40",
                    percent: 100,
                    compareText: "Compared to 2024",
                  ),
                  const SizedBox(height: 14),
                  // Card biểu đồ
                  DashboardChartCard(),
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