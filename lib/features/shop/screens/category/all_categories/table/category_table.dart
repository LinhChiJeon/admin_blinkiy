// lib/features/shop/screens/category/all_categories/table/category_table.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/category/category_controller.dart';

class CategoryTable extends StatelessWidget {
  const CategoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.to;

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      final categories = controller.filteredItems;
      if (categories.isEmpty) {
        return const Center(child: Text('No categories found.'));
      }
      return ListView.separated(
        itemCount: categories.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 40,
                height: 40,
                color: Colors.grey[200],
                child: const Icon(Icons.category, size: 28, color: Colors.blueGrey),
              ),
            ),
            title: Text(cat.name, maxLines: 2, overflow: TextOverflow.ellipsis),
            subtitle: Row(
              children: [
                if (cat.parentId.isNotEmpty)
                  Text('Parent: ${cat.parentId}   ', style: const TextStyle(fontSize: 12)),
                Icon(
                  cat.isFeatured ? Icons.star : Icons.star_border,
                  color: cat.isFeatured ? Colors.orange : Colors.grey,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(cat.formattedDate, style: const TextStyle(fontSize: 12)),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    // Navigate to edit
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Delete logic
                  },
                ),
              ],
            ),
            onTap: () {
              // View details
            },
          );
        },
      );
    });
  }
}