import 'package:flutter/material.dart';

class AddProductButton extends StatelessWidget {
  const AddProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.add, size: 20),
      label: const Text("Add"),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF5865F2),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        elevation: 0,
      ),
      onPressed: () {
        // TODO: Navigate to create_product_screen
      },
    );
  }
}