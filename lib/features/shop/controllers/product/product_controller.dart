// lib/features/shop/controllers/product/product_controller.dart
import 'package:get/get.dart';
import '../../../../lib/data/repositories/product/product_repository.dart';
import '../../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get to => Get.find();

  RxBool isLoading = true.obs;
  RxList<ProductModel> allItems = <ProductModel>[].obs;
  RxList<ProductModel> filteredItems = <ProductModel>[].obs;

  final _productRepository = Get.put(ProductRepository());

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<ProductModel> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await _productRepository.getAllProducts();
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      // Handle error (snackbar, etc.)
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      isLoading.value = true;
      await _productRepository.addProduct(product);
      await fetchData(); // Refresh product list
    } catch (e) {
      // Handle error (snackbar, etc.)
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      isLoading.value = true;
      await _productRepository.deleteProduct(productId);
      await fetchData(); // Refresh list
    } catch (e) {
      // Handle error (snackbar, etc.)
    } finally {
      isLoading.value = false;
    }
  }
}