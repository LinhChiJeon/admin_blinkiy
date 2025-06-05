import 'package:admin_blinkiy/routes/app_routes.dart';
import 'package:admin_blinkiy/routes/routes.dart';
import 'package:admin_blinkiy/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'app.dart';

import 'firebase_options.dart';
import 'lib/data/repositories/authentication/authentication_repository.dart';

/// Entry point of Flutter App
Future<void> main() async {
  // Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  .then((value) => Get.put(AuthenticationRepository())); // Initialize AuthRepository

  // Main App Starts here...
  runApp(const App());
}

// If you use a separate App() widget to wrap GetMaterialApp, keep as is.
// Otherwise, you can use MyApp directly in runApp.

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Admin Blinky',
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      getPages: appRoute.pages, // Define your GetX pages here
      initialRoute: Routes.login, // Set the initial route
      unknownRoute: GetPage(
        name: '/page-not-found',
        page: () => const Scaffold(
          body: Center(child: Text("404 - Page Not Found")),
        ),
      ),
    );
  }
}