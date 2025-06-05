import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/colors.dart';
import '../../../shop/controllers/category/category_controller.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // Fake data, bạn thay bằng data thực tế khi cần
  final List<Map<String, dynamic>> categories = [
    {
      "name": "Cosmetics",
      "featured": true,
      "status": true,
      "date": "26/05/2025 at 04:11"
    },
    {
      "name": "Shoes",
      "featured": true,
      "status": true,
      "date": "24/05/2025 at 08:41"
    },
    {
      "name": "Animals",
      "featured": false,
      "status": true,
      "date": "24/05/2025 at 04:11"
    },
    {
      "name": "Clothes",
      "featured": true,
      "status": false,
      "date": "21/05/2025 at 04:11"
    },
    {
      "name": "Electronics",
      "featured": false,
      "status": false,
      "date": "20/05/2025 at 04:11"
    },
    {
      "name": "Furniture",
      "featured": false,
      "status": true,
      "date": "19/05/2025 at 04:11"
    },
  ];

  String search = "";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    final filteredCategories = categories
        .where((cat) =>
        cat["name"].toString().toLowerCase().contains(search.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: TColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.dashboard_customize, color: Colors.black),
            SizedBox(width: 8),
            Text("All Categories",
                style: TextStyle(
                    color: TColors.primary, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.download), onPressed: () {}),
          IconButton(icon: Icon(Icons.print), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                Text("Categories",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ],
            ),
            SizedBox(height: 18),

            // Title
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF5865F2),
                  child: Icon(Icons.dashboard_customize, color: Colors.white),
                ),
                SizedBox(width: 10),
                Text("All Categories",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 26)),
              ],
            ),
            SizedBox(height: 16),

            // Create New Category Button + Actions
            Row(
              children: [
                SizedBox(
                  width: 220,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5865F2),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () {},
                    child: Text("Create New Category",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18)),
                  ),
                ),
                const Spacer(),
                IconButton(icon: Icon(Icons.download), onPressed: () {}),
                IconButton(icon: Icon(Icons.print), onPressed: () {}),
              ],
            ),
            SizedBox(height: 16),

            // Search
            SizedBox(
              width: 400,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
                onChanged: (val) {
                  setState(() => search = val);
                },
              ),
            ),
            SizedBox(height: 20),

            // Table Section Bọc trong Card
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    constraints: BoxConstraints(minWidth: 650, maxWidth: 800),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Column(
                      children: [
                        // Table Header
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF4F6FA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 36,
                                  child: Checkbox(value: false, onChanged: (_) {})),
                              _tableHeader("Ser", width: 36, center: true),
                              _tableHeader("Category ↑", width: 150),
                              _tableHeader("Featured", width: 90),
                              _tableHeader("Status", width: 90),
                              _tableHeader("Date", width: 140),
                              _tableHeader("Action", width: 90, center: true),
                            ],
                          ),
                        ),
                        // Table Content
                        ...List.generate(filteredCategories.length, (i) {
                          final c = filteredCategories[i];
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              color: i % 2 == 0
                                  ? Colors.grey[50]
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 36,
                                  child: Checkbox(
                                      value: false, onChanged: (_) {}),
                                ),
                                _tableCell(Text("${i + 1}",
                                    textAlign: TextAlign.center),
                                    width: 36, center: true),
                                _tableCell(Row(
                                  children: [
                                    Text(
                                      c["name"],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ), width: 120),
                                _tableCell(_statusPill(
                                    c["featured"] ? "Active" : "No",
                                    color: c["featured"]
                                        ? Color(0xFF5865F2)
                                        : Colors.grey),
                                    width: 90),
                                _tableCell(_statusPill(
                                    c["status"] ? "Active" : "No",
                                    color: c["status"]
                                        ? Color(0xFF5865F2)
                                        : Colors.grey),
                                    width: 90),
                                _tableCell(Text(c["date"]), width: 140),
                                _tableCell(Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit,
                                          color: Colors.blueAccent),
                                      onPressed: () {},
                                      tooltip: "Edit",
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete,
                                          color: Colors.redAccent),
                                      onPressed: () {},
                                      tooltip: "Delete",
                                    ),
                                  ],
                                ), width: 90, center: true),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tableHeader(String label, {double width = 80, bool center = false}) =>
      SizedBox(
        width: width,
        child: Text(
          label,
          textAlign: center ? TextAlign.center : TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF6C63FF),
              fontSize: 15),
        ),
      );

  Widget _tableCell(Widget child,
      {double width = 80, bool center = false}) =>
      SizedBox(
        width: width,
        child: Align(
          alignment: center ? Alignment.center : Alignment.centerLeft,
          child: child,
        ),
      );

  Widget _statusPill(String label, {Color color = const Color(0xFF5865F2)}) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: color, width: 1.5),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle,
                color: color, size: 18),
            SizedBox(width: 4),
            Text(label,
                style: TextStyle(
                    color: color, fontWeight: FontWeight.w500, fontSize: 13)),
          ],
        ),
      );
}