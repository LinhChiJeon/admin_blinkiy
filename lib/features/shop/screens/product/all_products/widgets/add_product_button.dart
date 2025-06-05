import 'package:admin_blinkiy/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../create_product/create_product.dart';

class AddProductButton extends StatelessWidget {
  const AddProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.add, size: 20),
      label: const Text("Add"),
      style: ElevatedButton.styleFrom(
        backgroundColor: TColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        elevation: 0,
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CreateProductScreen()),
        );
        // TODO: Navigate to create_product_screen
      },
    );
  }
}