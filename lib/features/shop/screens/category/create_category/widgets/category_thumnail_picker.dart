import 'package:flutter/material.dart';
import '../../../../../../utils/helpers/cloudinary.dart';

class CategoryThumbnailPicker extends StatelessWidget {
  final String? thumbnail;
  final ValueChanged<String> onChanged;

  const CategoryThumbnailPicker({
    super.key,
    required this.thumbnail,
    required this.onChanged,
  });

  Future<void> _pickAndUpload(BuildContext context) async {
    final url = await uploadImageToCloudinary();
    if (url != null) onChanged(url);
  }

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
                Icon(Icons.image_outlined, size: 22, color: Color(0xFF4F6AF6)),
                SizedBox(width: 8),
                Text("Category Thumbnail", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 18),
            GestureDetector(
              onTap: () => _pickAndUpload(context),
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FB),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFD3D3D3)),
                ),
                child: thumbnail == null || thumbnail!.isEmpty
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_upload_outlined, size: 48, color: Color(0xFF4F6AF6)),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () => _pickAndUpload(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF4F6AF6),
                        side: const BorderSide(color: Color(0xFF4F6AF6)),
                      ),
                      child: const Text("Add Thumbnail"),
                    ),
                  ],
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(thumbnail!, fit: BoxFit.cover, width: double.infinity, height: 160),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}