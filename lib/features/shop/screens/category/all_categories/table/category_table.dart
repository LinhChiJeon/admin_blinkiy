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
    final screenWidth = MediaQuery.of(context).size.width;

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      final categories = controller.filteredItems;
      if (categories.isEmpty) {
        return const Center(child: Text('No categories found.'));
      }
      return ListView.separated(
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.04,
          horizontal: screenWidth * 0.025,
        ),
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(height: screenWidth * 0.03),
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
                padding: EdgeInsets.symmetric(
                  vertical: screenWidth * 0.03,
                  horizontal: screenWidth * 0.025,
                ),
                child: Row(
                  children: [
                    // Hình và icon
                    ClipRRect(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      child: Container(
                        width: screenWidth * 0.12,
                        height: screenWidth * 0.12,
                        color: Colors.grey[100],
                        child: cat.image.isNotEmpty
                            ? Image.network(cat.image, fit: BoxFit.cover)
                            : Icon(Icons.category, size: screenWidth * 0.08, color: TColors.primary),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.045),
                    // Thông tin chính
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cat.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.042,
                              letterSpacing: 0.1,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: screenWidth * 0.015),
                          Row(
                            children: [
                              if (cat.parentId.isNotEmpty)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.indigo.withOpacity(0.07),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.015,
                                    vertical: screenWidth * 0.005,
                                  ),
                                  margin: EdgeInsets.only(right: screenWidth * 0.022),
                                  child: Text(
                                    'Parent: ${cat.parentId}',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                ),
                              Icon(
                                cat.isFeatured ? Icons.star_rounded : Icons.star_border_rounded,
                                color: cat.isFeatured ? Colors.amber : Colors.grey,
                                size: screenWidth * 0.045,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                cat.formattedDate,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.03,
                                  color: Colors.grey,
                                ),
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
                          icon: Icon(Icons.edit_rounded, color: const Color(0xFF2979FF), size: screenWidth * 0.07),
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
                          icon: Icon(Icons.delete, color: Colors.red, size: screenWidth * 0.07),
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