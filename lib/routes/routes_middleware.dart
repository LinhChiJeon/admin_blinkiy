import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes.dart';

class TRouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    print('......................... Middleware Called ..............................');
    final isAuthenticated = false; // Thay false bằng logic kiểm tra đăng nhập thực tế
    return isAuthenticated ? null : const RouteSettings(name: Routes.login);
  }
}