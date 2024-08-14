import 'package:flutter/material.dart';

class ListData extends StatelessWidget {
  const ListData({
    super.key,
    required this.textEditingController,
    required this.readOnly,
    required this.keyboardType,
  });

  final TextEditingController textEditingController;
  final bool readOnly;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        controller: textEditingController,
        readOnly: readOnly,
        textAlign: TextAlign.right,
        keyboardType: keyboardType,
        textCapitalization: TextCapitalization.words,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        scrollPadding: EdgeInsets.zero,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 21 / 14,
          letterSpacing: 0.3,
        ),
        decoration: const InputDecoration(
          constraints: BoxConstraints(
            maxHeight: 30,
          ),
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
