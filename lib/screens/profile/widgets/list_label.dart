import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class ListLabel extends StatelessWidget {
  const ListLabel({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.charcoalGray,
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 21 / 14,
        letterSpacing: 0.3,
      ),
    );
  }
}
