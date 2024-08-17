import "package:evacuaid/src/constants/colors.dart";
import "package:evacuaid/src/constants/image_strings.dart";
import "package:evacuaid/src/constants/sizes.dart";
import "package:evacuaid/src/constants/text_strings.dart";
import "package:evacuaid/src/features/authentication/controllers/splash_screen_controller.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

import "../welcome/welcome_screen.dart";

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      splashController.startAnimation();
    });

    splashController.startAnimation();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children:  [
            Obx(
              () => AnimatedPositioned(
                duration: const Duration(milliseconds: 1600),
                top: splashController.animate.value ? 0 : -30,
                left: splashController.animate.value ? 0 : -30,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 1600),
                  opacity: splashController.animate.value ? 1 : 0,
                  child: const Image(
                    height: 150,
                    width: 150,
                    image: AssetImage(EvacSplashTop),
                  ),
                ),
              ),
            ),
            Obx(
              () => AnimatedPositioned(
                duration: const Duration(milliseconds: 1600),
                top: 150,
                left: splashController.animate.value ? EvacDefaultSize : -20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 1600),
                  opacity: splashController.animate.value ? 1 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(EvacAppName, style: Theme.of(context).textTheme.headlineLarge),
                      Text(EvacAppTagLine, style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                )
              ),
            ),
            Obx(
            () => AnimatedPositioned(
                duration: const Duration(milliseconds: 1600),
                height: 400,
                width: 400,
                bottom: splashController.animate.value ? 80 : -20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 1600),
                  opacity: splashController.animate.value ? 1 : 0,
                  child: Image(
                    image: AssetImage(EvacSplashMainImage),
                  ),
                ),
              ),
            ),
            Obx(
              () => AnimatedPositioned(
                duration: const Duration(milliseconds: 1600),
                bottom: splashController.animate.value ? 40 : -20,
                right: EvacDefaultSize,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 1600),
                  opacity: splashController.animate.value ? 1 : 0,
                  child: Container(
                    width: EvacSplashContainerSize,
                    height: EvacSplashContainerSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: EvacPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }


}
