import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class AttachmentButton extends StatelessWidget {
  const AttachmentButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: AppColors.gradientSecondary,
          borderRadius: BorderRadius.circular(7),
        ),
        child: const Icon(
          Icons.attach_file_rounded,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
