import 'package:flutter/material.dart';

class TotalRow extends StatelessWidget {
  const TotalRow({
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
              fontFamily: 'Roboto',
              fontSize: 18,
              fontWeight: FontWeight.w900,
              height: 21.09 / 18,
              letterSpacing: 0.64,
            ),
          ),
          Text(
            '$ammount \$',
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFFFEFEFF),
              fontFamily: 'Roboto',
              fontSize: 18,
              fontWeight: FontWeight.w900,
              height: 21.09 / 18,
              letterSpacing: 0.64,
            ),
          ),
        ],
      ),
    );
  }
}
