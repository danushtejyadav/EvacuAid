//register_page.dart
import 'package:evacuaid/src/features/core/screens/teecalculator/tee_calculator_page.dart';
import 'package:evacuaid/src/repository/firebase_repository/firestore_service/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import Location

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService(); // FirestoreService instance
  final Location _location = Location(); // Add Location instance

  Future<void> saveUserUID(String uid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userUID', uid);
  }

  Future<void> _register(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await saveUserUID(userCredential.user!.uid);

      // Get current location
      LocationData locationData = await _location.getLocation();

      // Create a new document in Firestore with the default fields
      await _firestoreService.createFamilyDocument(
        userCredential.user!.uid,
        [],
        0.0, // Assuming an initial value for caloriesRequired
      );



    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      // Handle errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () => _register(context),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
