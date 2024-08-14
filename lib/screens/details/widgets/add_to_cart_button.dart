import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              offset: const Offset(11, 28),
              blurRadius: 50,
              color: const Color(0xFF144E5A).withOpacity(0.2),
            )
          ],
        ),
        child: const Text(
          'Add To Cart',
          style: TextStyle(
            color: AppColors.white,
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            height: 21 / 14,
          ),
        ),
      ),
    );
  }
}
