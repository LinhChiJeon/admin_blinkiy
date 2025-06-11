// In lib/features/shop/screens/customer/all_customers/customer.dart

import 'package:flutter/material.dart';

import '../../../shared/widgets/main_layout.dart';
import 'order_list_screen.dart';


class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      selectedIndex: 4,
      title: 'Blinkiy Admin',
      child: OrderListScreen(),
    );
  }
}