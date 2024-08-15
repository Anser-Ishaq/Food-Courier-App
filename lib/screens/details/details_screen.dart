import 'package:flutter/material.dart';
import 'package:food_couriers/components/icon_button_box.dart';
import 'package:food_couriers/models/food_item.dart';
import 'package:food_couriers/screens/details/widgets/sliding_sheet.dart';
import 'package:food_couriers/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.foodItem,
    required this.onAddToCart,
  });

  final FoodItem foodItem;
  final VoidCallback onAddToCart;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final GetIt _getIt = GetIt.instance;

  late NavigationService _navigationService;

  bool _isFavortie = false;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height * 0.12,
              child: CarouselView(
                shrinkExtent: 60,
                itemExtent: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height * 0.12,
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.blue.shade200,
                itemSnapping: true,
                scrollDirection: Axis.vertical,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                children: [
                  Image.asset(widget.foodItem.imageURL!),
                  Image.asset(widget.foodItem.imageURL!),
                  Image.asset(widget.foodItem.imageURL!),
                  Image.asset(widget.foodItem.imageURL!),
                  Image.asset(widget.foodItem.imageURL!),
                  Image.asset(widget.foodItem.imageURL!),
                  Image.asset(widget.foodItem.imageURL!),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 5),
                  child: IconButtonBox(
                    icon: Icons.arrow_back_ios_rounded,
                    onTap: () {
                      _navigationService.goBack();
                    },
                  ),
                ),
              ],
            ),
            SlidingSheet(
              status: widget.foodItem.status!,
              onTapLocation: () {},
              isFavorite: _isFavortie,
              onTapFavorite: () {
                setState(() {
                  _isFavortie = !_isFavortie;
                });
              },
              name: widget.foodItem.name!,
              rating: widget.foodItem.rating!,
              orderCount: widget.foodItem.orderCount ?? 0,
              description: widget.foodItem.description!,
              onTapAddToCart: widget.onAddToCart,
            ),
          ],
        ),
      ),
    );
  }
}
