import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_app/src/constants/colors.dart';
import 'package:rescue_app/src/constants/image_strings.dart';
import 'package:rescue_app/src/constants/sizes.dart';
import 'package:rescue_app/src/constants/text_strings.dart';
import 'package:rescue_app/src/features/authentication/screens/contact_details/contacts_screen.dart';
import 'package:rescue_app/src/features/authentication/screens/dashboard/widgets/drawer_header.dart';
import 'package:rescue_app/src/features/authentication/screens/dashboard/widgets/widgets_dashboard.dart';
import 'package:rescue_app/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:rescue_app/src/features/authentication/models/user_models.dart'
    as us;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:all_sensors/all_sensors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _mapController;
  Position? _currentPosition;
  Geolocator? _geolocator;

  final LocationSettings locationSettings = LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 100,
  );

 
  double _accelerationX = 0;
  double _accelerationY = 0;
  double _accelerationZ = 0;

  static const LatLng sourceLocation = LatLng(14.560243, 121.0827677);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  @override
  void initState() {
    super.initState();

    _getCurrentLocation();

    // accelerometerEvents?.listen((AccelerometerEvent event) {
    //   setState(() {
    //     _accelerationX = event.x;
    //     _accelerationY = event.y;
    //     _accelerationZ = event.z;
    //   });
    // });
    requestLocationPermission();
    // getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    // if (_accelerationX > 15 || _accelerationY > 15 || _accelerationZ > 15) {
    //   print('Crash Detected!');
    //   // Do something, such as send an alert to the user or emergency services
    // }
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
      body: Column(
        children: [
          Container(
            height: 500,
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
            ),
          ),
          Container(height: 20,)
        ], 
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

     StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
    (Position? _currentPosition) {
        print(_currentPosition == null ? 'Unknown' : '${_currentPosition.latitude.toString()}, ${_currentPosition.longitude.toString()}');
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

  // void getCurrentPosition() async {
  //   currentPosition = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   mapController.animateCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //         target: LatLng(currentPosition.latitude, currentPosition.longitude),
  //         zoom: 16.0,
  //       ),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
    
  }
}
