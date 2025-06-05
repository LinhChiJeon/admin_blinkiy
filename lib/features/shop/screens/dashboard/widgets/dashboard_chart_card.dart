import 'package:flutter/material.dart';
// Bạn có thể dùng fl_chart để vẽ bar chart thực tế
// import 'package:fl_chart/fl_chart.dart';

class DashboardChartCard extends StatelessWidget {
  const DashboardChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu mẫu
    final data = [1100, 3803, 980, 2700, 1600, 1300, 2200];
    final labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final maxValue = data.reduce((a, b) => a > b ? a : b);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFEEE3D2),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(7),
                child: const Icon(Icons.access_time, color: Color(0xFFB09F82), size: 19),
              ),
              const SizedBox(width: 13),
              const Text(
                "Weekly Sales",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: Color(0xFF232940)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Bar chart đơn giản (có thể thay bằng fl_chart)
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(data.length, (i) {
                final barHeight = 140 * data[i] / maxValue;
                final isMax = data[i] == maxValue;
                return Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 24,
                        height: barHeight,
                        decoration: BoxDecoration(
                          color: Color(0xFF4563FF),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      if (isMax)
                        Positioned(
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFF500),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              data[i].toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF232940),
                                  fontSize: 13),
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: -22,
                        child: Text(
                          labels[i],
                          style: const TextStyle(
                              fontSize: 13, color: Color(0xFF8F99A8)),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}