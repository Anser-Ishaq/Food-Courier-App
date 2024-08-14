import 'package:flutter/material.dart';
import 'package:food_couriers/components/gradient_text.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';
import 'package:food_couriers/models/food_item.dart';

class FoodItemBox extends StatefulWidget {
  const FoodItemBox({
    super.key,
    required this.foodItem,
    required this.onQuantityChanged,
  });

  final FoodItem foodItem;
  final void Function(int) onQuantityChanged;

  @override
  State<FoodItemBox> createState() => _FoodItemBoxState();
}

class _FoodItemBoxState extends State<FoodItemBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowBlue,
            offset: const Offset(12, 26),
            blurRadius: 50,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Image.asset(
              widget.foodItem.imageURL!,
              width: 62,
              height: 62,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 21),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.foodItem.name!,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    height: 19.65 / 15,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.foodItem.restaurantName!,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 21 / 14,
                    letterSpacing: 0.5,
                    color: Color.fromRGBO(59, 59, 59, 0.3),
                  ),
                ),
                GradientText(
                  text: '\$ ${widget.foodItem.price!.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    height: 24.89 / 19,
                  ),
                  gradient: AppColors.gradientPrimary,
                ),
              ],
            ),
          ),
          const SizedBox(width: 21),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _quantityButton(
                gradient: AppColors.gradientSecondary,
                icon: Icons.remove_rounded,
                iconColor: AppColors.red,
                onTap: () {
                  if (widget.foodItem.quantity! > 1) {
                    final newQuantity = widget.foodItem.quantity! - 1;
                    setState(() {
                      widget.foodItem.quantity = newQuantity;
                    });
                    widget.onQuantityChanged(newQuantity);
                  }
                },
              ),
              Container(
                width: 25,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${widget.foodItem.quantity}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 24 / 16,
                    letterSpacing: 0.57,
                  ),
                ),
              ),
              _quantityButton(
                gradient: AppColors.gradientPrimary,
                icon: Icons.add_rounded,
                iconColor: AppColors.white,
                onTap: () {
                  if (widget.foodItem.quantity! < 99) {
                    final newQuantity = widget.foodItem.quantity! + 1;
                    setState(() {
                      widget.foodItem.quantity = newQuantity;
                    });
                    widget.onQuantityChanged(newQuantity);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quantityButton({
    required LinearGradient gradient,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
