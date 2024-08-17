import "package:evacuaid/src/features/core/screens/dashboard/dashboard.dart";
import "package:evacuaid/src/features/core/screens/teecalculator/tee_calculator_page.dart";
import "package:evacuaid/src/features/onboardflow/screens/register/register_screen.dart";
import "package:evacuaid/src/repository/authentication_repository/authentication_repository.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";

class OtpController extends GetxController {
  static OtpController get instance => Get.find();

  Future<String?> getUserUID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userUID');
  }

  void verifyOtp(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    String? uid = await getUserUID();

    isVerified ? Get.offAll(() => TeeCalculatorPage(familyId: uid!,editMode: false)) : Get.back();
  }
}