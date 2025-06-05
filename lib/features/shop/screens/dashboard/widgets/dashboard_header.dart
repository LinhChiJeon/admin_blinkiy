import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // // Top icon row (fake)
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Icon(Icons.apps, size: 28, color: Colors.black.withOpacity(0.8)),
          //     Row(
          //       children: [
          //         _circleIcon(Icons.shopping_basket, color: Color(0xFF4563FF)),
          //         const SizedBox(width: 10),
          //         _circleIcon(Icons.security, color: Color(0xFF05C46B)),
          //         const SizedBox(width: 10),
          //         _circleIcon(Icons.account_circle, color: Color(0xFF9C6BFF)),
          //         const SizedBox(width: 10),
          //         _circleIcon(Icons.code, color: Colors.blueGrey),
          //       ],
          //     ),
          //   ],
          // ),
          const SizedBox(height: 26),
          // Breadcrumb
          Row(
            children: const [
              Text("Dashboard", style: TextStyle(color: Color(0xFF8F99A8), fontSize: 16)),
              Text("  /  ", style: TextStyle(color: Color(0xFF8F99A8))),
              Text("Dashboard", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 18),
          // Title
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF4563FF),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(9),
                child: const Icon(Icons.dashboard, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 14),
              const Text(
                "Dashboard Types",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Color(0xFF232940)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleIcon(IconData icon, {Color? color}) {
    return Container(
      decoration: BoxDecoration(
        color: (color ?? Colors.grey).withOpacity(0.13),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(icon, color: color ?? Colors.grey, size: 19),
    );
  }
}