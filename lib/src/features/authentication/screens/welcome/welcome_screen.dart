import "package:evacuaid/src/constants/image_strings.dart";
import "package:evacuaid/src/constants/sizes.dart";
import "package:evacuaid/src/constants/text_strings.dart";
import "package:evacuaid/src/features/authentication/screens/login/login_screen.dart";
import "package:evacuaid/src/features/authentication/screens/signup/signup_screen.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var brightness = MediaQuery.of(context).platformBrightness;

    final isDarkMode = brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        final shouldPop = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Exit"),
            content: Text("Are you sure you want to exit?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("No"),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text("Yes"),
              ),
            ],
          ),
        );
        return shouldPop ?? false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: isDarkMode ? Colors.white : Colors.white,
          body: Container(
            padding: EdgeInsets.all(EvacDefaultSize),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                    image: AssetImage(EvacWelcomeImage1), height: height * 0.5),
                Column(
                  children: [
                    Text(
                      EvacWelcomeTitle,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .merge(TextStyle(color: Colors.black)),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      EvacWelcomeSubTitle,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .merge(TextStyle(color: Colors.black)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () => Get.to(() => LoginScreen()),
                            child: Text(EvacLogin.toUpperCase()))),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () => Get.to(() => SignupScreen()),
                            child: Text(EvacSignup.toUpperCase()))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
