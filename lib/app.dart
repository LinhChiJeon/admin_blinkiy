import 'package:admin_blinkiy/routes/app_routes.dart';
import 'package:admin_blinkiy/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'lib/bindings/general_bindings.dart';
import 'utils/constants/text_strings.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,

      
      initialBinding: GeneralBindings(),
      

      getPages: appRoute.pages, // <-- Đây là danh sách các GetPage đã map route với màn hình
      initialRoute: Routes.login, // <-- Route khởi động (thường là login)

      unknownRoute: GetPage(
        name: '/page-not-found',
        page: () => const Scaffold(
          body: Center(child: Text('Không tìm thấy trang này')),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}