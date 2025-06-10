
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
        itemCount: products.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 40,
                height: 40,
                color: Colors.grey[200],
                child: product.thumbnail.isNotEmpty
                    ? Image.network(product.thumbnail, fit: BoxFit.cover)
                    : const Icon(Icons.shopping_bag, size: 28, color: Colors.blueGrey),
              ),
            ),
            title: Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis),
            //subtitle: Text('Stock: $product.stock}  |  \$${product.price}', style: const TextStyle(fontSize: 12)),
            subtitle: Text(
              'Stock: ${(product.productVariations != null && product.productVariations!.isNotEmpty) ? product.productVariations!.fold(0, (sum, v) => sum + (v.stock ?? 0)) : product.stock}  |  \$${product.price}',
              style: const TextStyle(fontSize: 12),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => onEdit?.call(index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onDelete?.call(index),
                ),
              ],
            ),
            onTap: () {
              // View details
            },
          );
        },
      );
    });
  }
}