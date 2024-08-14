import 'package:flutter/material.dart';

class DividerBar extends StatelessWidget {
  const DividerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      margin: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: const Color(0xFFD2D4D8)
        ), 
      ),
    );
  }
}