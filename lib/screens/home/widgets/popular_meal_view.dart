import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class PopularMealView extends StatelessWidget {
  const PopularMealView({
    super.key,
    required this.imageURL,
    required this.mealName,
    required this.description,
    required this.mealPrice,
  });

  final String imageURL;
  final String mealName;
  final String description;
  final double mealPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowBlue,
            blurRadius: 50,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Image.asset(
              imageURL,
              width: 64,
              height: 64,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 21),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mealName,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    height: 19.65 / 15,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: Color.fromRGBO(59, 59, 59, 0.3),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 21),
          Text(
            '\$ ${mealPrice.toStringAsFixed(0)}',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
