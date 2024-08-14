import 'package:flutter/material.dart';

class PopularMealButton extends StatelessWidget {
  const PopularMealButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Popular Meal Menu',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'See All',
                  style: TextStyle(
                    color: Color.fromRGBO(59, 59, 59, 0.5),
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.arrow_right,
                  size: 24,
                  color: Color.fromRGBO(59, 59, 59, .5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
