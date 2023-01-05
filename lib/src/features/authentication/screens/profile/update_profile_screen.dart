import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:rescue_app/src/constants/text_strings.dart';
import 'package:rescue_app/src/constants/sizes.dart';
import 'package:rescue_app/src/constants/colors.dart';
import 'package:rescue_app/src/constants/image_strings.dart';
import 'package:rescue_app/src/features/authentication/controllers/contact_details_controller.dart';
import 'package:rescue_app/src/features/authentication/controllers/profile_controller.dart';
import 'package:rescue_app/src/features/authentication/models/user_models.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactController = Get.put(ContactDetailsController());
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left),
            color: Theme.of(context).iconTheme.color),
        title: Text(rEditProfile, style: Theme.of(context).textTheme.headline4),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(rDefaultSize),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  return Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const Image(
                                    image: AssetImage(rProfileImage))),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 10,
                            child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: rPrimaryColor,
                                ),
                                child: const Icon(
                                  LineAwesomeIcons.camera,
                                  size: 20.0,
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: userData.fullName,
                              decoration: const InputDecoration(
                                  label: Text(rFullName),
                                  prefixIcon: Icon(LineAwesomeIcons.user)),
                            ),
                            const SizedBox(height: rFormHeight - 20),
                            TextFormField(
                              initialValue: userData.email,
                              decoration: const InputDecoration(
                                  label: Text(rEmail),
                                  prefixIcon:
                                      Icon(LineAwesomeIcons.envelope_1)),
                            ),
                            const SizedBox(height: rFormHeight - 20),
                            TextFormField(
                              initialValue: userData.phoneNo,
                              decoration: const InputDecoration(
                                  label: Text(rPhoneNo),
                                  prefixIcon: Icon(LineAwesomeIcons.phone)),
                            ),
                            const SizedBox(height: rFormHeight - 20),
                            TextFormField(
                              obscureText: true,
                              initialValue: userData.password,
                              decoration: const InputDecoration(
                                  label: Text(rPassword),
                                  prefixIcon:
                                      Icon(LineAwesomeIcons.fingerprint)),
                            ),
                            const SizedBox(height: rFormHeight - 20),
                            TextFormField(
                              initialValue: userData.contactData!['Contact1']
                                  ['mobile'],
                              decoration: const InputDecoration(
                                  label: Text('Contact 1'),
                                  prefixIcon: Icon(Icons.person)),
                            ),
                            const SizedBox(height: rFormHeight - 20),
                            TextFormField(
                              initialValue: userData.contactData!['Contact2']
                                  ['mobile'],
                              decoration: const InputDecoration(
                                  label: Text('Contact 2'),
                                  prefixIcon: Icon(Icons.person)),
                            ),
                            const SizedBox(height: rFormHeight),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () =>
                                    Get.to(() => const UpdateProfileScreen()),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: rPrimaryColor,
                                    side: BorderSide.none,
                                    shape: const StadiumBorder()),
                                child: const Text(rEditProfile,
                                    style: TextStyle(color: rDarkColor)),
                              ),
                            ),
                            const SizedBox(height: rFormHeight),
                          ],
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
