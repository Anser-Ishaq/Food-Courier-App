import 'package:flutter/material.dart';
import 'package:food_couriers/constants/const/const.dart';
import 'package:food_couriers/constants/routes/routes.dart';
import 'package:food_couriers/models/user.dart';
import 'package:food_couriers/providers/auth_provider.dart';
import 'package:food_couriers/providers/user_provider.dart';
import 'package:food_couriers/services/alert_service.dart';
import 'package:food_couriers/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'widgets/auth_button.dart';
import 'widgets/divider_bar.dart';
import 'widgets/google_button.dart';
import 'widgets/custom_text_form_field.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final GetIt _getIt = GetIt.instance;

  late AlertService _alertService;
  late NavigationService _navigationService;

  String? name, email, password;

  @override
  void initState() {
    super.initState();
    _alertService = _getIt.get<AlertService>();
    _navigationService = _getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomTextFormField(
                onSaved: (value) {
                  name = value;
                },
                validationRegEx: nameValidationRegex,
                title: 'Full Name',
                hintText: 'Emmanuel kamcy',
                obscureText: false,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
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
                title: 'Password',
                hintText: '**** **** ****',
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                textCapitalization: TextCapitalization.none,
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<AuthProvider>(builder: (context, authProvider, child) {
                return AuthButton(
                  buttonText: 'Sign Up',
                  isLoading: authProvider.isLoading,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      bool success =
                          await authProvider.signUp(email!, password!);
                      if (success) {
                        userProvider.createUser(
                            user: User(
                          uid: authProvider.user!.uid,
                          name: name,
                          email: email,
                        ));
                        _alertService.showToast(text: 'Sign up successful!');
                        _navigationService.pushReplacementNamed(Routes.bottomNavigation);
                      } else {
                        _alertService.showToast(text: 'Sign up failed!');
                      }
                    }
                  },
                );
              }),
              const DividerBar(),
              GoogleButton(
                buttonText: 'Sign up with Google',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
