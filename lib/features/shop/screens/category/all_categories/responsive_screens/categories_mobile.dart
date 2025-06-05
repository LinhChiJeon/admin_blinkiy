import 'package:flutter/material.dart';
import '../../../../models/category_model.dart';
import '../widgets/category_table_header.dart';
import '../table/category_table.dart';

class CategoriesMobile extends StatelessWidget {
  const CategoriesMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: const [
            CategoryTableHeader(),
            SizedBox(height: 12),
            Expanded(child: CategoryTable()),
          ],
        ),
      ),
    );
  }
}