import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class BotIcon extends StatelessWidget {
  const BotIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.smart_toy_outlined,
          color: AppColors.white,
        ));
  }
}
