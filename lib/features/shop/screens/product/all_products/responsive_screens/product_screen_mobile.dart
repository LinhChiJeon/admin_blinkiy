import 'package:flutter/material.dart';
import '../../product_model.dart';
import '../table/product_table.dart';
import '../table/product_table_source.dart';
import '../widgets/add_product_button.dart';
import '../widgets/product_search_feild.dart';


class ProductScreenMobile extends StatefulWidget {
  const ProductScreenMobile({super.key});

  @override
  State<ProductScreenMobile> createState() => _ProductScreenMobileState();
}

class _ProductScreenMobileState extends State<ProductScreenMobile> {
  List<Product> products = mockProducts;
  String searchText = "";

  void _onSearch(String value) {
    setState(() {
      searchText = value;
      products = mockProducts
          .where((e) =>
      e.name.toLowerCase().contains(value.toLowerCase()) ||
          e.brandName.toLowerCase().contains(value.toLowerCase()) ||
          e.id.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
            ProductSearchField(onChanged: _onSearch),
            const SizedBox(height: 10),
            Expanded(
              child: ProductTable(
                products: products,
                onEdit: (index) {
                  // TODO: Navigate to edit product screen
                },
                onDelete: (index) {
                  // TODO: Xoá sản phẩm
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}