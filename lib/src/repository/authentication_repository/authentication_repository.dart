import "package:evacuaid/src/features/authentication/screens/forgot_password/forgot_password_otp/otp_screen.dart";
import "package:evacuaid/src/features/authentication/screens/welcome/welcome_screen.dart";
import "package:evacuaid/src/features/core/screens/dashboard/dashboard.dart";
import "package:evacuaid/src/features/core/screens/teecalculator/tee_calculator_page.dart";
import "package:evacuaid/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const WelcomeScreen()) : Get.offAll(() =>
        OtpScreen());
  }

  void phoneAuthentication(String phoneNo, String uid) async{
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credential) async{
          await _auth.signInWithCredential(credential);
          // Get.to(()=> TeeCalculatorPage(familyId: uid, editMode: false));
        },
        verificationFailed: (e){
          if(e.code == 'invalid-phone-number'){
            Get.snackbar("Error", "The provided phone number is not valid");
          } else {
            Get.snackbar("Error", e.toString());
          }
        },
        codeSent: (verificationId, resendToken){
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId){
          this.verificationId.value = verificationId;
        }
    );
  }

  Future<bool> verifyOTP(String OTP) async {
    var credentials = await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: OTP));
    return credentials.user != null ? true : false;
  }


  void createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => OtpScreen()) : Get
          .to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignupEmailPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION: ${ex.message}');
      throw ex;
    } catch (_) {
      final ex = SignupEmailPasswordFailure();
      print('FIREBASE AUTH EXCEPTION: ${ex.message}');
      throw ex;
    }
  }

  void signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => Dashboard()) : Get
          .to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString());
    } catch (_) {}
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}