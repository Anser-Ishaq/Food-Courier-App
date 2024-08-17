import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_couriers/services/alert_service.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class StripeService {
  final GetIt _getIt = GetIt.instance;

  late AlertService _alertService;

  StripeService() {
    _alertService = _getIt.get<AlertService>();
  }

  String _calculateAmount(int amount) {
    return (amount * 100).toString();
  }

  Future<Map<String, dynamic>?> _createPaymentIntent(
      int amount, String currency) async {
    try {
      final body = {
        'amount': _calculateAmount(amount),
        'currency': currency,
      };

      String baseUrl;
      if (Platform.isAndroid) {
        baseUrl = 'http://192.168.100.244:5050';
      } else if (Platform.isIOS) {
        baseUrl = 'http://localhost:5050';
      } else {
        baseUrl = 'http://10.0.2.2:5050';
      }

      final response = await http.post(
        Uri.parse('$baseUrl/api/payment'),
        body: body,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create payment intent');
      }
    } catch (e) {
      _alertService.showToast(text: 'Server is not available. Please try again later.');
      throw Exception('Error createPaymentIntent: $e');
    }
  }

  Future<void> makePayment(
      {required int amount, required String currency}) async {
    try {
      final paymentIntentData =
          await _createPaymentIntent(amount, currency) ?? {};

      if (paymentIntentData['client_secret'] == null) {
        throw Exception('Invalid payment intent data');
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          style: ThemeMode.light,
          customFlow: false,
          merchantDisplayName: 'Food Couriers',
        ),
      );

      await _showPaymentSheet();
    } catch (e) {
      throw Exception('Error makePayment: $e');
    }
  }

  Future<void> _showPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        _alertService.showToast(text: 'Paid Successfully');
      });
      await Stripe.instance.confirmPaymentSheetPayment();
    } on StripeException catch (e) {
      throw Exception('Error showPaymentSheet: $e');
    }
  }
}
