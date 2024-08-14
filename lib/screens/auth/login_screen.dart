import 'package:flutter/material.dart';
import 'package:food_couriers/components/gradient_text.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';
import 'package:food_couriers/constants/const/const.dart';
import 'package:food_couriers/constants/routes/routes.dart';
import 'package:food_couriers/providers/auth_provider.dart';
import 'package:food_couriers/services/alert_service.dart';
import 'package:food_couriers/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'widgets/auth_button.dart';
import 'widgets/divider_bar.dart';
import 'widgets/google_button.dart';
import 'widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final GetIt _getIt = GetIt.instance;

  late AlertService _alertService;
  late NavigationService _navigationService;

  String? email, password;

  @override
  void initState() {
    super.initState();
    _alertService = _getIt.get<AlertService>();
    _navigationService = _getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 60,
              ),
              CustomTextFormField(
                onSaved: (value) {
                  email = value;
                },
                validationRegEx: emailValidationRegex,
                title: 'Email address',
                hintText: 'ekamcy@gmail.com',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
              ),
              CustomTextFormField(
                onSaved: (value) {
                  password = value;
                },
                validationRegEx: passwordValidationRegex,
                title: 'Password1',
                hintText: '**** **** ****',
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                textCapitalization: TextCapitalization.none,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: const GradientText(
                    text: 'Forget Password?',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 36 / 12,
                    ),
                    gradient: AppColors.gradientPrimary,
                  ),
                ),
              ),
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return AuthButton(
                    buttonText: 'Login',
                    isLoading: authProvider.isLoading,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        bool success = await authProvider.login(email!, password!);
                        if (success) {
                          _alertService.showToast(text: 'Login successful!');
                          _navigationService.pushReplacementNamed(Routes.bottomNavigation);
                        } else {
                          _alertService.showToast(text: 'Login failed!');
                        }
                      }
                    },
                  );
                }
              ),
              const DividerBar(),
              GoogleButton(
                buttonText: 'Login with Google',
                onTap: () {},
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
