import 'package:flutter/material.dart';
import 'package:food_couriers/components/custom_search_bar.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';
import 'package:food_couriers/constants/images/images.dart';
import 'package:food_couriers/constants/routes/routes.dart';
import 'package:food_couriers/models/food_item.dart';
import 'package:food_couriers/providers/auth_provider.dart';
import 'package:food_couriers/providers/user_provider.dart';
import 'package:food_couriers/screens/details/details_screen.dart';
import 'package:food_couriers/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'widgets/header.dart';
import 'widgets/item_card.dart';
import 'widgets/offers_card.dart';
import 'widgets/filter_button.dart';
import 'widgets/popular_meal_button.dart';
import 'widgets/popular_meal_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.onTapProfile,
    required this.onTapAdd,
  });

  final VoidCallback onTapProfile;
  final void Function(FoodItem foodItem) onTapAdd;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetIt _getIt = GetIt.instance;
  final _searchTextEditingController = TextEditingController();
  final _searchFocusNode = FocusNode();
  final _offerCardController = PageController();

  late NavigationService _navigationService;
  late AuthProvider _authProvider;

  int _selectedFilterIndex = 0;
  List<FoodItem> _filteredFoodItems = [];

  final List<FoodItemType> _filterOptions = [
    FoodItemType.burger,
    FoodItemType.pizza,
    FoodItemType.drink,
  ];

  final List<Widget> _offerCards = [
    OffersCard(
      imageURL: Images.burger,
      heading: 'Special Offer\nfor March',
      subheading: 'We are here with the best\ndeserts in town.',
      buttonText: 'Buy now',
      onTap: () {},
    ),
    OffersCard(
      imageURL: Images.burger,
      heading: 'Special Offer\nfor March',
      subheading: 'We are here with the best\ndeserts in town.',
      buttonText: 'Buy now',
      onTap: () {},
    ),
    OffersCard(
      imageURL: Images.burger,
      heading: 'Special Offer\nfor March',
      subheading: 'We are here with the best\ndeserts in town.',
      buttonText: 'Buy now',
      onTap: () {},
    ),
  ];

  final Map<FoodItemType, List<FoodItem>> _foodItemsByType = {
    FoodItemType.burger: [
      FoodItem(
        fid: '0x1',
        name: 'Chicken Burger Promo Pack',
        ingredients: ['100 gr chicken', 'Tomato', 'Cheese Lettuce'],
        description:
            'In a medium bowl, add ground chicken, breadcrumbs, mayonnaise, onions, parsley, garlic, paprika, salt and pepper. Use your hands to combine all the ingredients together until blended, but don\'t over mix.',
        rating: 3.8,
        foodType: FoodItemType.burger,
        imageURL: Images.chickenBurger,
        price: 20.00,
        quantity: 1,
        status: 'Popular',
        restaurantId: '0x11',
        restaurantName: 'Burger Factory LTD',
      ),
      FoodItem(
        fid: '0x2',
        name: 'Chese burger',
        ingredients: ['100 gr meat', 'Onion', 'Tomato', 'Lettuce Cheese'],
        description:
            'A mouthwatering cheese burger featuring 100 grams of premium meat, topped with fresh onions, tomato, lettuce, and a slice of melted cheese. This burger is crafted to deliver a rich and flavorful experience with every bite.',
        rating: 4.5,
        foodType: FoodItemType.burger,
        imageURL: Images.cheseBurger,
        price: 15.00,
        quantity: 1,
        status: 'New',
        restaurantId: '0x22',
        restaurantName: 'Pizza Palace',
      ),
      FoodItem(
        fid: '0x3',
        name: 'Zinger burger',
        ingredients: ['100 gr meat', 'Onion', 'Tomato', 'Lettuce Cheese'],
        description:
            'A spicy and flavorful zinger burger made with 100 grams of seasoned meat, accompanied by onions, tomato, lettuce, and a slice of cheese. This burger is known for its zesty flavor and is a must-try for those who love a bit of heat.',
        rating: 4.5,
        foodType: FoodItemType.burger,
        imageURL: Images.cheseBurger,
        price: 25.00,
        quantity: 1,
        status: "Chef's Special",
        restaurantId: '0x33',
        restaurantName: 'Hot Cool Spot',
      ),
    ],
    FoodItemType.pizza: [
      FoodItem(
        fid: '0x4',
        name: 'Pepperoni Pizza',
        ingredients: ['Pepperoni', 'Cheese', 'Tomato Sauce'],
        description:
            'A classic pepperoni pizza loaded with slices of spicy pepperoni, melted cheese, and a rich tomato sauce. It\'s a fan favorite for its bold flavors and cheesy goodness.',
        rating: 4.7,
        foodType: FoodItemType.pizza,
        imageURL: Images.person,
        price: 22.00,
        quantity: 1,
        status: 'Popular',
        restaurantId: '0x44',
        restaurantName: 'Pizza Place',
      ),
      FoodItem(
        fid: '0x4',
        name: 'Pepperoni Pizza',
        ingredients: ['Pepperoni', 'Cheese', 'Tomato Sauce'],
        description:
            'Another serving of the classic pepperoni pizza, featuring the same delicious combination of spicy pepperoni, cheese, and tomato sauce. Perfect for those who can\'t get enough of this timeless pizza.',
        rating: 4.7,
        foodType: FoodItemType.pizza,
        imageURL: Images.person,
        price: 22.00,
        quantity: 1,
        status: "Chef's Special",
        restaurantId: '0x44',
        restaurantName: 'Pizza Place',
      ),
    ],
    FoodItemType.drink: [
      FoodItem(
        fid: '0x5',
        name: 'Coke',
        ingredients: ['Carbonated Water', 'Sugar', 'Caffeine'],
        description:
            'A refreshing Coke, made with carbonated water, sugar, and caffeine. This classic soft drink is perfect for quenching your thirst and pairs well with any meal.',
        rating: 4.0,
        foodType: FoodItemType.drink,
        imageURL: Images.google,
        price: 5.00,
        quantity: 1,
        status: 'New',
        restaurantId: '0x55',
        restaurantName: 'Beverage Bar',
      ),
      FoodItem(
        fid: '0x5',
        name: 'Coke',
        ingredients: ['Carbonated Water', 'Sugar', 'Caffeine'],
        description:
            'A refreshing Coke, made with carbonated water, sugar, and caffeine. This classic soft drink is perfect for quenching your thirst and pairs well with any meal.',
        rating: 4.0,
        foodType: FoodItemType.drink,
        imageURL: Images.google,
        price: 5.00,
        quantity: 1,
        status: "Chef's Special",
        restaurantId: '0x55',
        restaurantName: 'Beverage Bar',
      ),
    ],
  };

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _filteredFoodItems =
        _foodItemsByType[_filterOptions[_selectedFilterIndex]]!;
  }

  void _onFilterChanged(int index) {
    setState(() {
      _selectedFilterIndex = index;
      _filteredFoodItems =
          _foodItemsByType[_filterOptions[_selectedFilterIndex]]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                Images.homePattern,
                alignment: Alignment.topRight,
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Consumer<UserProvider>(
                    builder: (context, userProvider, child) {
                      userProvider.fetchUser(userUid: _authProvider.user!.uid);
                      final address = userProvider.currentUser?.address ?? 'Set Location....';
                      return Header(
                        onTap: widget.onTapProfile,
                        address: address,
                        onTapLocation: () {
                          _navigationService.pushNamed(Routes.location);
                        },
                      );
                    }
                  ),
                  CustomSearchBar(
                    textEditingController: _searchTextEditingController,
                    focusNode: _searchFocusNode,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.37,
                        child: PageView.builder(
                          controller: _offerCardController,
                          itemCount: _offerCards.length,
                          itemBuilder: (context, index) {
                            return _offerCards[index];
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SmoothPageIndicator(
                        controller: _offerCardController,
                        count: _offerCards.length,
                        effect: const ScrollingDotsEffect(
                          activeDotColor: AppColors.primary,
                          dotColor: AppColors.inactiveDotColor,
                          dotHeight: 12,
                          dotWidth: 12,
                        ),
                        onDotClicked: (index) {
                          _offerCardController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
                    ],
                  ),
                  Container(
                    height: 41,
                    margin: const EdgeInsets.symmetric(horizontal: 26),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filterOptions.length,
                      itemBuilder: (context, index) {
                        return FilterButton(
                          isSelected: _selectedFilterIndex == index,
                          label: _filterOptions[index].toString().split('.').last,
                          imageURL: Images.cheseBurger,
                          onTap: () {
                            _onFilterChanged(index);
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 210,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filteredFoodItems.length,
                      itemBuilder: (context, index) {
                        return ItemCard(
                          ratings: _filteredFoodItems[index].rating!,
                          imageURL: _filteredFoodItems[index].imageURL!,
                          name: _filteredFoodItems[index].name!,
                          ingredients: _filteredFoodItems[index].ingredients!,
                          price: _filteredFoodItems[index].price!,
                          onTapAdd: () {
                            widget.onTapAdd(_filteredFoodItems[index]);
                          },
                          onTapCard: () => _navigationService.push(
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                foodItem: _filteredFoodItems[index],
                                onAddToCart: () {
                                  _navigationService.goBack();
                                  widget.onTapAdd(_filteredFoodItems[index]);
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  PopularMealButton(
                    onTap: () {},
                  ),
                  const PopularMealView(
                    imageURL: Images.chickenBurger,
                    mealName: 'Chicken burger',
                    description: 'heloo',
                    mealPrice: 20.00,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
