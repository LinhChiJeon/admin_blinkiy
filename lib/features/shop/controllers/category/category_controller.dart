import 'package:admin_blinkiy/lib/data/repositories/category/category_repository.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/loaders.dart';
import '../../models/category_model.dart';

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
    try{
      isLoading.value = true;
      List<CategoryModel> fetchedItems = [];
      if(allItems.isEmpty){
        fetchedItems = await _categoryRepository.getAllCategories();
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);
      isLoading.value = false;
    } catch (e){
      isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}