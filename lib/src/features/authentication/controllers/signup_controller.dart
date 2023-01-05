import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_app/src/features/authentication/models/user_models.dart';
import 'package:rescue_app/src/features/authentication/screens/admin_screen/admin_screen.dart';
import 'package:rescue_app/src/features/authentication/screens/dashboard/dashboard.dart';
import 'package:rescue_app/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:rescue_app/src/features/authentication/screens/rescuer_screen/rescuer_screen.dart';
import 'package:rescue_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:rescue_app/src/repository/user_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final userRepo = Get.put(UserRepository());

  //Call this function from Design & it will do the rest
  void registerUser(String email, String password) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  }

  //Login
  Future<void> loginUser(String email, String password) async {
    AuthenticationRepository.instance
        .loginWithEmailAndPassword(email, password);
  }

  void logoutUser() {
    AuthenticationRepository.instance.logout();
  }

  //Get phoneNo from user and pass it to Auth Repository for Firebase Authentication
  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
    // phoneAuthentication(user.phoneNo);
    Get.to(() => const OTPScreen());
  }

  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}
