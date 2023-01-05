import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:rescue_app/firebase_options.dart';
import 'package:rescue_app/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:rescue_app/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:rescue_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:rescue_app/src/utils/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  // final prefs = await SharedPreferences.getInstance();
  // final showWelcome = prefs.getBool('showWelcome') ?? false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // final bool showWelcome;

  // const MyApp({
  //   Key? key,
  //   required this.showWelcome,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}
