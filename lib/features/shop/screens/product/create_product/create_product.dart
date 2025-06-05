import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../models/category_model.dart';
import '../../../models/product_model.dart';
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
  bool isSaving = false;

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => isSaving = true);

    // Use the first variation as the main price/stock, or default to 0
    final mainVariation = sizeVariations.isNotEmpty ? sizeVariations.first : null;

    final product = ProductModel(
      id: '', // Firestore will generate ID
      title: titleController.text.trim(),
      description: descController.text.trim(),
      thumbnail: thumbnail ?? '',
      images: images,
      categoryId: selectedCategoryId,
      price: (mainVariation?.price ?? 0).toDouble(),
      salePrice: (mainVariation?.salePrice ?? 0).toDouble(),
      stock: mainVariation?.stock ?? 0,
      productType: 'variable',
      // You can map sizeVariations to productVariations if needed
    );

    try {
      await ProductController.to.addProduct(product);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      // Show error if needed
    } finally {
      if (mounted) setState(() => isSaving = false);
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
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                    CategorySelector(
                      selectedId: selectedCategoryId,
                      categories: categories,
                      onChanged: (id) => setState(() => selectedCategoryId = id),
                    ),
                    const SizedBox(height: 18),
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
                          onPressed: isSaving ? null : _save,
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
          if (isSaving)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}