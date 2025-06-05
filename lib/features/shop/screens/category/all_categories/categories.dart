import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../shared/widgets/main_layout.dart';
import '../../../controllers/category/category_controller.dart';
import 'responsive_screens/categories_mobile.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CategoryController());
    return const MainLayout(
      selectedIndex: 1, // categories
      title: 'Blinkiy Admin',
      child: CategoriesMobile(),
    );
  }
}