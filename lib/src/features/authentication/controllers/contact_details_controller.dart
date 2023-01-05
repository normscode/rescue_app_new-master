import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ContactDetailsController extends GetxController {
  static ContactDetailsController get instance => Get.find();

  final contact1_name = TextEditingController();
  final contact1_mobile = TextEditingController();
  final contact2_name = TextEditingController();
  final contact2_mobile = TextEditingController();
  final contact3_name = TextEditingController();
  final contact3_mobile = TextEditingController();
  final contact4_name = TextEditingController();
  final contact4_mobile = TextEditingController();
  final contact5_name = TextEditingController();
  final contact5_mobile = TextEditingController();
}
