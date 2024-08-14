import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 14, bottom: 9),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            color: AppColors.white,
            fontFamily: 'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.w900,
            height: 24 / 16,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
