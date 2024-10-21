import 'package:ecommerce_app/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/Admin/admin_home.dart';

class AllOreders extends StatefulWidget {
  const AllOreders({super.key});

  @override
  State<AllOreders> createState() => _AllOredersState();
}

class _AllOredersState extends State<AllOreders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AdminHome()));
            },
            child: Icon(Icons.arrow_back_ios_new_outlined)),
        title: Center(
          child: Text(
            "All Orders",
            style: AppWidget.boldTextFieldStyle(),
          ),
        ),
      ),
    );
  }
}
