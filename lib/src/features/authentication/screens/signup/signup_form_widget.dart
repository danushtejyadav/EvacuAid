import "package:evacuaid/src/constants/colors.dart";
import "package:evacuaid/src/constants/sizes.dart";
import "package:evacuaid/src/constants/text_strings.dart";
import "package:evacuaid/src/features/authentication/controllers/signup_controller.dart";
import "package:evacuaid/src/features/authentication/models/user_model.dart";
import "package:evacuaid/src/features/core/screens/teecalculator/tee_calculator_page.dart";
import "package:flutter/material.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class SignupFormWidget extends StatelessWidget {
  const SignupFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final _formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: EvacFormHeight - 10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller.fullName,
              decoration: const InputDecoration(
                label: Text(EvacFullName),
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              style: const TextStyle(color: EvacSecondaryColor),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
            const SizedBox(height: EvacFormHeight - 20),
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                label: Text(EvacEmail),
                prefixIcon: Icon(Icons.mail_outline_rounded),
              ),
              style: const TextStyle(color: EvacSecondaryColor),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: EvacFormHeight - 20),
            TextFormField(
              controller: controller.phoneNumber,
              decoration: const InputDecoration(
                label: Text(EvacPhoneNumber),
                prefixIcon: Icon(Icons.phone_rounded),
              ),
              style: const TextStyle(color: EvacSecondaryColor),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: EvacFormHeight - 20),
            TextFormField(
              controller: controller.password,
              decoration: const InputDecoration(
                label: Text(EvacPassword),
                prefixIcon: Icon(Icons.fingerprint),
              ),
              style: const TextStyle(color: EvacSecondaryColor),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
            const SizedBox(height: EvacFormHeight - 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final user = UserModel(
                      fullName: controller.fullName.text.trim(),
                      email: controller.email.text.trim(),
                      phoneNumber: controller.phoneNumber.text.trim(),
                      password: controller.password.text.trim(),
                    );
                    controller.createUser(user, (String uid) {
                      // Navigate to TeeCalculatorPage after OTP verification
                      Get.to(() => TeeCalculatorPage(familyId: uid, editMode: false));
                    }).catchError((error) {
                      // Handle error, e.g., show an error message
                      print('Registration error: $error');
                    });
                  }
                },
                child: Text(EvacSignup.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}