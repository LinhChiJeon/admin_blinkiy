import 'package:flutter/cupertino.dart';
import '../../../../shared/widgets/main_layout.dart';
import 'responsive_screens/categories_mobile.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      selectedIndex: 1, // categories
      title: 'Blinkiy Admin',
      child: CategoriesMobile(),
    );
  }
}