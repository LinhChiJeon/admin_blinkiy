class Category {
  final String name;
  final String image;
  final String? parent;
  final bool featured;
  final String date;

  Category({
    required this.name,
    required this.image,
    this.parent,
    this.featured = false,
    required this.date,
  });
}

class CategoryTableSource {
  static final List<Category> mockCategories = List.generate(
    15,
        (i) => Category(
      name: "Category ${i + 1}",
      image: "https://via.placeholder.com/40?text=C${i + 1}",
      parent: i % 3 == 0 ? null : "Parent ${i % 3}",
      featured: i % 2 == 0,
      date: "2025-06-${(i % 30 + 1).toString().padLeft(2, '0')}",
    ),
  );
}