import 'package:flutter/material.dart';
import 'package:food_couriers/constants/images/images.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 256,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F4F4),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.google,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 24),
            Text(
              buttonText,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 21 / 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
