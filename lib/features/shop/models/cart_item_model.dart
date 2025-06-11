class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? size; // Renamed from selectedVariation for clarity

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.variationId = '',
    this.image,
    this.price = 0.0,
    this.title = '',
    this.size,
  });

  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  Map<String, dynamic> toJson() {
    return {
      'ProductId': productId,
      'Title': title,
      'Price': price,
      'Image': image,
      'Quantity': quantity,
      'VariationId': variationId,
      'Size': size, // Updated key to match renamed field
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['ProductId'] as String? ?? '',
      title: json['Title'] as String? ?? '',
      price: (json['Price'] is num)
          ? (json['Price'] as num).toDouble()
          : double.tryParse(json['Price']?.toString() ?? '0.0') ?? 0.0,
      image: json['Image'] as String?,
      quantity: json['Quantity'] as int? ?? 0,
      variationId: json['VariationId'] as String? ?? '',
      size: json['Size'] as String?, // Updated key to match renamed field
    );
  }
}