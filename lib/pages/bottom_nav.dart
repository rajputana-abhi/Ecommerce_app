import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce_app/pages/home.dart';
import 'package:ecommerce_app/pages/order.dart';
import 'package:ecommerce_app/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/pages/signup.dart';
class bottomNav extends StatefulWidget {
  const bottomNav({super.key});

  @override
  State<bottomNav> createState() => _bottomNavState();
}

class _bottomNavState extends State<bottomNav> {
  late List<Widget> pages;
  late home HomePage;
  late Orders Order;
  late profile Profile;
  int currentTabIndex = 0;
  @override
  void initState() {
    HomePage = home();
    Order = Orders();
    Profile = profile();
    pages = [HomePage, Order, Profile];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Colors.black,
          animationDuration: Duration(milliseconds: 500),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.person_2_outlined,
              color: Colors.white,
            )
          ]),
      body: pages[currentTabIndex],
    );
  }
}
