import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../controllers/category/category_controller.dart';
import '../../edit_category/edit_category_screen.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                // View details
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: Row(
                  children: [
                    // Hình và icon
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 48,
                        height: 48,
                        color: Colors.grey[100],
                        child: cat.image.isNotEmpty
                            ? Image.network(cat.image, fit: BoxFit.cover)
                            : Icon(Icons.category, size: 32, color: TColors.primary),
                      ),
                    ),
                    const SizedBox(width: 18),
                    // Thông tin chính
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cat.name,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, letterSpacing: 0.1),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              if (cat.parentId.isNotEmpty)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.indigo.withOpacity(0.07),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    'Parent: ${cat.parentId}',
                                    style: const TextStyle(fontSize: 12, color: Colors.indigo),
                                  ),
                                ),
                              Icon(
                                cat.isFeatured ? Icons.star_rounded : Icons.star_border_rounded,
                                color: cat.isFeatured ? Colors.amber : Colors.grey,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                cat.formattedDate,
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Nút chỉnh sửa/xóa
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_rounded, color: Color(0xFF2979FF)),
                          tooltip: 'Edit',
                          onPressed: () {
                            final category = controller.filteredItems[index];
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => EditCategoryScreen(category: category),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          tooltip: 'Delete',
                          onPressed: () async {
                            final category = controller.filteredItems[index];
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                title: const Text('Confirm Delete'),
                                content: const Text('Are you sure you want to delete this category?'),
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
                            if (result == true) {
                              await controller.deleteCategory(category.id);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}