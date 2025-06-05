import 'package:flutter/material.dart';
import '../../../../models/category_model.dart';


class CategorySelector extends StatelessWidget {
  final String? selectedId;
  final List<CategoryModel> categories;
  final ValueChanged<String?> onChanged;

  const CategorySelector({
    super.key,
    required this.selectedId,
    required this.categories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.category_outlined, size: 22, color: Color(0xFF4F6AF6)),
                SizedBox(width: 8),
                Text(
                  "Category",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              isExpanded: true,
              value: selectedId,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              items: categories
                  .map((c) => DropdownMenuItem(
                value: c.id,
                child: Text(c.name),
              ))
                  .toList(),
              onChanged: onChanged,
              validator: (v) => (v == null || v.isEmpty) ? "Please select a category" : null,
            ),
          ],
        ),
      ),
    );
  }
}