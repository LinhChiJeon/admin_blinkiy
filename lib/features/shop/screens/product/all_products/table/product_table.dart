import 'package:flutter/material.dart';
import '../../../../models/product_model.dart';

class ProductTable extends StatelessWidget {
  final List<Product> products;
  final void Function(int)? onEdit;
  final void Function(int)? onDelete;

  const ProductTable({
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
      separatorBuilder: (_, __) => const Divider(height: 0, thickness: 0.5, color: Color(0xFFEEEEEE)),
      itemBuilder: (context, index) {
        final product = products[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.thumbnail,
                  width: 54,
                  height: 54,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 54,
                    height: 54,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 30),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.inventory_2_rounded, size: 16, color: Colors.grey[700]),
                        const SizedBox(width: 4),
                        Text(
                          'Stock: ${product.stock}',
                          style: const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        if (product.salePrice != null && product.salePrice != product.price)
                          Text(
                            _vnd(product.price),
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        if (product.salePrice != null && product.salePrice != product.price)
                          const SizedBox(width: 8),
                        Text(
                          _vnd(product.salePrice ?? product.price),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.deepOrange[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blueAccent, size: 22),
                onPressed: onEdit == null ? null : () => onEdit!(index),
                tooltip: 'Chỉnh sửa',
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent, size: 22),
                onPressed: onDelete == null ? null : () => onDelete!(index),
                tooltip: 'Xóa',
              ),
            ],
          ),
        );
      },
    );
  }

  static String _vnd(int value) =>
      '${value.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ".")}\₫';
}