
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/product/product_controller.dart';
import '../table/product_table.dart';
import '../widgets/add_product_button.dart';
import '../widgets/product_search_feild.dart';

class ProductScreenMobile extends StatelessWidget {
  const ProductScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());

    final controller = ProductController.to;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text("All Products"),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: AddProductButton(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ProductSearchField(
              onChanged: (value) {
                controller.filteredItems.value = controller.allItems
                    .where((e) =>
                e.title.toLowerCase().contains(value.toLowerCase()) ||
                    e.id.toLowerCase().contains(value.toLowerCase()) ||
                    (e.description?.toLowerCase().contains(value.toLowerCase()) ?? false))
                    .toList();
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ProductTable(
                onEdit: (index) {
                  // TODO: Edit product
                },
                onDelete: (index) async {
                  final product = ProductController.to.filteredItems[index];
                  await ProductController.to.deleteProduct(product.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}