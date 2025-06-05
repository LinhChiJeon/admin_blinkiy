import 'package:flutter/material.dart';
import '../../product_model.dart';

class ProductTableSource extends StatelessWidget {
  final List<Product> products;
  final void Function(int)? onEdit;
  final void Function(int)? onDelete;

  const ProductTableSource({
    super.key,
    required this.products,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('No products found.'));
    }
    return ListView.separated(
      itemCount: products.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product.image,
              width: 44,
              height: 44,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${product.brandName} - Stock: ${product.stock}'),
              Text(
                product.priceMax != null
                    ? '\$${product.price.toStringAsFixed(2)} - \$${product.priceMax!.toStringAsFixed(2)}'
                    : '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(product.date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blueAccent, size: 22),
                onPressed: onEdit == null ? null : () => onEdit!(index),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent, size: 22),
                onPressed: onDelete == null ? null : () => onDelete!(index),
              ),
            ],
          ),
          onTap: () {
            // TODO: Xem chi tiết sản phẩm nếu muốn
          },
        );
      },
    );
  }
}