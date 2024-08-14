import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';
import 'package:food_couriers/constants/images/images.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.onTap,
    required this.onTapLocation,
  });

  final VoidCallback onTap;
  final VoidCallback onTapLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.menu,
            ),
          ),
          GestureDetector(
            onTap: onTapLocation,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.red,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  'Set Location....',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 28 / 12,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                Images.person,
                width: 32,
                height: 32,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
