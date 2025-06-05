import 'package:flutter/material.dart';

class ProductActions extends StatelessWidget {
  final String date;
  final bool status;

  const ProductActions({super.key, required this.date, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Status toggle
        Switch(
          value: status,
          onChanged: (v) {},
          activeColor: const Color(0xFF2F49D1),
        ),
        // Date
        Text(date, style: const TextStyle(fontSize: 13, color: Colors.black54)),
        const SizedBox(width: 8),
        // Edit
        IconButton(
          icon: const Icon(Icons.edit, color: Color(0xFF51A6F5)),
          onPressed: () {},
          tooltip: 'Edit',
        ),
        // Delete
        IconButton(
          icon: const Icon(Icons.delete, color: Color(0xFFF55656)),
          onPressed: () {},
          tooltip: 'Delete',
        ),
      ],
    );
  }
}