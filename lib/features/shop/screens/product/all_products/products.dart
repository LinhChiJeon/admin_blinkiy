import 'package:flutter/material.dart';
import '../../../../shared/widgets/main_layout.dart';
import 'responsive_screens/product_screen_mobile.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      selectedIndex: 2, // products
      title: 'Blinkiy Admin',
      child: ProductScreenMobile(),
    );
  }
}