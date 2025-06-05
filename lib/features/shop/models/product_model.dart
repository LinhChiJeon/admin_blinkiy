class Product {
  final String id;
  final String categoryId;
  final String description;
  final List<String> images;
  final bool isFeatured;
  final int price;
  final List<ProductAttribute> productAttributes;
  final String productType; // Always "variable"
  final List<ProductVariation> productVariations;
  final int salePrice;
  final int stock;
  final String thumbnail;
  final String title;

  Product({
    required this.id,
    required this.categoryId,
    required this.description,
    required this.images,
    required this.isFeatured,
    required this.price,
    required this.productAttributes,
    required this.productType,
    required this.productVariations,
    required this.salePrice,
    required this.stock,
    required this.thumbnail,
    required this.title,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final List<dynamic> attrs = json['productAttributes'] ?? [];
    final List<dynamic> vars = json['productVariations'] ?? [];

    // price: max price in variations
    int maxPrice = 0;
    int minSalePrice = 0;
    int totalStock = 0;
    if (vars.isNotEmpty) {
      maxPrice = vars.map((e) => e['Price'] as int? ?? 0).reduce((a, b) => a > b ? a : b);
      // Find all SalePrice (if any), get min
      final salePrices = vars
          .map((e) => e['SalePrice'] as int?)
          .where((e) => e != null)
          .cast<int>()
          .toList();
      minSalePrice = salePrices.isNotEmpty ? salePrices.reduce((a, b) => a < b ? a : b) : 0;
      // Sum stock
      totalStock = vars
          .map((e) => e['Stock'] as int? ?? 0)
          .fold(0, (prev, curr) => prev + curr);
    }

    return Product(
      id: json['id'] ?? '',
      categoryId: json['categoryId']?.toString() ?? '',
      description: json['description'] ?? '',
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
      isFeatured: json['isFeatured'] ?? false,
      price: maxPrice,
      productAttributes: attrs.map((e) => ProductAttribute.fromJson(e)).toList(),
      productType: json['productType'] ?? 'variable',
      productVariations: vars.map((e) => ProductVariation.fromJson(e)).toList(),
      salePrice: minSalePrice,
      stock: totalStock,
      thumbnail: json['thumbnail'] ?? '',
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryId': categoryId,
    'description': description,
    'images': images,
    'isFeatured': isFeatured,
    'price': price,
    'productAttributes': productAttributes.map((e) => e.toJson()).toList(),
    'productType': productType,
    'productVariations': productVariations.map((e) => e.toJson()).toList(),
    'salePrice': salePrice,
    'stock': stock,
    'thumbnail': thumbnail,
    'title': title,
  };
}

class ProductAttribute {
  final String name;
  final List<String> values;

  ProductAttribute({
    required this.name,
    required this.values,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) => ProductAttribute(
    name: json['Name'] ?? '',
    values: (json['Values'] as List<dynamic>?)?.cast<String>() ?? [],
  );

  Map<String, dynamic> toJson() => {
    'Name': name,
    'Values': values,
  };
}

class ProductVariation {
  final int? price;
  final int? salePrice;
  final int? stock;
  final Map<String, dynamic> attributes; // dynamic attributes, e.g. size

  ProductVariation({
    this.price,
    this.salePrice,
    this.stock,
    this.attributes = const {},
  });

  factory ProductVariation.fromJson(Map<String, dynamic> json) {
    // Lấy các trường đặc biệt ra, còn lại là attributes
    final data = Map<String, dynamic>.from(json);
    final price = data.remove('Price') as int?;
    final salePrice = data.remove('SalePrice') as int?;
    final stock = data.remove('Stock') as int?;
    return ProductVariation(
      price: price,
      salePrice: salePrice,
      stock: stock,
      attributes: data, // các thuộc tính động (ví dụ: Size, Color...)
    );
  }

  Map<String, dynamic> toJson() => {
    if (price != null) 'Price': price,
    if (salePrice != null) 'SalePrice': salePrice,
    if (stock != null) 'Stock': stock,
    ...attributes,
  };
}