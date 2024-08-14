import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';


class CurrentLocationButton extends StatelessWidget {
  const CurrentLocationButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Material(
            child: InkWell(
              onTap: onTap,
              child: const Padding(
                padding: EdgeInsets.all(13),
                child: Icon(
                  Icons.my_location_rounded,
                  color: AppColors.red,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
