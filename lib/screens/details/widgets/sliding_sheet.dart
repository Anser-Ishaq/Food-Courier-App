import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';
import 'package:food_couriers/screens/details/widgets/add_to_cart_button.dart';
import 'package:food_couriers/screens/details/widgets/ratings_order_row.dart';
import 'package:food_couriers/screens/details/widgets/status_icons_row.dart';

class SlidingSheet extends StatelessWidget {
  const SlidingSheet({
    super.key,
    required this.status,
    required this.onTapLocation,
    required this.isFavorite,
    required this.onTapFavorite,
    required this.name,
    required this.rating,
    required this.orderCount,
    required this.description,
    required this.onTapAddToCart,
  });

  final String status;
  final VoidCallback onTapLocation;
  final bool isFavorite;
  final VoidCallback onTapFavorite;
  final String name;
  final double rating;
  final int orderCount;
  final String description;
  final VoidCallback onTapAddToCart;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.58,
      minChildSize: 0.09,
      maxChildSize: 0.58,
      expand: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              topButtonIndicator(),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatusIconsRow(
                      status: status,
                      onTapLocation: onTapLocation,
                      isFavorite: isFavorite,
                      onTapFavorite: onTapFavorite,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 72,
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                          height: 35.38 / 27,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RatingsOrderRow(
                      rating: rating,
                      orderCount: orderCount,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        description,
                        softWrap: true,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 21.66 / 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AddToCartButton(
                      onTap: onTapAddToCart,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  SliverToBoxAdapter topButtonIndicator() {
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          width: 48,
          height: 6,
          margin: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            gradient: AppColors.gradientSecondary,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
