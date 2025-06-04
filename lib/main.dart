import 'package:flutter/material.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';

/// Entry point of Flutter App
Future<void> main() async {
  // Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX Local Storage

  // Remove # sign from url

  // Initialize Firebase & Authentication Repository

  await Firebase.initializeApp(); // Khởi tạo Firebase

  // Main App Starts here...
  runApp(const App());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Blinky',
      home: Scaffold(
        appBar: AppBar(title: Text("Blinkiy Admin")),
        body: Center(child: Text("Firebase đã kết nối thành công!")),
      ),
    );
  }
}
