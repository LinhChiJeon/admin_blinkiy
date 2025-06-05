// import 'package:flutter/material.dart';
// import 'widgets/product_basic_info_form.dart';
// import 'widgets/product_thumbnail_picker.dart';
// import 'widgets/product_images_picker.dart';
// import 'widgets/product_type_selector.dart';
//
// class CreateProductScreen extends StatefulWidget {
//   const CreateProductScreen({super.key});
//
//   @override
//   State<CreateProductScreen> createState() => _CreateProductScreenState();
// }
//
// class _CreateProductScreenState extends State<CreateProductScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//   // Controllers & state
//   final titleController = TextEditingController();
//   final descController = TextEditingController();
//   String? thumbnail;
//   List<String> images = [];
//   String productType = "variable";
//
//   void _discard() {
//     // TODO: confirm and clear all
//     Navigator.pop(context);
//   }
//
//   void _save() {
//     if (_formKey.currentState?.validate() ?? false) {
//       // TODO: Xử lý lưu lên Firestore
//       // Lấy data từ form, gọi API hoặc Firestore
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F8FB),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text(
//           'Create Product',
//           style: TextStyle(color: Color(0xFF23235B)),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF23235B)),
//           onPressed: () => Navigator.pop(context),
//         ),
//         centerTitle: false,
//       ),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//           children: [
//             // Basic info
//             ProductBasicInfoForm(
//               titleController: titleController,
//               descController: descController,
//             ),
//             const SizedBox(height: 18),
//             // Thumbnail picker
//             ProductThumbnailPicker(
//               thumbnail: thumbnail,
//               onChanged: (value) => setState(() => thumbnail = value),
//             ),
//             const SizedBox(height: 18),
//             // Additional images picker
//             ProductImagesPicker(
//               images: images,
//               onChanged: (imgs) => setState(() => images = imgs),
//             ),
//             const SizedBox(height: 18),
//             // Product type selector (Single/Variable)
//             ProductTypeSelector(
//               value: productType,
//               onChanged: (val) => setState(() => productType = val),
//             ),
//             const SizedBox(height: 30),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 OutlinedButton(
//                   onPressed: _discard,
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: Colors.black87,
//                     side: const BorderSide(color: Color(0xFFD3D3D3)),
//                     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
//                   ),
//                   child: const Text('Discard'),
//                 ),
//                 ElevatedButton(
//                   onPressed: _save,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF4F6AF6),
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
//                   ),
//                   child: const Text('Save Changes'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }
// }