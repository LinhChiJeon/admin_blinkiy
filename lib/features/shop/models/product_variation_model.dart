class ProductVariationModel {
  final String id;
  int stock;
  double price;
  double salePrice;
  // Map<String, String> attributeValues;
  String size; //size 1 phần của attribute

  ProductVariationModel({
    required this.id,
    this.stock = 0,
    this.price = 0.0,
    this.salePrice = 0.0,
    // required this.attributeValues,
    required this.size,
  });

  /// Create Empty func for clean code
  static ProductVariationModel empty() =>
      ProductVariationModel(id: '',  size: '');
  // static ProductVariationModel empty() => ProductVariationModel (id: '', attributeValues: {});

  /// Json Format
  toJson() {
    return {
      'Id': id,
      // 'Image': image,
      // 'Description': description,
      'Price': price,
      'SalePrice': salePrice,
      // 'SalePrice': salePrice,
      // 'SKU': sku,
      'Stock': stock,
      // 'AttributeValues': attributeValues,
      'Size': size,

    };
  }

  /// Map Json oriented document snapshot from Firebase to Model

  factory ProductVariationModel.fromJson (Map<String, dynamic> document) {
    final data = document;
    if(data.isEmpty) return ProductVariationModel.empty();

    return ProductVariationModel(
      id: data['Id'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      // sku: data['SKU'] ?? '',
      stock: data['Stock'] ?? 0,
      // salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      // image: data['Image'] ?? '',
      // attributeValues: Map<String, String>.from(data['AttributeValues']),
      size: data['Size'] ?? '',

    ); // Product VariationModel

  }


}