import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/product/product_controller.dart';

class ProductTable extends StatelessWidget {
  final void Function(int index)? onEdit;
  final void Function(int index)? onDelete;

  const ProductTable({super.key, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.to;

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      final products = controller.filteredItems;
      if (products.isEmpty) {
        return const Center(child: Text('No products found.'));
      }
      return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final product = products[index];
          final totalStock = (product.productVariations != null && product.productVariations!.isNotEmpty)
              ? product.productVariations!.fold(0, (sum, v) => sum + (v.stock ?? 0))
              : product.stock;
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                // View details
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: Row(
                  children: [
                    // Ảnh sản phẩm
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 56,
                        height: 56,
                        color: Colors.grey[100],
                        child: product.thumbnail.isNotEmpty
                            ? Image.network(product.thumbnail, fit: BoxFit.cover)
                            : Icon(Icons.shopping_bag, size: 32, color: Colors.blue.shade400),
                      ),
                    ),
                    const SizedBox(width: 18),
                    // Thông tin sản phẩm
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              letterSpacing: 0.1,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.teal.withOpacity(0.07),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                margin: const EdgeInsets.only(right: 10),
                                child: Text(
                                  'Stock: $totalStock',
                                  style: const TextStyle(fontSize: 12, color: Colors.teal),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '\$${product.price}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Nút Edit/Xóa
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_rounded, color: Color(0xFF2979FF)),
                          tooltip: 'Edit',
                          onPressed: () => onEdit?.call(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          tooltip: 'Delete',
                          onPressed: () => onDelete?.call(index),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}