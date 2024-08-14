import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({
    super.key, required this.onTap,
  });

  final void Function(bool) onTap;

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool _isSwitched = false;

  void _switchButton() {
    setState(() {
      _isSwitched = !_isSwitched;
      widget.onTap(_isSwitched);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 24,
      child: AnimatedContainer(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 600),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: _isSwitched
              ? AppColors.gradientPrimary
              : AppColors.gradientSecondary,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 600),
              left: _isSwitched ? 21 : 1,
              right: _isSwitched ? 1 : 21,
              top: 2,
              bottom: 2,
              child: GestureDetector(
                onTap: _switchButton,
                child: AnimatedContainer(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 600),
                  decoration: BoxDecoration(
                    color:
                        _isSwitched ? AppColors.white : AppColors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
