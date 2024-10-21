import 'package:ecommerce_app/Admin/add_product.dart';
import 'package:ecommerce_app/Admin/admin_home.dart';
import 'package:ecommerce_app/Admin/admin_login.dart';
import 'package:ecommerce_app/pages/bottom_nav.dart';
import 'package:ecommerce_app/pages/category_product.dart';
import 'package:ecommerce_app/pages/home.dart';
import 'package:ecommerce_app/pages/login.dart';
import 'package:ecommerce_app/pages/order.dart';
import 'package:ecommerce_app/pages/profile.dart';
import 'package:ecommerce_app/pages/signup.dart';
import 'package:ecommerce_app/services/constant.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishkey;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: login(),
    );
  }
}
