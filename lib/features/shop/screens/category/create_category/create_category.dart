import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../utils/helpers/cloudinary.dart';
import '../../../controllers/category/category_controller.dart';
import '../../../models/category_model.dart'; // Đảm bảo đường dẫn import đúng

class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({super.key});

  @override
  State<CreateCategoryScreen> createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  bool isFeatured = false;
  String? imageUrl;
  bool _loading = false;

  Future<void> _pickImage() async {
    setState(() => _loading = true);
    final url = await uploadImageToCloudinary();
    if (url != null) {
      setState(() => imageUrl = url);
    }
    setState(() => _loading = false);
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (imageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vui lòng chọn ảnh")));
      return;
    }
    setState(() => _loading = true);
    final category = CategoryModel(
      id: '', // sẽ cập nhật sau khi add
      name: nameController.text.trim(),
      image: imageUrl!,
      isFeatured: isFeatured,
      parentId: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    try {
      await CategoryController.to.addCategory(category);
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      // Có thể show lỗi nếu muốn
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Create Category', style: TextStyle(color: Color(0xFF23235B))),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF23235B)),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Form(
            key: _formKey,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        backgroundColor: Color(0xFFE7EBFF),
                        child: Icon(Icons.apps_rounded, color: Color(0xFF4F6AF6)),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Create new Category',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Tên category
                  TextFormField(
                    controller: nameController,
                    validator: (v) =>
                    v == null || v.trim().isEmpty ? "Enter category name" : null,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.apps_rounded, color: Color(0xFFA1A1A1)),
                      hintText: 'Category Name',
                      filled: true,
                      fillColor: const Color(0xFFF7F8FB),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Featured
                  Row(
                    children: [
                      Checkbox(
                        value: isFeatured,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        onChanged: (v) => setState(() => isFeatured = v ?? false),
                      ),
                      const Text("Featured"),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Image picker (dùng Cloudinary)
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
                            onTap: _loading ? null : () => _pickImage(),
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
                                    onPressed: _loading ? null : () => _pickImage(),
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
                          if (_loading)
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F6AF6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 17),
                      ),
                      child: _loading
                          ? const SizedBox(
                        width: 24, height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                          : const Text("Create"),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}