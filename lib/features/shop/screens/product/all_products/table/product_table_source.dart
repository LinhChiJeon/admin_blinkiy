import '../../product_model.dart';

// Mock data cho phát triển UI, sau này thay bằng data từ Firebase
final List<Product> mockProducts = List.generate(
  30,
      (i) => Product(
    id: "P${i + 1}",
    name: "Product ${i + 1}",
    image: "https://via.placeholder.com/48?text=P${i + 1}",
    stock: 20 + i,
    brandName: "Brand ${i % 3 + 1}",
    brandLogo: "https://via.placeholder.com/32?text=B${i % 3 + 1}",
    price: 100 + i * 2.5,
    priceMax: i % 2 == 0 ? 110 + i * 2.5 : null,
    date: "2025-06-${(i % 30 + 1).toString().padLeft(2, '0')}",
  ),
);