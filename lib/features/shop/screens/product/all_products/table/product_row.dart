import 'package:flutter/material.dart';
import 'product_price_widget.dart';
import 'product_actions.dart';

class ProductRow extends StatelessWidget {
  final Map<String, dynamic> product;
  const ProductRow({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE9E9F0))),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Checkbox(
              value: false,
              onChanged: (value) {},
              shape: const CircleBorder(),
            ),
          ),
          // Product Info
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Image.network(product['image'], width: 40, height: 40, fit: BoxFit.cover),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    product['name'],
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          // Price + Discount
          Expanded(
            flex: 2,
            child: ProductPriceWidget(
              price: product['price'],
              oldPrice: product['oldPrice'],
              discount: product['discount'],
            ),
          ),
          // Actions, Date, Status, Delete
          Expanded(
            child: ProductActions(
              date: product['date'],
              status: product['status'],
            ),
          ),
        ],
      ),
    );
  }
}