// In lib/features/shop/screens/customer/all_customers/responsive_screens/customer_screen_mobile.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../lib/features/authentication/controllers/user_controller.dart';
import '../table/customer_table.dart';

class CustomerScreenMobile extends StatelessWidget {
  const CustomerScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    // Register controller if not already registered
    if (!Get.isRegistered<UserController>()) {
      Get.put(UserController());
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Customers')),
      body: const Padding(
        padding: EdgeInsets.all(12.0),
        child: CustomerTable(),
      ),
    );
  }
}