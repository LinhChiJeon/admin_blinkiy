import 'package:admin_blinkiy/features/authentication/screens/login/responsive_screens/login_mobile.dart';
import 'package:flutter/material.dart';
import 'package:admin_blinkiy/common/widgets/layout/template.dart/site_layout.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      useLayout: false,
      mobile: LoginScreenMobile()
    );
  }
}
