import 'package:flutter/material.dart';
import 'responsive_screens/product_screen_mobile.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
      return const ProductScreenMobile();
  }
}