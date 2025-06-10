import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/helpers/cloudinary.dart';
import '../../../controllers/category/category_controller.dart';
import '../../../models/category_model.dart';

class EditCategoryScreen extends StatefulWidget {
  final CategoryModel category;
  const EditCategoryScreen({super.key, required this.category});

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late bool isFeatured;
  String? imageUrl;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.category.name);
    isFeatured = widget.category.isFeatured;
    imageUrl = widget.category.image;
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => isSaving = true);

    final updatedCategory = CategoryModel(
      id: widget.category.id,
      name: nameController.text.trim(),
      image: imageUrl ?? '',
      isFeatured: isFeatured,
      parentId: widget.category.parentId,
      createdAt: widget.category.createdAt,
      updatedAt: DateTime.now(),
    );

    try {
      await CategoryController.to.updateCategory(widget.category.id, updatedCategory);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      // Handle error
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Category')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            TextFormField(
              controller: nameController,
              validator: (v) => v == null || v.trim().isEmpty ? "Enter category name" : null,
              decoration: const InputDecoration(labelText: "Category Name"),
            ),

            Card(
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
                      onTap: isSaving ? null : () async {
                        final url = await uploadImageToCloudinary();
                        if (url != null) setState(() => imageUrl = url);
                      },
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F8FB),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFD3D3D3)),
                        ),
                        child: imageUrl == null || imageUrl!.isEmpty
                            ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.cloud_upload_outlined, size: 48, color: Color(0xFF4F6AF6)),
                            const SizedBox(height: 12),
                            OutlinedButton(
                              onPressed: isSaving ? null : () async {
                                final url = await uploadImageToCloudinary();
                                if (url != null) setState(() => imageUrl = url);
                              },
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
                          child: Image.network(imageUrl!, fit: BoxFit.cover, width: double.infinity, height: 160),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),
            Row(
              children: [
                Checkbox(
                  value: isFeatured,
                  onChanged: (v) => setState(() => isFeatured = v ?? false),
                ),
                const Text("Featured"),
              ],
            ),
            const SizedBox(height: 18),
            // Add image picker if needed
            ElevatedButton(
              onPressed: isSaving ? null : _save,
              child: isSaving ? const CircularProgressIndicator() : const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}