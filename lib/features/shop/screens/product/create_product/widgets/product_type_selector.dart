import 'package:flutter/material.dart';

class ProductTypeSelector extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const ProductTypeSelector({
    super.key,
    required this.value,
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
                Icon(Icons.settings_outlined, size: 22, color: Color(0xFF4F6AF6)),
                SizedBox(width: 8),
                Text(
                  "Product Configuration & Management",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                const Text(
                  "Product Type",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 18),
                ChoiceChip(
                  label: const Text("Single"),
                  selected: value == "single",
                  onSelected: (b) => onChanged("single"),
                  selectedColor: const Color(0xFF4F6AF6),
                  labelStyle: TextStyle(
                    color: value == "single" ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text("Variable"),
                  selected: value == "variable",
                  onSelected: (b) => onChanged("variable"),
                  selectedColor: const Color(0xFF4F6AF6),
                  labelStyle: TextStyle(
                    color: value == "variable" ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}