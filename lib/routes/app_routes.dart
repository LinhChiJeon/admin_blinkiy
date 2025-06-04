import 'package:admin_blinkiy/features/authentication/screens/login/responsive_screens/login_mobile.dart';
import 'package:get/get.dart';
import 'routes.dart';
import 'routes_middleware.dart';
import '../features/authentication/screens/login/login.dart';




class TAppRoute {
  static final List<GetPage> pages = [
    GetPage(name: Routes.login, page: () => const LoginScreen()),
    // GetPage(name: TRoutes.secondScreen, page: () => const SecondScreen()),
    // GetPage(name: TRoutes.secondScreenWithUID, page: () => const SecondScreen()),
  ];
}