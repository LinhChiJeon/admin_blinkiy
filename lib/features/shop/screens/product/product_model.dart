class Product {
  final String id;
  final String name;
  final String image;
  final int stock;
  final String brandName;
  final String brandLogo;
  final double price;
  final double? priceMax;
  final String date;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.stock,
    required this.brandName,
    required this.brandLogo,
    required this.price,
    this.priceMax,
    required this.date,
  });

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
      id: id,
      name: map['name'],
      image: map['image'],
      stock: map['stock'],
      brandName: map['brandName'],
      brandLogo: map['brandLogo'],
      price: (map['price'] as num).toDouble(),
      priceMax: map['priceMax'] != null ? (map['priceMax'] as num).toDouble() : null,
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'image': image,
    'stock': stock,
    'brandName': brandName,
    'brandLogo': brandLogo,
    'price': price,
    'priceMax': priceMax,
    'date': date,
  };
}