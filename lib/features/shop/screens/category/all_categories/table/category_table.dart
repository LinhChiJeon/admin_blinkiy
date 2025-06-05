import 'package:flutter/material.dart';
import 'category_table_source.dart';

class CategoryTable extends StatelessWidget {
  const CategoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    final mockCategories = CategoryTableSource.mockCategories;

    return ListView.separated(
      itemCount: mockCategories.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final cat = mockCategories[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(cat.image, width: 40, height: 40, fit: BoxFit.cover),
          ),
          title: Text(cat.name, maxLines: 2, overflow: TextOverflow.ellipsis),
          subtitle: Row(
            children: [
              if (cat.parent != null)
                Text('Parent: ${cat.parent!}   ', style: const TextStyle(fontSize: 12)),
              Icon(
                cat.featured ? Icons.star : Icons.star_border,
                color: cat.featured ? Colors.orange : Colors.grey,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(cat.date, style: const TextStyle(fontSize: 12)),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  // TODO: Chuyển sang màn sửa category
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // TODO: Xóa category
                },
              ),
            ],
          ),
          onTap: () {
            // TODO: chọn hoặc xem chi tiết
          },
        );
      },
    );
  }
}