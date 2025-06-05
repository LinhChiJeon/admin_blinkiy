import 'package:flutter/material.dart';

class ProductBasicInfoForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descController;

  const ProductBasicInfoForm({
    super.key,
    required this.titleController,
    required this.descController,
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
                Icon(Icons.info_outline, size: 22, color: Color(0xFF4F6AF6)),
                SizedBox(width: 8),
                Text(
                  "Basic Information",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Product Title",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.title),
                fillColor: Color(0xFFF7F8FB),
                filled: true,
              ),
              validator: (v) => v == null || v.trim().isEmpty ? "Please enter product title" : null,
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: descController,
              minLines: 4,
              maxLines: 12,
              decoration: InputDecoration(
                labelText: "Product Description",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.edit),
                fillColor: Color(0xFFF7F8FB),
                filled: true,
              ),
            ),
            // TODO: Nếu muốn tích hợp rich text editor, bạn có thể thay bằng widget phù hợp như flutter_quill/editor
          ],
        ),
      ),
    );
  }
}