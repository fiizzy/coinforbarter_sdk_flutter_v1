import 'package:flutter/material.dart';
import 'package:flutter_sdk_2/coinforbarter.dart';

class ButtonPage extends StatelessWidget {
  final PaymentConfig newPayment = PaymentConfig(
      publicKey: 'xxxxx-xxxxx-xxxxx',
      txRef: 'Flutter final Reference 1',
      amount: 0.1,
      baseCurrency: 'ETH',
      customer: 'JohnDoe@noemail.com',
      customerFullName: 'John Amala Doe',
      callback: myCallBackFunction);

  ButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CoinForBarter(
              color: Colors.red,
              textColor: Colors.white,
              paymentConfig: newPayment)),
    );
  }
}

//Function arguments value would be return from the server after the plan terminates [successful or Unsuccessful]
myCallBackFunction(int statusCode, String b, dynamic c, Status s) {
  //Payment status can either be Status.error or Status.success
  Status.error;
  debugPrint('At the end of the day, The call back function works');
}
