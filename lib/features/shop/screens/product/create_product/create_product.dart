import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controllers/category/category_controller.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../models/product_model.dart';
import '../../../models/category_model.dart';
import 'widgets/product_basic_info_form.dart';
import 'widgets/product_thumbnail_picker.dart';
import 'widgets/product_images_picker.dart';
import 'widgets/size_variations_table.dart';
import '../../../models/product_attribute_model.dart';
import '../../../models/product_variation_model.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

// Add this function at the top of create_product.dart, after imports

String slugify(String input) {
  final vietnamese = 'àáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđ'
      'ÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸĐ';
  final without = 'aaaaaaaaaaaaaaaaaeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyd'
      'AAAAAAAAAAAAAAAAAEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYYD';

  String result = input;
  for (int i = 0; i < vietnamese.length; i++) {
    result = result.replaceAll(vietnamese[i], without[i]);
  }
  result = result
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
      .replaceAll(RegExp(r'\s+'), '-')
      .replaceAll(RegExp(r'-+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
  return result;
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

    final mainVariation = sizeVariations.isNotEmpty ? sizeVariations.first : null;

    final productVariations = sizeVariations.map((v) => ProductVariationModel(
      id: '', // or keep the original id if needed
      size: v.size,
      price: (v.price ?? 0).toDouble(),
      salePrice: (v.salePrice ?? 0).toDouble(),
      stock: (v.stock ?? 0).toInt(),
    )).toList();

    final product = ProductModel(
      id: '',
      title: titleController.text.trim(),
      description: descController.text.trim(),
      thumbnail: thumbnail ?? '',
      images: images,
      categoryId: selectedCategoryId,
      price: productVariations.isNotEmpty
          ? productVariations.map((v) => v.price).reduce((a, b) => a > b ? a : b)
          : 0.0,
      salePrice: productVariations.isNotEmpty
          ? productVariations.map((v) => v.salePrice).reduce((a, b) => a < b ? a : b)
          : 0.0,
      stock: productVariations.fold(0, (sum, v) => sum + (v.stock ?? 0)), // Tổng stock các size
      productType: 'variable',
      productAttributes: [
        ProductAttributeModel(
          name: "Size",
          values: ["15", "17", "19"],
        ),
      ],
      productVariations: productVariations,
      isFeatured: true,
      slug: slugify(titleController.text.trim()),
    );



    try {
      await ProductController.to.addProduct(product);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      // Handle error if needed
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {

    // Register CategoryController if not already registered
    if (!Get.isRegistered<CategoryController>()) {
      Get.put(CategoryController());
    }

    final categoryController = CategoryController.to;

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
          Obx(() {
            final categories = categoryController.allItems;
            if (categoryController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (categories.isEmpty) {
              return const Center(child: Text('No categories found'));
            }




            if (selectedCategoryId == null && categories.isNotEmpty) {
              selectedCategoryId = categories.first.id;
            }

            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                children: [
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    value: selectedCategoryId,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      labelText: "Category",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                    items: categories
                        .map((c) => DropdownMenuItem(
                      value: c.id,
                      child: Text(c.name),
                    ))
                        .toList(),
                    onChanged: (id) => setState(() => selectedCategoryId = id),
                    validator: (v) => (v == null || v.isEmpty) ? "Please select a category" : null,
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
                          backgroundColor: TColors.primary,
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
          }),
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