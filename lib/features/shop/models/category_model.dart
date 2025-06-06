
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatter.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  bool isFeatured;
  String parentId;
  DateTime? createdAt;
  DateTime? updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured = false,
    this.parentId = '',
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => TFormatter.formatDate(createdAt);
  String get formattedUpdatedAtDate => TFormatter.formatDate(updatedAt);
  static CategoryModel empty() => CategoryModel(id: '', image: '', name: '', isFeatured: false);

  toJson(){
    return {
      'Name': name,
      'Image': image,
      'IsFeatured': isFeatured,
      'ParentId': parentId,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt = DateTime.now(),
    };
  }

  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    if (document.data() != null) {
      final data = document.data()!;
      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        parentId: data['ParentId'] ?? '',
        createdAt: data.containsKey('CreatedAt')
            ? data['CreatedAt']?.toDate()
            : null,
        updatedAt: data.containsKey('UpdatedAt')
            ? data['UpdatedAt']?.toDate()
            : null,
      );
    } else{
      return CategoryModel.empty();
    }
  }
  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'IsFeatured': isFeatured,
      'ParentId': parentId,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt,
    };
  }

  static CategoryModel fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return CategoryModel(
      id: data['Id'] ?? doc.id,
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      parentId: data['ParentId'] ?? '',
      createdAt: (data['CreatedAt'] is Timestamp)
          ? (data['CreatedAt'] as Timestamp).toDate()
          : DateTime.now(),
      updatedAt: (data['UpdatedAt'] is Timestamp)
          ? (data['UpdatedAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

}