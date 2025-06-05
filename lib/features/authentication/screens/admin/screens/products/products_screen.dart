import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

// Mock Data
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
}

final List<Product> mockProducts = List.generate(
  40,
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

class ProductTableSource extends DataTableSource {
  final List<Product> products;
  final void Function(int)? onEdit;
  final void Function(int)? onDelete;

  ProductTableSource({
    required this.products,
    this.onEdit,
    this.onDelete,
  });

  @override
  DataRow2 getRow(int index) {
    final product = products[index];
    return DataRow2(
      cells: [
        // Product (image + name)
        DataCell(Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.image,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 14),
            Flexible(
              child: Text(
                product.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        )),
        // Stock
        DataCell(Text(product.stock.toString())),
        // Brand (logo + name)
        DataCell(Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                product.brandLogo,
                width: 32,
                height: 32,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                product.brandName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )),
        // Price (single or range)
        DataCell(product.priceMax != null
            ? Text(
          '\$${product.price.toStringAsFixed(2)} - \$${product.priceMax!.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.w500),
        )
            : Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.w500),
        )),
        // Date
        DataCell(Text(product.date)),
        // Actions
        DataCell(Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blueAccent),
              tooltip: "Edit",
              onPressed: onEdit == null ? null : () => onEdit!(index),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              tooltip: "Delete",
              onPressed: onDelete == null ? null : () => onDelete!(index),
            ),
          ],
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => products.length;
  @override
  int get selectedRowCount => 0;
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> products = mockProducts;
  String searchText = "";
  int rowsPerPage = 10;
  int? sortColumnIndex;
  bool sortAscending = true;

  void _onSearch(String value) {
    setState(() {
      searchText = value;
      products = mockProducts
          .where((e) =>
      e.name.toLowerCase().contains(value.toLowerCase()) ||
          e.brandName.toLowerCase().contains(value.toLowerCase()) ||
          e.id.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void _onSort<T>(Comparable<T> Function(Product p) getField, int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
      products.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    final minTableWidth = isDesktop ? 980.0 : 720.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Breadcrumb
                Row(
                  children: [
                    Text("Dashboard",
                        style: TextStyle(color: Colors.grey.shade600)),
                    const Text("  /  ",
                        style: TextStyle(color: Colors.grey)),
                    Text("Products",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                  ],
                ),
                const SizedBox(height: 18),
                // Title & Add Product
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "All Products",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5865F2),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 21),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text("Add Product"),
                      onPressed: () {
                        // TODO: Navigate to add product screen
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                // Search
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: _onSearch,
                        decoration: InputDecoration(
                          hintText: "Search product name, brand, ID...",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                // Table
                Center(
                  child: Container(
                    constraints: BoxConstraints(minWidth: minTableWidth, maxWidth: 1200),
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: PaginatedDataTable2(
                      minWidth: minTableWidth,
                      columnSpacing: 22,
                      horizontalMargin: 16,
                      rowsPerPage: rowsPerPage,
                      availableRowsPerPage: const [5, 10, 20, 40],
                      onRowsPerPageChanged: (v) {
                        setState(() => rowsPerPage = v ?? 10);
                      },
                      sortColumnIndex: sortColumnIndex,
                      sortAscending: sortAscending,
                      showCheckboxColumn: false, // Có thể bật nếu bạn muốn chọn nhiều dòng
                      columns: [
                        DataColumn2(
                          label: const Text("Product"),
                          size: ColumnSize.L,
                          onSort: (col, asc) =>
                              _onSort((p) => p.name, col, asc),
                        ),
                        DataColumn2(
                          label: const Text("Stock"),
                          size: ColumnSize.S,
                          onSort: (col, asc) =>
                              _onSort((p) => p.stock, col, asc),
                          numeric: true,
                        ),
                        DataColumn2(
                          label: const Text("Brand"),
                          size: ColumnSize.M,
                          onSort: (col, asc) =>
                              _onSort((p) => p.brandName, col, asc),
                        ),
                        DataColumn2(
                          label: const Text("Price"),
                          size: ColumnSize.S,
                          onSort: (col, asc) =>
                              _onSort((p) => p.price, col, asc),
                          numeric: true,
                        ),
                        DataColumn2(
                          label: const Text("Date"),
                          size: ColumnSize.S,
                          onSort: (col, asc) =>
                              _onSort((p) => p.date, col, asc),
                        ),
                        DataColumn2(
                          label: const Text("Action"),
                          size: ColumnSize.S,
                        ),
                      ],
                      source: ProductTableSource(
                        products: products,
                        onEdit: (index) {
                          // TODO: Navigate to edit product screen
                        },
                        onDelete: (index) {
                          // TODO: Xử lý xóa sản phẩm
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}