import 'package:flutter/material.dart';
import 'package:admin_blinkiy/utils/constants/sizes.dart';
import 'package:admin_blinkiy/utils/constants/text_strings.dart';
import 'package:admin_blinkiy/utils/constants/icon_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';



import '../../../../../lib/features/authentication/controllers/login_controller.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../../shop/screens/dashboard/dashboard.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: controller.email,
              validator: TValidator.validateEmail,
              decoration: InputDecoration(
                labelText: TTexts.email,
                // prefixIcon: const Icon(TIcons.direct_right),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => TValidator.validateEmptyText('Password', value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                  ),
                ),
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
                    Obx(() => Checkbox(value: controller.rememeberMe.value, onChanged: (value) => controller.rememeberMe.value = value!)),
                    const Text(TTexts.rememberMe),
                  ],
                ),

                /// Forgot Password
                TextButton(
                  onPressed: () => Get.toNamed(Routes.forgetPassword),
                  child: const Text(TTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            ///Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(

                // onPressed: () {
                //   // TODO: Thêm xác thực đăng nhập ở đây nếu cần
                //   Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(builder: (_) => const DashboardScreen()),
                //   );
                // },
                onPressed: () => controller.emailAndPasswordSignIn(),

               
                child: const Text(TTexts.signIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}