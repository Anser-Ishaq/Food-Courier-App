import 'dart:developer';


import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:food_couriers/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

class AlertService {
  final GetIt _getIt = GetIt.instance;

  late NavigationService _navigationService;

  AlertService(){
    _navigationService = _getIt<NavigationService>();
  }

  void showToast({
    required String text,
    IconData icon = Icons.info,
  }) {
    try {
      DelightToastBar(
        autoDismiss: true,
        position: DelightSnackbarPosition.top,
        builder: (context) {
          return ToastCard(
            leading: Icon(
              icon,
              size: 28,
            ),
            title: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              )
            ), 
          );
        },
      ).show(
        _navigationService.navigatorKey!.currentContext!,
      );
    } catch (e) {
      log(e.toString());
    }
  }
}