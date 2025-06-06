import 'package:flutter/material.dart';
import 'main_header.dart';
import 'admin_drawer.dart';

class MainLayout extends StatelessWidget {
  final String title;
  final int selectedIndex;
  final Widget child;
  final VoidCallback? onLogout;

  const MainLayout({
    super.key,
    required this.title,
    required this.selectedIndex,
    required this.child,
    this.onLogout,
  });

  void _onSelectMenu(BuildContext context, int idx) {
    // Chuyển route dựa vào index
    switch (idx) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/categories');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/products');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/customers');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/orders');
        break;

    // Thêm các case khác nếu cần
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainHeader(title: title, onLogout: onLogout),
      drawer: AdminDrawer(
        selectedIndex: selectedIndex,
        onSelect: (idx)  => _onSelectMenu(context, idx),
      ),
      body: child,
    );
  }
}