import 'package:flutter/material.dart';

class RoundIcon extends StatelessWidget {
  const RoundIcon({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final Icon icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: icon,
      ),
    );
  }
}
