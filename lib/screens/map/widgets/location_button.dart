import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({
    super.key,
    required this.buttonText,
    this.isLoading = false,
    required this.onTap,
  });

  final String buttonText;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: AppColors.gradientPrimary,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowBlue,
              blurRadius: 50,
            ),
          ],
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                  strokeWidth: 2,
                ),
              )
            : Text(
                buttonText,
                style: const TextStyle(
                  color: AppColors.white,
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 21 / 14,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }
}
