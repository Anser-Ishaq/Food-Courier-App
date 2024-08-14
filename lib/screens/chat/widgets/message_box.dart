import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.message,
    required this.uid,
  });

  final Map<String, dynamic> message;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: message['sender'] == uid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(16),
              bottomRight: const Radius.circular(16),
              topLeft: message['sender'] == uid
              ? const Radius.circular(16)
              : const Radius.circular(0),
              topRight: message['sender'] == uid
              ? const Radius.circular(0)
              : const Radius.circular(16),
            ),
            gradient: message['sender'] == uid
                ? AppColors.gradientPrimary
                : const LinearGradient(colors: [
                    Color(0xFFF6F6F6),
                    Color(0xFFF6F6F6),
                  ]),
          ),
          padding: const EdgeInsets.all(12.0),
          child: Text(
            message['text'],
            style: TextStyle(
              color: message['sender'] == uid ? AppColors.white : AppColors.black,
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 21 / 14,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
