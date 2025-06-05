import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/category_model.dart';
import 'widgets/category_selector.dart';
import 'widgets/product_basic_info_form.dart';
import 'widgets/product_thumbnail_picker.dart';
import 'widgets/product_images_picker.dart';
import 'widgets/size_variations_table.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  String? thumbnail;
  List<String> images = [];
  String? selectedCategoryId;
  List<SizeVariation> sizeVariations = [
    SizeVariation("15"),
    SizeVariation("17"),
    SizeVariation("19"),
  ];

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      // Lấy các giá trị, build json và lưu lên Firestore
      // ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Create Product', style: TextStyle(color: Color(0xFF23235B))),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF23235B)),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: false,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, snapshot) {
          List<CategoryModel> categories = [];
          if (snapshot.hasData) {
            categories = snapshot.data!.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
          }
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              children: [
                // Chọn category
                CategorySelector(
                  selectedId: selectedCategoryId,
                  categories: categories,
                  onChanged: (id) => setState(() => selectedCategoryId = id),
                ),
                const SizedBox(height: 18),
                // Thông tin cơ bản
                ProductBasicInfoForm(
                  titleController: titleController,
                  descController: descController,
                ),
                const SizedBox(height: 18),
                ProductThumbnailPicker(
                  thumbnail: thumbnail,
                  onChanged: (value) => setState(() => thumbnail = value),
                ),
                const SizedBox(height: 18),
                ProductImagesPicker(
                  images: images,
                  onChanged: (imgs) => setState(() => images = imgs),
                ),
                const SizedBox(height: 18),
                SizeVariationsTable(
                  variations: sizeVariations,
                  onChanged: (vals) => setState(() => sizeVariations = vals),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        side: const BorderSide(color: Color(0xFFD3D3D3)),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      ),
                      child: const Text('Discard'),
                    ),
                    ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F6AF6),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      ),
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}