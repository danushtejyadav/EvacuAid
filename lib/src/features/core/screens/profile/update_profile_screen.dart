import "package:evacuaid/src/constants/colors.dart";
import "package:evacuaid/src/constants/image_strings.dart";
import "package:evacuaid/src/constants/sizes.dart";
import "package:evacuaid/src/constants/text_strings.dart";
import "package:evacuaid/src/features/authentication/screens/splash_screen/splash_screen.dart";
import "package:evacuaid/src/features/core/screens/dashboard/dashboard.dart";
import "package:evacuaid/src/repository/authentication_repository/authentication_repository.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:line_awesome_flutter/line_awesome_flutter.dart";
import "package:shared_preferences/shared_preferences.dart";

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.offAll(() => Dashboard()),
              icon: Icon(LineAwesomeIcons.angle_left_solid)),
          title: Text(
            EvacEditProfile,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .merge(TextStyle(color: Colors.white)),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(EvacDefaultSize),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(image: AssetImage(EvacProfileImage)),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      height: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: EvacPrimaryColor,
                        ),
                        child: Icon(
                          LineAwesomeIcons.pencil_alt_solid,
                          size: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text(EvacFullName),
                          prefixIcon: Icon(LineAwesomeIcons.user_solid)),
                    ),
                    SizedBox(
                      height: EvacFormHeight - 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text(EvacEmail),
                          prefixIcon: Icon(LineAwesomeIcons.envelope_solid)),
                    ),
                    SizedBox(
                      height: EvacFormHeight - 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text(EvacPhoneNumber),
                          prefixIcon: Icon(LineAwesomeIcons.phone_solid)),
                    ),
                    SizedBox(
                      height: EvacFormHeight - 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text(EvacPassword),
                          prefixIcon: Icon(LineAwesomeIcons.fingerprint_solid)),
                    ),
                    const SizedBox(
                      height: EvacFormHeight,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: EvacPrimaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text(EvacSaveProfile,
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(
                      height: EvacFormHeight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(TextSpan(
                          text: "Joined on 23 July 2024",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          children: [
                            TextSpan(
                                text: " | ",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )),
                        ElevatedButton(
                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.redAccent.withOpacity(0.1),
                              elevation: 0,
                              foregroundColor: Colors.red,
                              shape: StadiumBorder(),
                              side: BorderSide.none),
                          child: const Text(EvacDeleteProfile),
                        ),
                      ],
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
