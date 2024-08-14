import 'package:flutter/material.dart';
import 'package:food_couriers/constants/routes/routes.dart';
import 'package:food_couriers/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';
import 'package:food_couriers/constants/images/images.dart';
import 'package:food_couriers/screens/onboarding/widgets/onboarding_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final GetIt _getIt = GetIt.instance;

  final PageController _pageController = PageController(initialPage: 0);

  bool onLastScreen = false;

  late NavigationService _navigationService;
  late List<Widget> _onBoardingScreens;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
    _onBoardingScreens = [
      OnBoardingView(
        image1: Images.onBoarding1Pattern,
        image2: Images.onBoarding1illustration,
        headingText1: 'Select the',
        headingText2: 'Favorities Menu',
        subHeadingText1: 'Now eat well, don\'t leave the house, You can ',
        subHeadingText2: 'choose your favorite food only with',
        subHeadingText3: 'one click',
        subHeadingStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 14.4 / 12,
          color: Colors.black,
        ),
        buttonText: 'Next',
        onTap: () {
          _pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linear,
          );
        },
        onBoarding2: false,
      ),
      OnBoardingView(
        image1: Images.onBoarding2Pattern,
        image2: Images.onBoarding2illustration,
        headingText1: 'Good food at a',
        headingText2: 'cheap price',
        subHeadingText1: 'You can eat at expensive',
        subHeadingText2: 'restaurants with',
        subHeadingText3: 'affordable price',
        subHeadingStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 21 / 14,
          color: Colors.black,
        ),
        buttonText: 'Done',
        onTap: navigateToMain,
        onBoarding2: true,
      ),
    ];
  }

  void navigateToMain() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);

    _navigationService.pushReplacementNamed(Routes.auth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: _onBoardingScreens,
            onPageChanged: (index) {
              setState(() {
                onLastScreen = (index == _onBoardingScreens.length - 1);
              });
            },
          ),
          Container(
            alignment: const Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: navigateToMain,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 24 / 16,
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _onBoardingScreens.length,
                  effect: const ScrollingDotsEffect(
                    activeDotColor: AppColors.primary,
                    dotColor: AppColors.inactiveDotColor,
                    dotHeight: 12,
                    dotWidth: 12,
                  ),
                  onDotClicked: (index) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                ),
                GestureDetector(
                  onTap: () {
                    if (onLastScreen) {
                      navigateToMain();
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: AppColors.primary,
                    size: 27,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
