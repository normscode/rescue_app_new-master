import "package:flutter/material.dart";
import 'package:rescue_app/src/constants/image_strings.dart';
import 'package:rescue_app/src/constants/sizes.dart';
import 'package:rescue_app/src/constants/text_strings.dart';
import 'package:rescue_app/src/features/authentication/screens/sign_up/form_header_widget.dart';
import 'package:rescue_app/src/features/authentication/screens/sign_up/signup_footer_widget.dart';
import 'package:rescue_app/src/features/authentication/screens/sign_up/signup_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(rDefaultSize),
            child: Column(
              children: const [
                FormHeaderWidget(
                  image: rWelcomeScreenImage,
                  title: rSignUpTitle,
                  subTitle: rSignUpSubtitle,
                  imageHeight: 0.15,
                ),
                SignUpFormWidget(),
                SignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
