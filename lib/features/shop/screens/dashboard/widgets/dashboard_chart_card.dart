import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';  // Import thư viện intl

import '../../../../../utils/constants/colors.dart';
import '../../../controllers/order/order_controller.dart';

class DashboardChartCard extends StatelessWidget {
  const DashboardChartCard({super.key});

  @override
  Widget build(BuildContext context) {
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
          Obx(() {
            final data = OrderController.to.weeklySales;
            final maxValue = data.reduce((a, b) => a > b ? a : b);

            return Column(
              children: [
                // Biểu đồ doanh thu
                SizedBox(
                  height: 150, // Tăng chiều cao để có đủ không gian hiển thị doanh thu
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Đảm bảo các cột có khoảng cách đều
                    children: List.generate(data.length, (i) {
                      final barHeight = 140 * data[i] / maxValue;
                      final isMax = data[i] == maxValue;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Khi nhấn vào cột, thay đổi trạng thái để hiển thị/ẩn doanh thu
                            OrderController.to.toggleShowRevenue(i);
                          },
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              // Cột biểu đồ
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                width: 24,
                                height: barHeight,
                                decoration: BoxDecoration(
                                  color: TColors.primary,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                              // Doanh thu nằm lơ lửng trên đầu cột
                              Obx(() {
                                return Positioned(
                                  top: barHeight / 2 - 20, // Doanh thu sẽ nằm ở giữa thân cột
                                  child: Visibility(
                                    visible: OrderController.to.showRevenue[i], // Kiểm tra xem cột có được nhấn không
                                    child: RotatedBox(
                                      quarterTurns: 3, // Xoay văn bản 90 độ theo chiều dọc
                                      child: Text(
                                        data[i] > 0 ? _formatCurrency(data[i]) : '', // Hiển thị doanh thu với định dạng
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF232940),
                                          fontSize: 10, // Giảm kích thước chữ
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                // Các ngày nằm phía dưới biểu đồ
                SizedBox(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Đảm bảo các ngày cách đều nhau
                    children: List.generate(data.length, (i) {
                      return Text(
                        _getDayLabel(i),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.red,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  // Chuyển đổi chỉ số ngày thành tên ngày trong tuần và định dạng ngày/tháng
  String _getDayLabel(int index) {
    DateTime now = DateTime.now();
    DateTime targetDay = now.subtract(Duration(days: 6 - index));
    return '${targetDay.day}/${targetDay.month}'; // Định dạng ngày/tháng
  }

  // Hàm định dạng số thành tiền với dấu phẩy
  String _formatCurrency(double value) {
    final format = NumberFormat("#,###", "en_US");  // Định dạng số với dấu phẩy (1,600,000)
    return format.format(value);
  }
}
