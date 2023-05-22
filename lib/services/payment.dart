

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/ProviderProduct.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as prefix;
import 'package:http/http.dart' as http;

class payment {
  Map<String, dynamic> paymentIntentData;
Future<void> makePayment(BuildContext context) async {
    try {
      int price = Provider.of<ProviderProduct>(context, listen: false).getsum();
      paymentIntentData = await createPaymentIntent(price.toString(), 'USD');
      await prefix.Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: prefix.SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntentData['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});
      displayPaymentSheet(context);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await prefix.Stripe.instance
          .presentPaymentSheet(
              parameters: prefix.PresentPaymentSheetParameters(
        clientSecret: paymentIntentData['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        print('payment intent' + paymentIntentData['id'].toString());
        print('payment intent' + paymentIntentData['client_secret'].toString());
        print('payment intent' + paymentIntentData['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on prefix.StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51Lue1FCGRVDJvz8aQRgiV6Scjs2J4y9yGVmDBDQiGWXApYhgQ7S6RE0z1cAJPMk0yMCmnDEQuXPZWQrqF9QiM5HN00zoc3qKMi',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }



}