import 'package:flutter/material.dart';
import '../../../../models/category_model.dart';
import 'category_table_source.dart';

class CategoryTable extends StatelessWidget {
  const CategoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    final mockCategories = CategoryTableSource.mockCategories;

    return ListView.separated(
      itemCount: mockCategories.length,
      separatorBuilder: (_, __) => const Divider(height: 0, thickness: 0.5, color: Color(0xFFEEEEEE)),
      itemBuilder: (context, index) {
        final cat = mockCategories[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: (cat.image != null && cat.image!.isNotEmpty)
                    ? Image.network(
                  cat.image!,
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 44,
                    height: 44,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 28),
                  ),
                )
                    : Container(
                  width: 44,
                  height: 44,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Icon(Icons.category, color: Colors.white, size: 28),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  cat.name,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                cat.isFeatured ? Icons.star_rounded : Icons.star_border_rounded,
                color: cat.isFeatured ? Colors.orange : Colors.grey,
                size: 22,
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blueAccent, size: 22),
                onPressed: () {
                  // TODO: Chuyển sang màn sửa category
                },
                tooltip: 'Chỉnh sửa',
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent, size: 22),
                onPressed: () {
                  // TODO: Xóa category
                },
                tooltip: 'Xóa',
              ),
            ],
          ),
        );
      },
    );
  }
}