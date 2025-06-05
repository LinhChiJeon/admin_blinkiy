import 'package:admin_blinkiy/features/authentication/screens/login/login.dart';
import 'package:get/get.dart';
import '../features/shop/screens/category/all_categories/categories.dart';
//import '../features/shop/screens/category/create_category/create_category.dart';
//import '../features/shop/screens/category/edit_category/edit_category.dart';
import 'routes.dart';

class appRoute {
  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => /* LoginScreen hoặc tương ứng */LoginScreen(),
    ),
    GetPage(
      name: Routes.categories,
      page: () => const CategoriesScreen(),
    ),
    // GetPage(
    //   name: Routes.createCategory,
    //   page: () => const CreateCategoryScreen(),
    // ),
    // GetPage(
    //   name: Routes.editCategory,
    //   page: () => const EditCategoryScreen(),
    // ),
    // Thêm các GetPage khác nếu có
  ];
}