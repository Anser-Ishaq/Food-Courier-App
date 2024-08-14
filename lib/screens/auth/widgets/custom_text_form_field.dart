import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.title,
    required this.onSaved,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    required this.validationRegEx,
    required this.textCapitalization,
  });

  final String title;
  final String hintText;
  final bool obscureText;
  final RegExp validationRegEx;
  final TextInputType keyboardType;
  final void Function(String?) onSaved;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    String error = '';
    if (title == 'Full Name') {
      error = 'name';
    } else if (title == 'Email address') {
      error = 'email';
    } else {
      error = 'password';
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title == 'Password1' ? 'Password' : title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 36 / 14,
              ),
            ),
          ),
          TextFormField(
            onSaved: onSaved,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field is required";
              }
              if (title == 'Password') {
                if (value.length < 8) {
                  return 'Must be at least 8 characters';
                }
                if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
                  return 'Must contain an uppercase letter';
                }
                if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
                  return 'Must contain a lowercase letter';
                }
                if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
                  return 'Must contain a number';
                }
                return null;
              } else if (!validationRegEx.hasMatch(value) && title != 'Password1') {
                return "Enter a valid ${error.toLowerCase()}";
              }
              return null;
            },
            obscureText: obscureText,
            obscuringCharacter: '*',
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            cursorHeight: 20,
            cursorRadius: const Radius.circular(7),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.grey,
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:
                    const BorderSide(color: AppColors.secondary, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:
                    const BorderSide(color: Color(0xFFF6F6F6), width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
