import 'package:flutter/material.dart';
import 'package:admin_blinkiy/utils/constants/sizes.dart';
import 'package:admin_blinkiy/utils/constants/text_strings.dart';
import 'package:admin_blinkiy/utils/constants/icon_constants.dart';


import '../../../../shop/screens/dashboard/dashboard.dart';
class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              decoration: InputDecoration(
                labelText: TTexts.email,
                // prefixIcon: const Icon(TIcons.direct_right),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Password
            TextFormField(
              decoration: InputDecoration(
                labelText: TTexts.password,
                // prefixIcon: const Icon(TIcons.password_check),
                // suffixIcon: IconButton(
                  // onPressed: () {},
                  // icon: const Icon(TIcons.eye_slash),
                // ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            // Remember & Forgot Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // You can add Remember Me Checkbox here if needed
                // TextButton(onPressed: () {}, child: Text('Remember Me')),
                /// Remember Me
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(TTexts.rememberMe),
                  ],
                ),

                /// Forgot Password
                TextButton(
                  onPressed: () {
                    // Handle forgot password action
                  },
                  child: const Text(TTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            ///Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Thêm xác thực đăng nhập ở đây nếu cần
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const DashboardScreen()),
                  );
                },
                child: const Text(TTexts.signIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}