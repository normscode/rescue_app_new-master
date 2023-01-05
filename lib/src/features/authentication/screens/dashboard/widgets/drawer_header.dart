import 'package:flutter/material.dart';
import 'package:rescue_app/src/constants/image_strings.dart';

class HeaderDrawer extends StatefulWidget {
  const HeaderDrawer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  HeaderDrawerState createState() => HeaderDrawerState();
}

class HeaderDrawerState extends State<HeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[700],
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(rProfileImage),
              ),
            ),
          ),
          const Text(
            "Ralert App",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            "info@ralert.com",
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
