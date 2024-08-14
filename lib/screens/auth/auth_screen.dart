import 'package:flutter/material.dart';
import 'package:food_couriers/components/space_vertical.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';
import 'package:food_couriers/constants/images/images.dart';
import 'package:food_couriers/screens/auth/login_screen.dart';
import 'package:food_couriers/screens/auth/create_account_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(Images.onBoarding2Pattern),
                ),
                const SizedBox(
                  height: 15,
                ),
                Image.asset(Images.onBoarding2illustration),
                const SpaceVertical(),
              ],
            ),
            const BottomSheet(),
          ],
        ),
      ),
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.09,
      maxChildSize: 0.75,
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
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: const TabBar(
                          indicatorColor: AppColors.primary,
                          labelColor: AppColors.primary,
                          unselectedLabelColor: AppColors.charcoalGray,
                          dividerHeight: 0,
                          labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            height: 24 / 16,
                          ),
                          tabs: [
                            Tab(text: 'Create Account'),
                            Tab(text: 'Login'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: const TabBarView(
                          children: [
                            CreateAccountScreen(),
                            LoginScreen(),
                          ],
                        ),
                      ),
                    ],
                  ),
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
