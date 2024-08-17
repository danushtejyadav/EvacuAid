import "package:evacuaid/src/constants/image_strings.dart";
import "package:evacuaid/src/constants/sizes.dart";
import "package:evacuaid/src/constants/text_strings.dart";
import "package:evacuaid/src/features/authentication/screens/signup/signup_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:get/get.dart";

Column LoginFooterWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "OR",
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .merge(TextStyle(color: Colors.black)),
      ),
      SizedBox(height: 10.0,),
      SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
            icon: SvgPicture.asset(
              EvacGoogleLogo,
              width: 20.0,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            onPressed: () {},
            label: Text(EvacSignInWithGoogle)),
      ),
      const SizedBox(height: EvacFormHeight - 20),
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          Get.to(() => SignupScreen());
        },
        child: Text.rich(
          TextSpan(
              text: EvacDontHaveAccount,
              style: Theme.of(context).textTheme.bodyMedium!.merge(TextStyle(color: Colors.black)),
              children: [
                TextSpan(
                  text: EvacSignup.toUpperCase(),
                  style: TextStyle(color: Colors.blue),
                )
              ]
          ),
        ),
      ),
    ],
  );
}