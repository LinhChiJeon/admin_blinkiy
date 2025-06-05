import 'package:flutter/material.dart';
import '../../../shared/widgets/main_layout.dart';
import 'responsive_screens/dashboard_screen_mobile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
        selectedIndex: 0, // Dashboard
        title: 'Blinkiy Admin',
        child: DashboardScreenMobile(),
    );
  }
}