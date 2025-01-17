import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';
import 'package:food_couriers/models/food_item.dart';
import 'package:food_couriers/screens/cart/cart_screen.dart';
import 'package:food_couriers/screens/chat/chat_screen.dart';
import 'package:food_couriers/screens/home/home_screen.dart';
import 'package:food_couriers/screens/profile/profile_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0, _previousIndex = 0, _totalQuantity = 0;
  final List<FoodItem> _foodItemsInCart = [];

  void _updateTotalQuantity() {
    _totalQuantity = _foodItemsInCart.fold(
      0,
      (sum, item) => sum + (item.quantity ?? 0),
    );
  }

  void _onItemTapped(int index, {FoodItem? foodItem}) {
    setState(() {
      _previousIndex = _selectedIndex;
      _selectedIndex = index;
    });

    if (foodItem != null) {
      final existingItemIndex =
          _foodItemsInCart.indexWhere((item) => item.fid == foodItem.fid);

      if (existingItemIndex != -1) {
        _foodItemsInCart[existingItemIndex].quantity =
            (_foodItemsInCart[existingItemIndex].quantity ?? 0) + 1;
      } else {
        _foodItemsInCart.add(foodItem);
      }

      _updateTotalQuantity();
    }
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _selectedIndex != 0 ? false : true,
      onPopInvokedWithResult: (didPop, result) {
        if (_selectedIndex != 0) {
          _onItemTapped(0);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            HomeScreen(
              onTapProfile: () {
                _onItemTapped(1);
              },
              onTapAdd: (foodItem) {
                _onItemTapped(2, foodItem: foodItem);
              },
            ),
            ProfileScreen(
              index: _previousIndex,
              onTapBack: (index) {
                _onItemTapped(index);
              },
              dismissKeyboard: _dismissKeyboard,
            ),
            CartScreen(
              index: _previousIndex,
              onTapBack: (index) {
                _onItemTapped(index);
              },
              foodItems: _foodItemsInCart,
              onQuantityChanged: _updateTotalQuantity,
            ),
            ChatScreen(
              index: _previousIndex,
              onTapBack: (index) {
                _onItemTapped(index);
              },
              dismissKeyboard: _dismissKeyboard,
            ),
          ],
        ),
        bottomNavigationBar: AnimatedContainer(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 500),
          height: _selectedIndex != 0 ? 0 : 80,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 21,
          ),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22),
              topRight: Radius.circular(22),
            ),
          ),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              _onItemTapped(index);
            },
            backgroundColor: AppColors.white,
            tabBackgroundColor: AppColors.secondary,
            padding: const EdgeInsets.symmetric(
              horizontal: 17,
              vertical: 10,
            ),
            tabBorderRadius: 12,
            gap: 13,
            iconSize: 30,
            textStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 15.72 / 12,
            ),
            tabs: [
              const GButton(
                icon: Icons.home,
                iconActiveColor: AppColors.primary,
                iconColor: AppColors.secondary,
                text: 'Home',
              ),
              const GButton(
                icon: Icons.person,
                iconActiveColor: AppColors.primary,
                iconColor: AppColors.secondary,
                text: 'Profile',
              ),
              GButton(
                icon: Icons.shopping_cart,
                iconActiveColor: AppColors.primary,
                iconColor: AppColors.secondary,
                text: 'Cart',
                leading: Stack(
                  children: [
                    const Icon(
                      Icons.shopping_cart,
                      size: 30,
                      color: AppColors.secondary,
                    ),
                    if (_totalQuantity > 0)
                      Positioned(
                        top: -2,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.white,
                              strokeAlign: BorderSide.strokeAlignCenter
                            )
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          child: Text(
                            '$_totalQuantity',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const GButton(
                icon: Icons.chat,
                iconActiveColor: AppColors.primary,
                iconColor: AppColors.secondary,
                text: 'Chat',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
