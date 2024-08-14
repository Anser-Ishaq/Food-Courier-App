import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class RatingsOrderRow extends StatelessWidget {
  const RatingsOrderRow({
    super.key,
    required this.rating,
    required this.orderCount,
  });

  final double rating;
  final int orderCount;

  String formatOrderCount(int count) {
    const int stepSize = 500;

    int roundedCount;
    if (count < stepSize) {
      return count.toString();
    } else if (count >= 10000) {
      roundedCount = (count / 1000).round() * 1000;
    } else {
      roundedCount = ((count + stepSize - 1) ~/ stepSize) * stepSize;
    }

    return '$roundedCount+';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          const Icon(
            Icons.star_half_outlined,
            color: Color(0xFFFF9f06),
          ),
          const SizedBox(width: 10),
          text('${rating.toStringAsFixed(1).replaceAll('.', ',')} Rating'),
          const SizedBox(width: 15),
          const Icon(
            Icons.add_shopping_cart,
            color: AppColors.primary,
          ),
          const SizedBox(width: 10),
          text('${formatOrderCount(orderCount)} Order'),
        ],
      ),
    );
  }

  Text text(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.charcoalGray.withOpacity(0.3),
      ),
    );
  }
}
