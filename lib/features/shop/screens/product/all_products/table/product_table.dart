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
    final screenWidth = MediaQuery.of(context).size.width;

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      final products = controller.filteredItems;
      if (products.isEmpty) {
        return const Center(child: Text('No products found.'));
      }
      return ListView.separated(
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.04,
          horizontal: screenWidth * 0.025,
        ),
        itemCount: products.length,
        separatorBuilder: (_, __) => SizedBox(height: screenWidth * 0.03),
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
                padding: EdgeInsets.symmetric(
                  vertical: screenWidth * 0.03,
                  horizontal: screenWidth * 0.025,
                ),
                child: Row(
                  children: [
                    // Ảnh sản phẩm
                    ClipRRect(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      child: Container(
                        width: screenWidth * 0.14,
                        height: screenWidth * 0.14,
                        color: Colors.grey[100],
                        child: product.thumbnail.isNotEmpty
                            ? Image.network(product.thumbnail, fit: BoxFit.cover)
                            : Icon(Icons.shopping_bag, size: screenWidth * 0.08, color: Colors.blue.shade400),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.035),
                    // Thông tin sản phẩm (co giãn)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.045,
                              letterSpacing: 0.1,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: screenWidth * 0.012),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.teal.withOpacity(0.07),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.018,
                                  vertical: screenWidth * 0.005,
                                ),
                                margin: EdgeInsets.only(right: screenWidth * 0.018),
                                child: Text(
                                  'Stock: $totalStock',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                '\$${product.price}',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Nút Edit/Xóa (giữ kích thước nhỏ, không bị tràn)
                    IntrinsicWidth(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit_rounded, color: const Color(0xFF2979FF), size: screenWidth * 0.07),
                            tooltip: 'Edit',
                            onPressed: () => onEdit?.call(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red, size: screenWidth * 0.07),
                            tooltip: 'Delete',
                            onPressed: () => onDelete?.call(index),
                          ),
                        ],
                      ),
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