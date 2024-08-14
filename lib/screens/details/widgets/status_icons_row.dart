import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';
import 'package:food_couriers/screens/details/widgets/round_icon.dart';

class StatusIconsRow extends StatelessWidget {
  const StatusIconsRow({
    super.key,
    required this.status,
    required this.onTapLocation,
    required this.isFavorite,
    required this.onTapFavorite,
  });

  final String status;
  final VoidCallback onTapLocation;
  final bool isFavorite;
  final VoidCallback onTapFavorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: AppColors.primary,
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 15.72 / 12,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundIcon(
                icon: const Icon(
                  Icons.location_on,
                  color: AppColors.primary,
                ),
                color: AppColors.red.withOpacity(0.1),
                onTap: onTapLocation,
              ),
              const SizedBox(width: 12),
              RoundIcon(
                icon: Icon(
                  Icons.favorite,
                  color: isFavorite ? AppColors.primary :AppColors.black,
                ),
                color: AppColors.black.withOpacity(0.1),
                onTap: onTapFavorite,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
