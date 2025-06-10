import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../lib/data/repositories/authentication/authentication_repository.dart';
import '../../../utils/constants/colors.dart';
import '../../authentication/screens/login/login.dart';
import '../../shop/screens/order/order_form_screen.dart';
import '../../shop/screens/order/order_list_screen.dart';

class AdminDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelect;

  const AdminDrawer({
    Key? key,
    required this.selectedIndex,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthenticationRepository());
    // Danh sách các menu
    final menus = [
      {'icon': Icons.dashboard, 'label': 'Dashboard'},
      {'icon': Icons.category, 'label': 'Categories'},
      {'icon': Icons.shopping_bag, 'label': 'Products'},
      {'icon': Icons.people, 'label': 'Customers'},
      {'icon': Icons.shopping_cart, 'label': 'Orders'},
    ];

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: TColors.primary,
                  child: Text('B', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 12),
                Text('Blinkiy', style: TextStyle(color: TColors.primary, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ...List.generate(menus.length, (idx) {
            return ListTile(
              leading: Icon(menus[idx]['icon'] as IconData, color: selectedIndex == idx ? TColors.primary : null),
              title: Text(menus[idx]['label'] as String),
              selected: selectedIndex == idx,
              selectedTileColor: TColors.hover,
              onTap: () => onSelect(idx),
            );
          }),
          const Spacer(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log out'),
            onTap: () => controller.logout(),
                      ),
        ],
      ),
    );
  }
}