// ignore_for_file: unused_field

import 'package:coinforbarter_sdk/src/controllers/selectCurrency_controller.dart';
import 'package:coinforbarter_sdk/src/controllers/serviceController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:coinforbarter_sdk/src/models/config.dart';
import 'package:coinforbarter_sdk/src/views/dialog/payment_success_dialog.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'globalizer.dart';

class ListeningToPaymentController extends GetxController {
  final ServiceController _serviceController = Get.find();
  final SelectCurrencyController _selectCurrencyController = Get.find();
  final GlobalizerController _globalizerController = Get.find();
  int? countDownValue;
  late Timer timer;

  ///This function handles all the logic behind listening to the addresses for payment progress.
  ///A payment can either be: In progress, error, canceled, timeout or success.
  void statusCheker() {
    timer = Timer.periodic(const Duration(seconds: 30), (timerConst) async {
      await _serviceController.getPaymentDetails(_serviceController.paymentID);

      if (_selectCurrencyController.getStatus() == 'success') {
        Get.offAll(() => const PaymentResponse(message: 'success'));

        //Run call back function
        _globalizerController.paymentConfig.callback!(200, 'payment successful',
            'Your CoinForbarter payment was successful', Status.success);
      } else if (_selectCurrencyController.getStatus() == 'error' ||
          countDownValue == 0) {
        //Use Get.off to avoid memory leakage
        Get.offAll(() => const PaymentResponse(message: 'error'));
        Get.snackbar('Payment failed', 'This payment failed due to an error');

        _globalizerController.paymentConfig.callback!(200, 'payment failed',
            'Your CoinForbarter payment failed', Status.error);

        ///runcall back function
        debugPrint('Payment failed');
        Get.snackbar('Payment failed', 'Time Expired');
        timer.cancel();
      } else if (_selectCurrencyController.getStatus() == 'cancelled' ||
          countDownValue == 0) {
        //Use Get.off to avoid memory leakage
        Get.offAll(() => const PaymentResponse(message: 'error'));
        Get.snackbar('Payment failed', 'This payment failed due to an error');

        _globalizerController.paymentConfig.callback!(200, 'payment failed',
            'Your CoinForbarter payment failed', Status.error);

        ///runcall back function
        debugPrint('Payment failed');
        Get.snackbar('Payment failed', 'Time Expired');
        timer.cancel();
      } else if (_selectCurrencyController.getStatus() == 'in progress') {
        //do nothing
        debugPrint('this is in progress');
      }
    });
  }
}
