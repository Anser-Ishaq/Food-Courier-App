import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class TextInputBox extends StatelessWidget {
  const TextInputBox({
    super.key,
    required this.textEditingController,
    required this.onTap,
  });

  final TextEditingController textEditingController;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: const Color(0xFFF9FAFB),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: textEditingController,
              minLines: 1,
              maxLines: 5,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 21 / 14,
                letterSpacing: 0.3,
              ),
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                // hintText: 'Enter your text....',
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Icon(
                Icons.double_arrow_rounded,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
