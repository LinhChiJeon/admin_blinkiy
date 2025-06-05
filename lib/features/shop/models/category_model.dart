class Category {
  final String id;
  final String? image;
  final bool isFeatured;
  final String name;
  final String? parentId;

  Category({
    required this.id,
    this.image,
    required this.isFeatured,
    required this.name,
    this.parentId,
  });

  // Factory constructor to create a Category from a Map (e.g., from Firestore/JSON)
  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'] ?? '',
    image: json['image'],
    isFeatured: json['isFeatured'] ?? false,
    name: json['name'] ?? '',
    parentId: json['parentId'],
  );

  // Convert Category to Map (for Firestore/JSON)
  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'isFeatured': isFeatured,
    'name': name,
    'parentId': parentId,
  };
}