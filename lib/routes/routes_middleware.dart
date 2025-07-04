import 'package:admin_blinkiy/lib/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes.dart';

class TRouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    print('......................... Middleware Called ..............................');
    return AuthenticationRepository.instance.isAuthenticated ? null : const RouteSettings(name: Routes.login);
  }
}