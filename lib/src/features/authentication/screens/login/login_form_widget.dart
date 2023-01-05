import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_app/src/constants/sizes.dart';
import 'package:rescue_app/src/features/authentication/controllers/signup_controller.dart';
import 'package:rescue_app/src/features/authentication/screens/dashboard/dashboard.dart';
import '../../../../constants/text_strings.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: rFormHeight - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: rEmail,
                  hintText: rEmail,
                  border: OutlineInputBorder()),
              controller: controller.email,
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                        .hasMatch(value)) {
                  return "Enter correct email";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: rFormHeight - 20),
            TextFormField(
              obscureText: true,
              obscuringCharacter: '*',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: rPassword,
                hintText: rPassword,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.remove_red_eye_sharp),
                ),
              ),
              controller: controller.password,
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                        .hasMatch(value)) {
                  return "Enter valid password";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: rFormHeight - 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {}, child: const Text(rForgetPassword)),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    SignUpController.instance.loginUser(
                        controller.email.text.trim(),
                        controller.password.text.trim());
                  }
                },
                child: Text(rLogin.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
