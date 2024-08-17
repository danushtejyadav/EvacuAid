import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:evacuaid/src/repository/firebase_repository/firestore_service/firestore_service.dart';
import 'package:evacuaid/src/features/core/screens/teecalculator/tee_calculator_page.dart';
import 'package:evacuaid/src/features/authentication/models/user_model.dart';
import 'package:evacuaid/src/repository/authentication_repository/authentication_repository.dart';
import 'package:evacuaid/src/repository/user_repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNumber = TextEditingController();

  final userRepo = Get.put(UserRepository());
  final FirestoreService _firestoreService = FirestoreService();
  final Location _location = Location();

  void registerUser(String email, String password) {
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }

  void phoneAuthentication(String phoneNo, String uid) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo, uid);
  }

  Future<void> saveUserUID(String uid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userUID', uid);
  }

  Future<void> createUser(UserModel user, Function(String) onOtpVerified) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      await saveUserUID(userCredential.user!.uid);

      LocationData locationData = await _location.getLocation();

      await _firestoreService.createFamilyDocument(
        userCredential.user!.uid,
        [],
        0.0,
      );

      phoneAuthentication(user.phoneNumber, userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
    }
  }
}