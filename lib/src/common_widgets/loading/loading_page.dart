// loading_page.dart
import 'package:evacuaid/src/features/core/screens/dashboard/dashboard.dart';
import 'package:evacuaid/src/repository/firebase_repository/firestore_service/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final firestoreService = FirestoreService();
  final Location _location = Location();
  bool _locationSet = false;
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _handleLocation();
  }

  Future<void> _handleLocation() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _getCurrentLocation();
      await _checkFamilyDocument();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      // Check if location services are enabled
      _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      // Check for location permissions
      _permissionGranted = await _location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await _location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      final LocationData locationData = await _location.getLocation();
      final latitude = locationData.latitude;
      final longitude = locationData.longitude;

      if (latitude != null && longitude != null) {
        _latitudeController.text = latitude.toString();
        _longitudeController.text = longitude.toString();

        // Save or update location to Firestore
        if (_locationSet) {
          await _updateLocation();
        } else {
          await _saveLocationData();
        }
      } else {
        print('Failed to retrieve location data.');
      }
    } catch (e) {
      print('Error getting location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to get current location.')),
      );
    }
  }


  Future<String?> getUserUID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userUID');
  }

  Future<void> _saveLocationData() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? uid = await getUserUID();
    if (uid != null) {
      try {
        DocumentReference docRef = FirebaseFirestore.instance.collection('families').doc(uid);
        DocumentSnapshot doc = await docRef.get();

        if (!doc.exists) {
          // Create document with initial location data if it does not exist
          await docRef.set({
            'latitude': double.tryParse(_latitudeController.text) ?? 0.0,
            'longitude': double.tryParse(_longitudeController.text) ?? 0.0,
            'needHelp': 'no', // Default value
            'assigned': 'no', // Default value
          });
        } else {
          // Update existing document
          await docRef.update({
            'latitude': double.tryParse(_latitudeController.text) ?? 0.0,
            'longitude': double.tryParse(_longitudeController.text) ?? 0.0,
          });
        }

        setState(() {
          _locationSet = true;
        });
      } catch (e) {
        print('Error saving location data: $e');
      }
    }
  }

  Future<void> _updateLocation() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? uid = await getUserUID();
    if (uid != null) {
      try {
        DocumentReference docRef = FirebaseFirestore.instance.collection('families').doc(uid);
        DocumentSnapshot doc = await docRef.get();

        if (doc.exists) {
          await docRef.update({
            'latitude': double.tryParse(_latitudeController.text) ?? 0.0,
            'longitude': double.tryParse(_longitudeController.text) ?? 0.0,
          });
          setState(() {
            _locationSet = true;
          });
        } else {
          print('Document does not exist. Unable to update location.');
        }
      } catch (e) {
        print('Error updating location: $e');
      }
    }
  }

  Future<void> _checkFamilyDocument() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? uid = await getUserUID();
    if (uid != null) {
      try {
        DocumentReference docRef = FirebaseFirestore.instance.collection('families').doc(uid);
        DocumentSnapshot doc = await docRef.get();

        if (doc.exists) {
          // Redirect to LandingPage if family document exists
          Get.to(() => Dashboard());
        } else {
          // Create a new document if it does not exist and redirect
          await _saveLocationData();
          Get.to(()=> Dashboard());
        }
      } catch (e) {
        print('Error checking family document: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
