import 'package:flutter/material.dart';
import 'package:food_couriers/components/space_vertical.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({
    super.key,
    required this.image1,
    required this.image2,
    required this.headingText1,
    required this.headingText2,
    required this.subHeadingText1,
    required this.subHeadingText2,
    required this.subHeadingText3,
    required this.subHeadingStyle,
    required this.onTap,
    required this.buttonText,
    required this.onBoarding2,
  });

  final String image1,
      image2,
      headingText1,
      headingText2,
      subHeadingText1,
      subHeadingText2,
      subHeadingText3,
      buttonText;
  final TextStyle subHeadingStyle;
  final bool onBoarding2;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(image1),
        onBoarding2
            ? const SizedBox(
                height: 15,
              )
            : const SizedBox.shrink(),
        Image.asset(image2),
        const SpaceVertical(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$headingText1\n',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        height: 28.83 / 22,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: headingText2,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        height: 28.83 / 22,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SpaceVertical(),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: subHeadingStyle,
                  children: [
                    TextSpan(
                      text: '$subHeadingText1\n',
                    ),
                    TextSpan(
                      text: '$subHeadingText2\n',
                    ),
                    TextSpan(
                      text: subHeadingText3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SpaceVertical(),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 157,
            height: 57,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              gradient: AppColors.gradientPrimary,
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                fontFamily: 'Roboto',
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                height: 20.96 / 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
