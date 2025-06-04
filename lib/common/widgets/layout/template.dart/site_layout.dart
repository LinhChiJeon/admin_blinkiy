import 'package:flutter/material.dart';

/// Một layout template tối giản chỉ dành cho mobile.
/// Khi build sẽ chỉ trả về widget mobile truyền vào.
class SiteTemplate extends StatelessWidget {
  final Widget mobile;

  const SiteTemplate({
    Key? key,
    required this.mobile, required bool useLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mobile;
  }
}