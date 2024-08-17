import "package:evacuaid/src/constants/colors.dart";
import "package:evacuaid/src/constants/image_strings.dart";
import "package:evacuaid/src/constants/text_strings.dart";
import "package:evacuaid/src/features/authentication/models/model_on_boarding.dart";
import "package:evacuaid/src/features/authentication/screens/on_boarding/on_boarding_page_widget.dart";
import "package:evacuaid/src/features/authentication/screens/welcome/welcome_screen.dart";
import "package:get/get.dart";
import "package:liquid_swipe/PageHelpers/LiquidController.dart";
import "package:shared_preferences/shared_preferences.dart";

class OnBoardController extends GetxController {

  final controller = LiquidController();
  RxInt currentPage = 0.obs;
  RxBool isLastPage = false.obs;

  final pages = [
    OnBoardingPageWidget(model: OnBoardingModel(
      image: EvacOnBoardImage1,
      title: EvacOnBoardTitle1,
      subTitle: EvacOnBoardSubTitle1,
      counterText: EvacOnBoardCounter1,
      bgColor: EvacOnboardP1Color,
    )),
    OnBoardingPageWidget(model: OnBoardingModel(
      image: EvacOnBoardImage2,
      title: EvacOnBoardTitle2,
      subTitle: EvacOnBoardSubTitle2,
      counterText: EvacOnBoardCounter2,
      bgColor: EvacOnboardP2Color,
    )),
    OnBoardingPageWidget(model: OnBoardingModel(
      image: EvacOnBoardImage3,
      title: EvacOnBoardTitle3,
      subTitle: EvacOnBoardSubTitle3,
      counterText: EvacOnBoardCounter3,
      bgColor: EvacOnboardP3Color,
    )),
  ];

  void onPageChangedCallback(int activePageIndex) {
    if(isLastPage.value){
      Get.to(() => WelcomeScreen());
      SharedPreferences.getInstance().then((prefs) => prefs.setBool("hasSeenOnBoarding", true));
    } else {
      currentPage.value = activePageIndex;
      isLastPage.value = activePageIndex == pages.length - 1;
    }
  }

  skip() => controller.jumpToPage(page: 2);

  animateToNextSlide() {
    if(isLastPage.value){
      Get.to(() => WelcomeScreen());
      SharedPreferences.getInstance().then((prefs) => prefs.setBool("hasSeenOnBoarding", true));
    } else {
      int nextPage = controller.currentPage + 1;
      controller.animateToPage(page: nextPage);
    }
  }
}