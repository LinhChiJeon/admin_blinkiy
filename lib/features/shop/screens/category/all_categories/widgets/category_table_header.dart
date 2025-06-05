import 'package:flutter/material.dart';

class CategoryTableHeader extends StatelessWidget {
  const CategoryTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Row(
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text("New"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            // TODO: Chuyển sang màn tạo mới category
          },
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            ),
            onChanged: (value) {
              // TODO: filter table
            },
          ),
        ),
      ],
    );
  }
}