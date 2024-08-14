import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.ratings,
    required this.imageURL,
    required this.name,
    required this.ingredients,
    required this.price,
    required this.onTapAdd,
    required this.onTapCard,
  });

  final double ratings;
  final String imageURL;
  final String name;
  final List<String> ingredients;
  final double price;
  final VoidCallback onTapAdd;
  final VoidCallback onTapCard;

  @override
  Widget build(BuildContext context) {
    final priceString = price.toStringAsFixed(2);
    final parts = priceString.split('.');

    return GestureDetector(
      onTap: onTapCard,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 131,
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: AppColors.yellow,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$ratings',
                    style: const TextStyle(
                      color: Color(0xFF0D0D0D),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      letterSpacing: -0.03,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 76,
              child: Image.asset(imageURL),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 131,
              child: Text(
                name,
                maxLines: 1,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 22.5 / 15,
                  letterSpacing: -0.03,
                ),
              ),
            ),
            SizedBox(
              width: 131,
              child: Text(
                ingredients.join(' + '),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                  fontFamily: 'Roboto',
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  height: 11.72 / 10,
                  letterSpacing: -0.03,
                ),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 131,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '\$ ${parts[0]}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.03,
                            color: AppColors.primary,
                          ),
                        ),
                        TextSpan(
                          text: '.${parts[1]}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.03,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onTapAdd,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
