import 'package:flutter/material.dart';

class ItemRow extends StatelessWidget {
  const ItemRow({
    super.key,
    required this.text,
    required this.ammount,
  });

  final String text;
  final double ammount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFFFEFEFF),
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 21 / 14,
              letterSpacing: 0.5,
            ),
          ),
          Text(
            '$ammount \$',
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFFFEFEFF),
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 21 / 14,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
