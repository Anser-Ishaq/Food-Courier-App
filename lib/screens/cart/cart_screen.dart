import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_couriers/components/icon_button_box.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';
import 'package:food_couriers/constants/images/images.dart';
import 'package:food_couriers/models/food_item.dart';
import 'package:food_couriers/providers/stripe_provider.dart';
import 'package:food_couriers/screens/cart/widgets/food_item_box.dart';
import 'package:food_couriers/screens/cart/widgets/payment_box.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
    required this.index,
    required this.onTapBack,
    required this.foodItems,
    required this.onQuantityChanged,
  });

  final int index;
  final void Function(int) onTapBack;
  final List<FoodItem> foodItems;
  final VoidCallback onQuantityChanged;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<FoodItem> _foodItems = [];

  @override
  void initState() {
    super.initState();
    _foodItems = widget.foodItems;
  }

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      _foodItems[index].quantity = newQuantity;
    });
    widget.onQuantityChanged();
  }

  @override
  Widget build(BuildContext context) {
    final stripeProvider = Provider.of<StripeProvider>(context);
    double subTotal = _foodItems.fold(
        0, (sum, item) => sum + (item.price! * (item.quantity ?? 0)));

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              Images.primaryPattern,
              alignment: Alignment.topRight,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 5),
                  child: IconButtonBox(
                    icon: Icons.arrow_back_ios_rounded,
                    onTap: () {
                      widget.onTapBack(widget.index);
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  child: const Text(
                    'Order details',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 32.76 / 25,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 20),
                    child: ListView.separated(
                      itemCount: _foodItems.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 15);
                      },
                      itemBuilder: (context, index) {
                        final item = _foodItems[index];
                        return Dismissible(
                          key: Key(item.fid!),
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction) {
                            setState(() {
                              _foodItems.removeAt(index);
                            });
                            widget.onQuantityChanged();
                          },
                          child: FoodItemBox(
                            foodItem: item,
                            onQuantityChanged: (newQuantity) {
                              _updateQuantity(index, newQuantity);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                PaymentBox(
                  subTotal: subTotal,
                  deliveryCharges: 20,
                  discount: 10,
                  onTap: () async {
                    try {
                      await stripeProvider.makePayment(
                        amount: (subTotal + 20 - 10).toInt(),
                        currency: 'USD',
                      );
                      // Navigate to a new screen or show a success message
                    } catch (e) {
                      if (kDebugMode) print('Payment failed: $e');
                    }
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const FinishOrderScreen()));
                  },
                ),
              ],
            ),
          ),
          if (stripeProvider.isLoading)
            Positioned.fill(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.black.withOpacity(0.1),
                ),
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
