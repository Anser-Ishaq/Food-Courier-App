import 'package:flutter/material.dart';
import 'package:food_couriers/constants/routes/routes.dart';
import 'package:food_couriers/screens/auth/auth_screen.dart';
import 'package:food_couriers/screens/bottom_navigation/bottom_navigation_screen.dart';
import 'package:food_couriers/screens/map/map_screen.dart';
import 'package:food_couriers/screens/onboarding/onboading_screen.dart';
import 'package:food_couriers/screens/splash/splash_screen.dart';

class NavigationService {

  late GlobalKey<NavigatorState> _navigatorKey;

  final Map<String, Widget Function(BuildContext)> _routes = {
    Routes.splash: (context) => const SplashScreen(),
    Routes.onboarding : (context) => const OnBoardingScreen(),
    Routes.auth : (context) => const AuthScreen(),
    Routes.bottomNavigation : (context) => const BottomNavigationScreen(),
    Routes.location : (context) => const MapScreen(),
  };

  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;
  Map<String, Widget Function(BuildContext)> get routes => _routes;

  NavigationService() {
    _navigatorKey = GlobalKey<NavigatorState>();
  }

  void push(MaterialPageRoute route) {
    _navigatorKey.currentState?.push(route);
  }

  void pushNamed(String routeName) {
    _navigatorKey.currentState?.pushNamed(routeName);
  }

  void pushReplacementNamed(String routeName) {
    _navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  void goBack() {
    _navigatorKey.currentState?.pop();
  }

}