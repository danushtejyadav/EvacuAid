import "package:evacuaid/src/constants/image_strings.dart";
import "package:evacuaid/src/constants/sizes.dart";
import "package:evacuaid/src/constants/text_strings.dart";
import "package:evacuaid/src/features/authentication/screens/login/login_footer_widget.dart";
import "package:evacuaid/src/features/authentication/screens/login/login_form_widget.dart";
import "package:evacuaid/src/features/authentication/screens/login/login_header_widget.dart";
import "package:flutter/material.dart";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(EvacDefaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormHeaderWidget(
                      image: EvacWelcomeImage1,
                      title: EvacLoginTitle,
                      subTitle: EvacLoginSubTitle,
                  ),
                  LoginForm(),
                  LoginFooterWidget(context)
                ],
              )),
        ),
      ),
    );
  }


}
