import 'package:flutter/material.dart';
import 'package:food_couriers/services/stripe_service.dart';
import 'package:get_it/get_it.dart';

class StripeProvider with ChangeNotifier {
  final GetIt _getIt = GetIt.instance;
  late StripeService _stripeService;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  StripeProvider() {
    _stripeService = _getIt.get<StripeService>();
  }

  Future<void> makePayment({required int amount, required String currency}) async {
    isLoading = true;
    try {
      await _stripeService.makePayment(amount: amount, currency: currency);
    } catch (e) {
      throw Exception('Payment failed: $e');
    } finally {
      isLoading = false;
    }
  }
}
