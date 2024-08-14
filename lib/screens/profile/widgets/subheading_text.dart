import 'package:flutter/material.dart';

class SubheadingText extends StatelessWidget {
  const SubheadingText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10, bottom: 3,),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          height: 24 / 16,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
