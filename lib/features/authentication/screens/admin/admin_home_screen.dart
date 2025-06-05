import 'package:admin_blinkiy/features/authentication/screens/admin/widgets/admin/admin_drawer.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../../../shop/screens/product/all_products/products.dart';
import '../login/login.dart';
import 'categories_screen.dart';
import 'dashboard_screen.dart';


class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedIndex = 0;

  // Danh sách các trang, sau này bạn thay placeholder bằng widget thật
  final List<Widget> _screens = [
    DashboardScreen(),
    CategoriesScreen(),
    ProductsScreen(),
    Placeholder(child: Center(child: Text('Customers'))),
    Placeholder(child: Center(child: Text('Orders'))),
  ];

  void _onMenuSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Đóng drawer sau khi chọn menu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel', style: TextStyle(color: TColors.primary, fontSize: 22, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false, // Xóa hết các route trước đó, không quay lại được admin
              );
            },
          ),
        ],
      ),
      drawer: AdminDrawer(
        selectedIndex: _selectedIndex,
        onSelect: _onMenuSelect,
      ),
      body: _screens[_selectedIndex],
    );
  }
}