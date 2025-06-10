
import 'package:admin_blinkiy/lib/data/repositories/category/category_repository.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/loaders.dart';
import '../../models/category_model.dart';
import '../../screens/category/all_categories/responsive_screens/categories_mobile.dart';

class CategoryController extends GetxController {
  static CategoryController get to => Get.find();

  RxBool isLoading = true.obs;
  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
  RxList<CategoryModel> filteredItems = <CategoryModel>[].obs;

  final _categoryRepository = Get.put(CategoryRepository());


  @override
  void onInit() {
    fetchData();
    super.onInit();
    // Initialize any necessary data or state here
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      // Always fetch all categories from Firestore
      final fetchedItems = await _categoryRepository.getAllCategories();
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<void> addCategory(CategoryModel category) async {
    try {
      isLoading.value = true;
      await _categoryRepository.addCategory(category);
      await fetchData();
      isLoading.value = false;
      TLoaders.successSnackBar(
          title: "Thành công", message: "Tạo category thành công!");
    } catch (e) {
      isLoading.value = false;
      TLoaders.errorSnackBar(title: "Lỗi", message: e.toString());
    }
  }

  Future<void> updateCategory(String categoryId, CategoryModel category) async {
    try {
      isLoading.value = true;
      await _categoryRepository.updateCategory(categoryId, category);
      await fetchData();
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> deleteCategory(String categoryId) async {
    try {
      isLoading.value = true;
      await _categoryRepository.deleteCategory(categoryId);
      await fetchData();
    } catch (e) {
      // Handle error (e.g., show snackbar)
    } finally {
      isLoading.value = false;
    }
  }
}