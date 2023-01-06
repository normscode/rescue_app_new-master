import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rescue_app/src/constants/colors.dart';
import 'package:rescue_app/src/constants/image_strings.dart';
import 'package:rescue_app/src/constants/text_strings.dart';
import 'package:rescue_app/src/features/authentication/controllers/contact_details_controller.dart';
import 'package:rescue_app/src/features/authentication/controllers/firebase_functions_controller.dart';
import 'package:rescue_app/src/features/authentication/screens/dashboard/dashboard.dart';
import 'package:rescue_app/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:rescue_app/src/features/authentication/models/user_models.dart'
    as us;

us.UserModel? currentUser;

class ContactDetailsScreen extends StatefulWidget {
  const ContactDetailsScreen({super.key});

  @override
  State<ContactDetailsScreen> createState() => _SetContactDetailsState();
}

class _SetContactDetailsState extends State<ContactDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactDetailsController());
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        title:
            Text(rContactDetails, style: Theme.of(context).textTheme.headline4),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: rCardBgColor),
            child: IconButton(
                onPressed: () {
                  Get.to(() => const ProfileScreen());
                },
                icon: const Image(image: AssetImage(rUserProfileImage))),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                      child: Text(
                    'Enter emergency contact details',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Contact 1:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: controller.contact1_name,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Name",
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(32.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                        return "Enter correct name";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: controller.contact1_mobile,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Phone Number",
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(32.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
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
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Contact 2:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black26,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    cursorColor: Colors.white,
                    controller: controller.contact2_name,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Name",
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(32.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                        return "Enter correct name";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: controller.contact2_mobile,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Phone Number",
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(32.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
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
                ),
                GestureDetector(
                  onTap: () {
                    var details = {
                      'Contact1': {
                        'name': controller.contact1_name.text,
                        'mobile': controller.contact1_mobile.text,
                      },
                      'Contact2': {
                        'name': controller.contact2_name.text,
                        'mobile': controller.contact2_mobile.text,
                      }
                    };
                    currentUser?.contactData = details;

                    FocusScope.of(context).unfocus();
                    updateValue(
                        'Users',
                        FirebaseAuth.instance.currentUser!.email,
                        details,
                        FirebaseFirestore.instance);

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
