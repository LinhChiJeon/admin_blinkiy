// cart_item_model.dart
class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? selectedVariation;

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.variationId = '',
    this.image,
    this.price = 0.0,
    this.title = '',
    this.selectedVariation,
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
      'SelectedVariation': selectedVariation,
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
      selectedVariation: json['SelectedVariation'] as String?,
    );
  }
}