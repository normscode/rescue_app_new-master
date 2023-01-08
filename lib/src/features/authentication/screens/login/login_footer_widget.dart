import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_app/src/constants/image_strings.dart';
import 'package:rescue_app/src/constants/sizes.dart';
import 'package:rescue_app/src/constants/text_strings.dart';
import 'package:rescue_app/src/features/authentication/screens/sign_up/signup_screen.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(height: rFormHeight - 20),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Image(image: AssetImage(rGoogleLogoImage), width: 20.0),
            onPressed: () {},
            label: const Text(rSignInWithGoogle),
          ),
        ),
        const SizedBox(height: rFormHeight - 20),
        TextButton(
          onPressed: () {
            Get.to(()=> const SignUpScreen());
          },
          child: Text.rich(
            TextSpan(
                text: rDontHaveAnAccount,
                style: Theme.of(context).textTheme.bodyText1,
                children: const [
                  TextSpan(text: rSignup, style: TextStyle(color: Colors.blue))
                ]),
          ),
        ),
      ],
    );
  }
}
