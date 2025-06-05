// In lib/features/shop/screens/customer/all_customers/table/customer_table.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../lib/features/authentication/controllers/user_controller.dart';
import '../../../../models/user_model.dart';

class CustomerTable extends StatelessWidget {
  const CustomerTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      final customers = controller.allUsers;
      if (customers.isEmpty) {
        return const Center(child: Text('No customers found.'));
      }
      return ListView.separated(
        itemCount: customers.length,
        separatorBuilder: (_, __) => const Divider(height: 0, thickness: 0.5, color: Color(0xFFEEEEEE)),
        itemBuilder: (context, index) {
          final user = customers[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.network(
                    user.profilePicture,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 44,
                      height: 44,
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: const Icon(Icons.person, color: Colors.white, size: 28),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.fullName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      Text(user.email, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                      Text(user.formattedPhoneNo, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blueAccent, size: 22),
                  onPressed: () {},
                  tooltip: 'Edit',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent, size: 22),
                  onPressed: () {},
                  tooltip: 'Delete',
                ),
              ],
            ),
          );
        },
      );
    });
  }
}