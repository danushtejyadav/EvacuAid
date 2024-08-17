import "package:evacuaid/src/constants/image_strings.dart";
import "package:evacuaid/src/constants/sizes.dart";
import "package:evacuaid/src/constants/text_strings.dart";
import "package:evacuaid/src/features/authentication/screens/login/login_header_widget.dart";
import "package:evacuaid/src/features/authentication/screens/login/login_screen.dart";
import "package:evacuaid/src/features/authentication/screens/signup/signup_form_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:get/get.dart";

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(EvacDefaultSize),
                child: Column(
                    children: [
                    FormHeaderWidget(
                    image: EvacWelcomeImage1,
                    title: EvacSignupTitle,
                    subTitle: EvacSignupSubTitle),
                SignupFormWidget(),
                Column(
                  children: [
                    Text("OR", style: TextStyle(color: Colors.black),),
                    SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: SvgPicture.asset(EvacGoogleLogo, width: 20,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),),
                        label: Text(EvacSignInWithGoogle.toUpperCase(),
                        ),
                      ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Get.to(() => LoginScreen());
                        },
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text:EvacAlreadyHaveAccount, style: Theme.of(context).textTheme.bodyMedium!.merge(TextStyle(color: Colors.black))),
                              TextSpan(text: EvacLogin.toUpperCase(), style: TextStyle(color: Colors.blue)),
                            ],
                          ),
                        ),
                      ),
                      ],
                    )
                  ],
                ),
              ))),
    );
  }
}
