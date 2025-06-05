import 'package:flutter/material.dart';
import '../../../../models/user_model.dart';
import 'customer_table_source.dart';

class CustomerTable extends StatelessWidget {
  const CustomerTable({super.key});

  @override
  Widget build(BuildContext context) {
    final customers = CustomerTableSource.mockCustomers;
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
                tooltip: 'Chỉnh sửa',
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent, size: 22),
                onPressed: () {},
                tooltip: 'Xóa',
              ),
            ],
          ),
        );
      },
    );
  }
}