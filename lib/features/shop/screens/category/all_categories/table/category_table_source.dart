import '../../../../models/category_model.dart';

class CategoryTableSource {
  static final List<Category> mockCategories = List.generate(
    15,
        (i) => Category(
      id: "${i + 1}",
      name: "Category ${i + 1}",
      image: "https://via.placeholder.com/40?text=C${i + 1}",
      parentId: i % 3 == 0 ? null : "${(i % 3)}",
      isFeatured: i % 2 == 0,
    ),
  );
}