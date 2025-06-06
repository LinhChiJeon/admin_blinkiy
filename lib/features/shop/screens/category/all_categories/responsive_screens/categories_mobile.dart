import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> addCategory(CategoryModel category) async {
    final docRef = await FirebaseFirestore.instance.collection('Categories').add(category.toMap());
    // Nếu bạn muốn lưu id Firestore vào trường id:
    await FirebaseFirestore.instance.collection('Categories').add(category.toMap());
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final snapshot = await FirebaseFirestore.instance.collection('Categories').get();
    return snapshot.docs.map((doc) => CategoryModel.fromDoc(doc)).toList();
  }
}


