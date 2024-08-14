import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';
import 'package:food_couriers/constants/images/images.dart';
import 'package:food_couriers/constants/routes/routes.dart';
import 'package:food_couriers/providers/auth_provider.dart';
import 'package:food_couriers/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GetIt _getIt = GetIt.instance;

  late AuthProvider _authProvider;
  late NavigationService _navigationService;

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _navigationService = _getIt.get<NavigationService>();
    _initialize();
  }

  Future<void> _initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;
    await Future.delayed(const Duration(milliseconds: 400));
    String initialRoute = seenOnboarding
        ? (_authProvider.user != null ? Routes.bottomNavigation : Routes.auth)
        : Routes.onboarding;
    _navigationService.pushReplacementNamed(initialRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(Images.splashPattern),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(Images.splashIcon),
                const SizedBox(height: 18),
                const Text(
                  'Food Couriers',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontFamily: 'Poppins',
                    fontSize: 45,
                    fontWeight: FontWeight.w900,
                    height: 33.57 / 45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
