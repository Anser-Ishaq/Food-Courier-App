import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class IconButtonBox extends StatelessWidget {
  const IconButtonBox({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: AppColors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Icon(
          icon,
          color: AppColors.red,
          size: 24,
        ),
      ),
    );
  }
}
