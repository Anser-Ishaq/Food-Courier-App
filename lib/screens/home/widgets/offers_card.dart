import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class OffersCard extends StatelessWidget {
  const OffersCard({
    super.key,
    required this.imageURL,
    required this.heading,
    required this.subheading,
    required this.buttonText,
    required this.onTap,
  });

  final String imageURL, heading, subheading, buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        gradient: AppColors.gradientCard,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(
            imageURL,
          ),
          alignment: const Alignment(1, 1),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 25,
            left: 22,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    height: 14.63 / 16,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  subheading,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    height: 9.1 / 8,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 22,
            bottom: 15,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: AppColors.white,
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    height: 9.1 / 8,
                    color: AppColors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
