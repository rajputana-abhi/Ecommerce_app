import 'package:ecommerce_app/Admin/add_product.dart';
import 'package:ecommerce_app/Admin/all_order.dart';
import 'package:ecommerce_app/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/pages/home.dart';
import 'package:ecommerce_app/Admin/admin_login.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2f2f2),
      appBar: AppBar(
        backgroundColor: Color(0xFFf2f2f2),
        title: Center(
          child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Text(
              "Admin Home",
              style: AppWidget.boldTextFieldStyle(),
            ),
          ),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddProduct()));
                },
                child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            size: 50,
                          ),
                          Text(
                            "Add Product",
                            style: AppWidget.boldTextFieldStyle(),
                          )
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: 80,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllOreders()));
                },
                child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 50,
                          ),
                          Text(
                            "All Orders",
                            style: AppWidget.boldTextFieldStyle(),
                          )
                        ],
                      ),
                    )),
              ),
            ],
          )),
    );
  }
}
