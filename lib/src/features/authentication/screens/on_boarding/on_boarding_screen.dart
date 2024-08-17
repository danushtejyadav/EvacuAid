import "package:evacuaid/src/constants/colors.dart";
import "package:evacuaid/src/features/authentication/controllers/on_board_controller.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:liquid_swipe/liquid_swipe.dart";
import "package:smooth_page_indicator/smooth_page_indicator.dart";

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final obcontroller = Get.put(OnBoardController());
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
          body: Stack(
            alignment: Alignment.center,
            children: [
              LiquidSwipe(
                pages: obcontroller.pages,
                liquidController: obcontroller.controller,
                onPageChangeCallback: obcontroller.onPageChangedCallback,
                slideIconWidget: const Icon(Icons.arrow_back_ios_new,color: Colors.black,),
                enableSideReveal: true,
              ),
              Positioned(
                bottom: 60.0,
                child: OutlinedButton(
                  onPressed: () => obcontroller.animateToNextSlide(),
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.white,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      color: EvacSecondaryColor, shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                )
              ),
              Positioned(
                top:20,
                right: 20,
                child: Obx(() => Visibility(
                  visible: !obcontroller.isLastPage.value,
                  child: TextButton(
                    onPressed: () => obcontroller.skip(),
                    child: const Text("Skip", style: TextStyle(color: Colors.grey)),
                  ),
                ),
                ),
              ),
              Obx(
                () => Positioned(
                  bottom: 10,
                  child: AnimatedSmoothIndicator(
                    activeIndex: obcontroller.currentPage.value,
                    count: 3,
                    effect: const WormEffect(
                      activeDotColor: EvacAccentColor,
                      dotHeight: 5.0,
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }


}