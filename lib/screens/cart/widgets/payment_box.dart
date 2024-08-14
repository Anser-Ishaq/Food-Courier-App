import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';
import 'package:food_couriers/constants/images/images.dart';
import 'package:food_couriers/screens/cart/widgets/item_row.dart';
import 'package:food_couriers/screens/cart/widgets/payment_button.dart';
import 'package:food_couriers/screens/cart/widgets/total_row.dart';

class PaymentBox extends StatelessWidget {
  const PaymentBox({
    super.key,
    required this.subTotal,
    required this.deliveryCharges,
    required this.discount,
    required this.onTap,
  });

  final double subTotal;
  final double deliveryCharges;
  final double discount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: AppColors.gradientPrimary,
        borderRadius: BorderRadius.circular(7),
        image: const DecorationImage(
          image: AssetImage(Images.paymentGroup),
          fit: BoxFit.fill,
          opacity: 0.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowBlue,
            offset: const Offset(12, 26),
            blurRadius: 50,
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 4,
          ),
          ItemRow(
            text: 'Sub-Total',
            ammount: subTotal,
          ),
          ItemRow(
            text: 'Delivery Charge',
            ammount: deliveryCharges,
          ),
          ItemRow(
            text: 'Discount',
            ammount: discount,
          ),
          const SizedBox(
            height: 20,
          ),
          TotalRow(
            text: 'Total',
            ammount: (subTotal + deliveryCharges - discount),
          ),
          const SizedBox(
            height: 25,
          ),
          PaymentButton(
            buttonText: 'Place My Order',
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
