import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_app/src/constants/sizes.dart';
import 'package:rescue_app/src/constants/text_strings.dart';
import 'package:rescue_app/src/features/authentication/controllers/signup_controller.dart';
import 'package:rescue_app/src/features/authentication/models/user_models.dart';
import 'package:rescue_app/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerS = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: rFormHeight - 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controllerS.fullName,
              decoration: const InputDecoration(
                  label: Text(rFullName),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                  return "Enter correct name";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: rFormHeight - 20),
            TextFormField(
              controller: controllerS.email,
              decoration: const InputDecoration(
                  label: Text(rEmail), prefixIcon: Icon(Icons.email_outlined)),
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
              controller: controllerS.phoneNo,
              decoration: const InputDecoration(
                  label: Text(rPhoneNo), prefixIcon: Icon(Icons.numbers)),
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                        .hasMatch(value)) {
                  return "Enter correct Phone No";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: rFormHeight - 20),
            TextFormField(
              obscureText: true,
              obscuringCharacter: '*',
              controller: controllerS.password,
              decoration: const InputDecoration(
                  label: Text(rPassword), prefixIcon: Icon(Icons.fingerprint)),
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
            const SizedBox(height: rFormHeight - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Email and Password Authentication
                    SignUpController.instance.registerUser(
                        controllerS.email.text.trim(),
                        controllerS.password.text.trim());

                    //Phone Authentication
                    // SignUpController.instance
                    //     .phoneAuthentication(controllerS.phoneNo.text.trim());

                    // USER
                    final user = UserModel(
                      email: controllerS.email.text.trim(),
                      password: controllerS.password.text.trim(),
                      fullName: controllerS.fullName.text.trim(),
                      phoneNo: controllerS.phoneNo.text.trim(),
                      role: 'user',
                    );
                    SignUpController.instance.createUser(user);
                  }
                },
                child: Text(rSignup.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
