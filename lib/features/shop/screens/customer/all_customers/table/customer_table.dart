import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../lib/features/authentication/controllers/user_controller.dart';
import '../../../../../../utils/constants/colors.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        itemCount: customers.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final user = customers[index];
          return Card(
            elevation: 2.5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
              child: Row(
                children: [
                  // Avatar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: user.profilePicture.isNotEmpty
                        ? Image.network(
                      user.profilePicture,
                      width: 54,
                      height: 54,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 54,
                        height: 54,
                        color: Colors.grey[300],
                        alignment: Alignment.center,
                        child: const Icon(Icons.person, color: TColors.primary, size: 32),
                      ),
                    )
                        : Container(
                      width: 54,
                      height: 54,
                      color: Colors.pink.shade100,
                      alignment: Alignment.center,
                      child: Icon(Icons.person, color: TColors.primary, size: 32),
                    ),
                  ),
                  const SizedBox(width: 18),
                  // Thông tin khách hàng
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullName,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, letterSpacing: 0.1),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(Icons.email, size: 15, color: Colors.grey.shade400),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                user.email,
                                style: const TextStyle(fontSize: 13, color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.phone, size: 15, color: Colors.grey.shade400),
                            const SizedBox(width: 5),
                            Text(
                              user.formattedPhoneNo,
                              style: const TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Nút edit/xóa
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_rounded, color: Color(0xFF2979FF), size: 28),
                        tooltip: 'Edit',
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Delete',
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              title: const Text('Confirm Delete'),
                              content: const Text('Are you sure you want to delete this customer?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: TColors.primary,
                                  ),
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: const Text('Confirm'),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true && user.id != null) {
                            await controller.deleteUser(user.id!);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}