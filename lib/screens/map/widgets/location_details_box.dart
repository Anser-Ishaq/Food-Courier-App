import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';
import 'package:food_couriers/screens/map/widgets/location_button.dart';

class LocationDetailsBox extends StatelessWidget {
  const LocationDetailsBox({
    super.key,
    required this.locationAddress,
  });

  final String locationAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Your Location',
              style: TextStyle(
                color: AppColors.grey,
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 21 / 14,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          Row(
            children: [
              Container(
                width: 33,
                height: 33,
                decoration: const BoxDecoration(
                  gradient: AppColors.gradientSecondary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on,
                  color: AppColors.red,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  locationAddress,
                  style: const TextStyle(
                    color: Color(0xFF09051C),
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    height: 19.65 / 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          LocationButton(
            buttonText: 'Set Location',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
