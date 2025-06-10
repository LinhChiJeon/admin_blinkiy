
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/product/product_controller.dart';
import '../../edit_product/edit_product_screen.dart';
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
                // lib/features/shop/screens/product/all_products/table/product_table.dart
                onEdit: (index) {
                  final product = controller.filteredItems[index];
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => EditProductScreen(product: product),
                    ),
                  );
                },
                onDelete: (index) async {
                  final product = ProductController.to.filteredItems[index];
                  final result = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirm Delete'),
                      content: const Text('Are you sure you want to delete this product?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Confirm'),
                        ),
                      ],
                    ),
                  );
                  if (result == true) {
                    await ProductController.to.deleteProduct(product.id);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}