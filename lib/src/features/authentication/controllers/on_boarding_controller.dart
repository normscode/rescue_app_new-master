import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:rescue_app/src/constants/colors.dart';
import 'package:rescue_app/src/constants/image_strings.dart';
import 'package:rescue_app/src/constants/text_strings.dart';
import 'package:rescue_app/src/features/authentication/screens/on_boarding/on_boarding_page_widget.dart';
import 'package:rescue_app/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/model_on_boarding.dart';

class OnBoardingController extends GetxController {
  final controller = LiquidController();
  RxInt currentPage = 0.obs;
  bool get isLastPage => currentPage.value == pages.length - 1;

  final pages = [
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: rOnBoardingImage1,
        title: rOnBoardingTitle1,
        subTitle: rOnBoardingSubTitle1,
        counterText: rOnBoardingCounter1,
        bgColor: rOnBoardingPage1Color,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: rOnBoardingImage2,
        title: rOnBoardingTitle2,
        subTitle: rOnBoardingSubTitle2,
        counterText: rOnBoardingCounter2,
        bgColor: rOnBoardingPage2Color,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: rOnBoardingImage3,
        title: rOnBoardingTitle3,
        subTitle: rOnBoardingSubtitle3,
        counterText: rOnBoardingCounter3,
        bgColor: rOnBoardingPage3Color,
      ),
    ),
  ];

  onPageChangedCallback(int activePageIndex) {
    currentPage.value = activePageIndex;
  }

  skip() => controller.jumpToPage(page: 2);

  animateToNextSlide() async {
    int nextPage = controller.currentPage + 1;

    if (isLastPage) {
      Get.to(() => const WelcomeScreen());
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setBool('showWelcome', true);
    } else {
      controller.animateToPage(page: nextPage);
    }
  }
}
