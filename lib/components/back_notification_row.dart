import 'package:flutter/material.dart';
import 'package:food_couriers/components/icon_button_box.dart';

class BackNotificationRow extends StatelessWidget {
  const BackNotificationRow({
    super.key,
    required this.index,
    required this.onTapBack,
    required this.onTapNotification,
  });

  final int index;
  final VoidCallback onTapBack;
  final VoidCallback onTapNotification;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButtonBox(
            icon: Icons.arrow_back_ios_rounded,
            onTap: onTapBack,
          ),
          IconButtonBox(
            icon: Icons.notifications_none_rounded,
            onTap: onTapNotification,
          ),
        ],
      ),
    );
  }
}
