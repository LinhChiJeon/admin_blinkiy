import 'package:flutter/material.dart';

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

  void _pickImage() async {
    // TODO: picker + upload ảnh -> setState imageUrl
    // Bạn có thể dùng image_picker + upload lên Firebase Storage ở đây
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    // TODO: Lưu dữ liệu lên Firestore
    /*
    CategoryModel(
      id: '', // Firestore tự sinh
      name: nameController.text,
      image: imageUrl ?? '',
      isFeatured: isFeatured,
      parentId: '', // nếu là sub, truyền id cha
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    )
    */
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

                  // Image picker
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F8FB),
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: imageUrl == null
                            ? const Icon(Icons.image_outlined, color: Color(0xFF23235B), size: 54)
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.network(imageUrl!, width: 120, height: 120, fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        right: -8,
                        bottom: -8,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF4F6AF6),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(Icons.edit, color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F6AF6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 17),
                      ),
                      child: const Text("Create"),
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