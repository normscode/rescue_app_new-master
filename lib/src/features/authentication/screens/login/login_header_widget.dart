import 'package:flutter/material.dart';
import 'package:rescue_app/src/constants/image_strings.dart';
import 'package:rescue_app/src/constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            image: const AssetImage(rWelcomeScreenImage),
            height: size.height * 0.2),
        Text(rLoginTitle, style: Theme.of(context).textTheme.headline1),
        Text(rLoginSubtitle, style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }
}
