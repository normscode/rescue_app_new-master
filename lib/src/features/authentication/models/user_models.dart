import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
  final String role;
  late Map<String, dynamic>? contactData;

  UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNo,
    required this.role,
    this.contactData,
  });

  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
      "Role": role,
    };
  }

  //Map User fetched from Firebase to UserModel
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      email: data['Email'],
      password: data['Password'],
      fullName: data['FullName'],
      phoneNo: data['Phone'],
      role: data['Role'],
      contactData: {'Contact1': data['Contact1'], 'Contact2': data['Contact2']},
    );
  }
}
