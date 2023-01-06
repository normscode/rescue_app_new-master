import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_app/src/constants/colors.dart';
import 'package:rescue_app/src/constants/image_strings.dart';
import 'package:rescue_app/src/constants/sizes.dart';
import 'package:rescue_app/src/constants/text_strings.dart';
import 'package:rescue_app/src/features/authentication/controllers/contact_details_controller.dart';
import 'package:rescue_app/src/features/authentication/screens/contact_details/contacts_screen.dart';
import 'package:rescue_app/src/features/authentication/screens/dashboard/widgets/drawer_header.dart';
import 'package:rescue_app/src/features/authentication/screens/dashboard/widgets/widgets_dashboard.dart';
import 'package:rescue_app/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:all_sensors/all_sensors.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:geocoding/geocoding.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:rescue_app/src/features/authentication/models/user_models.dart'
    as us;
import 'package:rescue_app/src/features/authentication/screens/profile/update_profile_screen.dart';

import '../../models/user_models.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  

  var contact1, contactData2;
  
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _mapController;
  Position? _currentPosition;
  Geolocator? _geolocator;
  TwilioFlutter? twilioFlutter;

  // ignore: prefer_final_fields
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];
  List<double> _accelerometerValues = <double>[];

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  static double _accelerationX = 0;
  static double _accelerationY = 0;
  static double _accelerationZ = 0;

  bool isSwitch = false;

  //Bottom Navigation
  int currentTab = 0;

  //Geocoding
  static String? _currentAddress;
  @override
  void initState() {
    twilioFlutter = TwilioFlutter(
        accountSid: 'ACa9cdc1804dc29b5d6e4fdc321d1db514',
        authToken: 'b6dd1843b1e7d159c70785d79bd9186c',
        twilioNumber: '+19292841968');

    super.initState();
    _getCurrentLocation();
    requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    
    final contactController = Get.put(ContactDetailsController());
    if (_accelerationX > 15 || _accelerationY > 15 || _accelerationZ > 15) {
      print('Crash Detected!');
      FlutterBeep.beep();
      // Do something, such as send an alert to the user or emergency services
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        title: Text(rAppName, style: Theme.of(context).textTheme.headline4),
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
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Ralert Application'),
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: const Text('Add Contacts'),
              onTap: () {
                Get.to(() => const ContactDetailsScreen());
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 575,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_currentPosition?.latitude ?? 0,
                        _currentPosition?.longitude ?? 0),
                    zoom: 15.0,
                  ),
                  // markers: _currentPosition != null
                  //     ? {
                  //         Marker(
                  //           markerId: const MarkerId('currentLocation'),
                  //           position: LatLng(_currentPosition!.latitude,
                  //               _currentPosition!.longitude),
                  //         ),
                  //       }
                  //     : {},
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            bottom: 550,
            left: 0,
            right: 0,
            child: Container(
              color: rPrimaryColor,
              height: 100,
              width: 200,
              padding: EdgeInsets.all(5),
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "Turn on Automatic Car Crash Detection",
                    style: TextStyle(color: rDarkColor),
                  ),
                  Switch.adaptive(
                      value: isSwitch,
                      inactiveThumbColor: Colors.orange,
                      inactiveTrackColor: Colors.black87,
                      activeColor: Colors.blueAccent,
                      activeTrackColor: Colors.blue.withOpacity(0.4),
                      onChanged: (bool newBool) {
                        setState(() {
                          isSwitch = newBool;
                        });
                        if (isSwitch == true) {
                          _streamSubscriptions.add(accelerometerEvents!
                              .listen((AccelerometerEvent event) {
                            setState(() {
                              _accelerationX = event.x;
                              _accelerationY = event.y;
                              _accelerationZ = event.z;
                            });
                          }));
                        } else if (isSwitch == false) {
                          // ignore: unused_local_variable
                          for (StreamSubscription<dynamic> subscription
                              in _streamSubscriptions) {
                            subscription.cancel();
                          }
                        }
                      })
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Alert Button');
          sendSms();
        },
        child: Text('Ralert'),
        backgroundColor: rPrimaryColor,
        foregroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10.0,
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentTab = 0;
                      });
                      Get.to(() => const Dashboard());
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dashboard,
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                              color:
                                  currentTab == 0 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentTab = 1;
                      });
                      // Get.to(() => const ProfileScreen());
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color:
                                  currentTab == 1 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentTab = 2;
                      });
                      // Get.to(() => const Dashboard());
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dashboard,
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                              color:
                                  currentTab == 2 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentTab = 3;
                      });
                      // Get.to(() => const ProfileScreen());
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color:
                                  currentTab == 3 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

//Get Current Location
  void _getCurrentLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      if (_mapController != null) {
        _mapController?.animateCamera(CameraUpdate.newLatLng(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        ));
      }
      _getAddressFromLatLng();
    } catch (e) {
      print(e);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_currentPosition != null) {
      _mapController?.animateCamera(CameraUpdate.newLatLng(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      ));
    }

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? _currentPosition) {
      print(_currentPosition == null
          ? 'Unknown'
          : '${_currentPosition.latitude.toString()}, ${_currentPosition.longitude.toString()}');
      _mapController?.animateCamera(CameraUpdate.newLatLng(
        LatLng(_currentPosition!.latitude, _currentPosition.longitude),
      ));
    });
  }

  Future<bool> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> status = await [
        Permission.location,
      ].request();
    } else if (status.isGranted) {
      return true;
    } else {
      return true;
    }
    return false;
  }

  //Function to convert lat and longitude to address text
  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.subThoroughfare}, ${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  // fetchContact1() async{
  //   final user = FirebaseAuth.instance.currentUser;
  //   DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('Users').doc(user?.uid).get();
  //   UserModel userData = snapshot.data as UserModel;
  //   // final doc = await FirebaseFirestore.instance
  //   //     .collection('users')
  //   //     .doc(user?.uid)
  //   //     .get();
    
  //   contact1 = userData.contactData!['Contact1']['mobile'];
  //   print(contact1);
  // }

  void sendSms() async {
  twilioFlutter?.sendSMS(
      toNumber: '+639158111254', 
      messageBody: 'I need help! I got into accident!, This is my current location: $_currentAddress\n Google Map Link: http://maps.google.com/?q=${_currentPosition!.latitude.toString()},${_currentPosition!.longitude.toString()}');
}

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
