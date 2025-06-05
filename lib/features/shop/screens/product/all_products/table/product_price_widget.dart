import 'package:flutter/material.dart';

class ProductPriceWidget extends StatelessWidget {
  final int price;
  final int? oldPrice;
  final String? discount;

  const ProductPriceWidget({
    super.key,
    required this.price,
    this.oldPrice,
    this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (oldPrice != null)
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              '\$$oldPrice',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
        Text('\$$price', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        if (discount != null)
          Container(
            margin: const EdgeInsets.only(left: 6),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE1F6ED),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              discount!,
              style: const TextStyle(fontSize: 12, color: Color(0xFF23B67E), fontWeight: FontWeight.w600),
            ),
          ),
      ],
    );
  }
}