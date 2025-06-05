import 'package:flutter/material.dart';

class SizeVariation {
  String size;
  int? price;
  int? salePrice;
  int? stock;

  SizeVariation(this.size, {this.price, this.salePrice, this.stock});
}

class SizeVariationsTable extends StatelessWidget {
  final List<SizeVariation> variations;
  final Function(List<SizeVariation>) onChanged;

  const SizeVariationsTable({
    super.key,
    required this.variations,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.list_alt, size: 22, color: Color(0xFF4F6AF6)),
                SizedBox(width: 8),
                Text(
                  "Product Variations (by Size)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Table(
              border: TableBorder.all(color: Color(0xFFE0E0E0)),
              columnWidths: const {
                0: FixedColumnWidth(60),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                3: FlexColumnWidth(),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Color(0xFFF7F8FB)),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Size", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Price", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("SalePrice", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Stock", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                ...variations.asMap().entries.map((entry) {
                  final i = entry.key;
                  final v = entry.value;
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(v.size, style: const TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          initialValue: v.price?.toString() ?? "",
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(border: InputBorder.none, hintText: '0'),
                          onChanged: (val) {
                            v.price = int.tryParse(val);
                            onChanged(List<SizeVariation>.from(variations));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          initialValue: v.salePrice?.toString() ?? "",
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(border: InputBorder.none, hintText: '0'),
                          onChanged: (val) {
                            v.salePrice = int.tryParse(val);
                            onChanged(List<SizeVariation>.from(variations));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          initialValue: v.stock?.toString() ?? "",
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(border: InputBorder.none, hintText: '0'),
                          onChanged: (val) {
                            v.stock = int.tryParse(val);
                            onChanged(List<SizeVariation>.from(variations));
                          },
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}