import 'package:flutter/material.dart';
import '../../../../shared/widgets/main_layout.dart';
import 'responsive_screens/customer_screen_mobile.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      selectedIndex: 3, // customers, chỉnh index phù hợp với menu của bạn
      title: 'Blinkiy Admin',
      child: CustomerScreenMobile(),
    );
  }
}