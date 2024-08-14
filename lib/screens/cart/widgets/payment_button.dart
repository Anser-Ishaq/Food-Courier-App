import 'package:flutter/material.dart';
import 'package:food_couriers/components/gradient_text.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({
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
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFEFEFF),
          borderRadius: BorderRadius.circular(7),
        ),
        child: GradientText(
          text: 
          buttonText,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            height: 21 / 14,
            letterSpacing: 0.5,
          ),
          gradient: AppColors.gradientPrimary,
        ),
      ),
    );
  }
}
