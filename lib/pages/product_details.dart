import 'dart:convert';

import 'package:ecommerce_app/services/constant.dart';
import 'package:ecommerce_app/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class productDetails extends StatefulWidget {
  String Name, Image, details, price;
  productDetails(
      {required this.details,
      required this.Image,
      required this.Name,
      required this.price});

  @override
  State<productDetails> createState() => _productDetailsState();
}

class _productDetailsState extends State<productDetails> {
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeCefe8),
      body: Container(
        padding: EdgeInsets.only(
          top: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    margin: EdgeInsets.only(left: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(Icons.arrow_back_ios_new_outlined)),
              ),
            ]),
            Container(
              child: Center(
                  child: Image.network(
                widget.Image,
                height: 400,
              )),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.Name,
                          style: AppWidget.boldTextFieldStyle(),
                        ),
                        Text(
                          "Rs ${widget.price}",
                          style: TextStyle(
                              color: Color(0xFFfd6f3e),
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.details,
                      style: AppWidget.boldTextFieldStyle(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Details",
                      style: AppWidget.lightTextFieldStyle(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        makePayment(widget.price);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Color(0xFFfd6f3e),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Buy Now",
                            style: AppWidget.boldTextFieldStyle(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, "INR");
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent?['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: "Abhi"))
          .then((value) {});
      displayPaymentSheet();
    } catch (e, s) {
      print("exception:$e$s");
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text("Payment Sucessful")
                        ],
                      )
                    ],
                  ),
                ));
        paymentIntent != null;
      }).onError((error, stackTrace) {
        print("Error is -----> $error $stackTrace");
      });
    } on StripeException catch (e) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled"),
              ));
    } catch (e) {
      print("$e");
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amonut': calculateAmount(amount),
        'currency': currency,
        "payment_method_types[]": "card"
      };
      var response =
          await http.post(Uri.parse('http://apistripe.com/v1/payment_intents'),
              headers: {
                "Autherization": "bearer $secretkey",
                'Content-Type': 'application/x-www-form-urlencoded',
              },
              body: body);
      jsonDecode(response.body);
    } catch (err) {
      print('err chsrging user: ${err.toString()}');
    }
  }

  calculateAmount(String amonut) {
    final calculatedamount = {int.parse(amonut) * 100};
    return calculatedamount.toString();
  }
}
