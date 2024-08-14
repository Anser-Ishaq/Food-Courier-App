import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class FilterButton extends StatelessWidget {
  final bool isSelected;
  final String label;
  final String imageURL;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.isSelected,
    required this.label,
    required this.imageURL,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(7.0),
          border: isSelected
              ? const Border.symmetric()
              : Border.all(
                  color: AppColors.red,
                  width: 0.7,
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageURL,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 18,
                letterSpacing: -0.03,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
