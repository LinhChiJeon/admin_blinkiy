import 'package:flutter/material.dart';

import '../../../../../../utils/helpers/cloudinary.dart';

class ProductImagesPicker extends StatelessWidget {
  final List<String> images;
  final ValueChanged<List<String>> onChanged;

  const ProductImagesPicker({
    super.key,
    required this.images,
    required this.onChanged,
  });

  Future<void> _pickAndUpload(BuildContext context) async {
    final url = await uploadImageToCloudinary();
    if (url != null) onChanged([...images, url]);
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
                Icon(Icons.collections_outlined, size: 22, color: Color(0xFF4F6AF6)),
                SizedBox(width: 8),
                Text("Additional Product Images", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 96,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: images.length + 1,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  if (index == images.length) {
                    return GestureDetector(
                      onTap: () => _pickAndUpload(context),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F8FB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFD3D3D3)),
                        ),
                        child: const Icon(Icons.add_a_photo_outlined, size: 32, color: Color(0xFF4F6AF6)),
                      ),
                    );
                  }
                  final img = images[index];
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(img, width: 90, height: 90, fit: BoxFit.cover),
                      ),
                      Positioned(
                        top: 4, right: 4,
                        child: InkWell(
                          onTap: () {
                            final newImgs = List<String>.from(images)..removeAt(index);
                            onChanged(newImgs);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
                            ),
                            child: const Icon(Icons.close, size: 18, color: Colors.redAccent),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}