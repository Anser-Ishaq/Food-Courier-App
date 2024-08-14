import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class PfpBox extends StatelessWidget {
  const PfpBox({
    super.key,
    required this.imageURL,
    required this.onTap,
  });

  final String imageURL;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 14),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            gradient: AppColors.gradientSecondary,
            shape: BoxShape.circle,
          ),
          child: SizedBox(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(imageURL),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 0,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: AppColors.white,
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignCenter)),
              child: const Icon(
                Icons.mode_edit_outlined,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
