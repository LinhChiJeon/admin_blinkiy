import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Responsive: padding nhỏ cho mobile
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumb
          Row(
            children: [
              Icon(Icons.dashboard, color: TColors.primary),
              SizedBox(width: 8),
              Text('Dashboard', style: TextStyle(color: TColors.primary, fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 16),
          // Thống kê tổng quan
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _StatCard(label: "Sales total", value: "\$21145.00", icon: Icons.attach_money, color: Colors.blue),
                SizedBox(width: 12),
                _StatCard(label: "Avg Order Value", value: "\$704.83", icon: Icons.receipt, color: Colors.green),
                SizedBox(width: 12),
                _StatCard(label: "Total Orders", value: "30", icon: Icons.local_shipping, color: Colors.purple),
                SizedBox(width: 12),
                _StatCard(label: "Sold Products", value: "40", icon: Icons.check_circle, color: Colors.orange),
              ],
            ),
          ),
          SizedBox(height: 22),
          // Biểu đồ, bảng trạng thái (placeholder)
          Text('Weekly Sales', style: TextStyle(color: TColors.primary, fontWeight: FontWeight.w600, fontSize: 17)),
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 16),
            height: 160,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: Center(child: Text('Biểu đồ sales (chart)')),
          ),
          Text('Orders Status', style: TextStyle(color: TColors.primary, fontWeight: FontWeight.w600, fontSize: 17)),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 160,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: Center(child: Text('Chart trạng thái đơn hàng')),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: 120,
        height: 80,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 26),
            SizedBox(height: 6),
            Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[700]), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}