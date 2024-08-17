import "package:evacuaid/src/constants/colors.dart";
import "package:evacuaid/src/constants/image_strings.dart";
import "package:evacuaid/src/constants/sizes.dart";
import "package:evacuaid/src/constants/text_strings.dart";
import "package:evacuaid/src/features/authentication/screens/splash_screen/splash_screen.dart";
import "package:evacuaid/src/features/core/screens/profile/update_profile_screen.dart";
import "package:evacuaid/src/features/core/screens/profile/widgets/profile_menu.dart";
import "package:evacuaid/src/features/core/screens/teecalculator/tee_calculator_page.dart";
import "package:evacuaid/src/repository/authentication_repository/authentication_repository.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:line_awesome_flutter/line_awesome_flutter.dart";
import "package:shared_preferences/shared_preferences.dart";

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(LineAwesomeIcons.angle_left_solid)),
        title: Text(EvacProfile, style: Theme.of(context).textTheme.bodyLarge!.merge(TextStyle(color: Colors.white)),),
        actions: [IconButton(onPressed: (){}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))],
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
                      borderRadius: BorderRadius.circular(100), child: const Image(image: AssetImage(EvacProfileImage)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: EvacPrimaryColor,
                      ),
                      child: Icon(LineAwesomeIcons.pencil_alt_solid, size: 20.0, color: Colors.white ,),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Text(EvacProfileTitle, style: Theme.of(context).textTheme.headlineMedium),
              Text(EvacProfileSubTitle, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20,),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => UpdateProfileScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: EvacPrimaryColor, side: BorderSide.none, shape: const StadiumBorder()
                  ),
                  child: const Text(EvacEditProfile, style: TextStyle(color: Colors.black),
                  )
                ),
              ),
              const SizedBox(height: 30,),
              const Divider(),
              const SizedBox(height: 10,),

              ProfileMenuWidget(title: "Settings", icon: LineAwesomeIcons.cog_solid, textColor: Colors.white, onPress: (){}),
              ProfileMenuWidget(title: "Billing Details", icon: LineAwesomeIcons.wallet_solid, textColor: Colors.white, onPress: (){}),
              ProfileMenuWidget(title: "User Management", icon: LineAwesomeIcons.user_check_solid, textColor: Colors.white, onPress: (){
              }),
              const Divider(color: Colors.grey,),
              ProfileMenuWidget(title: "Information", icon: LineAwesomeIcons.info_solid, textColor: Colors.white, onPress: (){}),
              ProfileMenuWidget(title: "Logout", icon: LineAwesomeIcons.sign_out_alt_solid, textColor: Colors.red, endIcon: false, onPress: (){
                SharedPreferences.getInstance().then((prefs) => prefs.setBool("hasSeenOnBoarding", false));
                Get.to(() => SplashScreen());
                AuthenticationRepository.instance.logout();
              }),
            ],
          ),
        ),
      ),
    );
  }
}

