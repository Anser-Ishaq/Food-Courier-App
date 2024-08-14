import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    required this.isLoading,
  });

  final String buttonText;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: 256,
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: AppColors.gradientPrimary,
          borderRadius: BorderRadius.circular(7),
        ),
        child: isLoading
            ? const SizedBox(
              height: 17,
              width: 17,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
            )
            : Text(
                buttonText,
                style: const TextStyle(
                  color: AppColors.white,
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  height: 16.41 / 14,
                ),
              ),
      ),
    );
  }
}
