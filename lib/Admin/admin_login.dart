import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Admin/add_product.dart';
import 'package:ecommerce_app/Admin/admin_home.dart';
import 'package:ecommerce_app/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/pages/home.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 250, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Admin Login",
                style: AppWidget.boldTextFieldStyle(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "UserName",
              style: AppWidget.boldTextFieldStyle(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    color: Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter your mail";
                    }
                    return null;
                  },
                  controller: usernamecontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Email"),
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              "Password",
              style: AppWidget.boldTextFieldStyle(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    color: Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter your password";
                    }
                    return null;
                  },
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Password"),
                )),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                LoginAdmin();
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AddProduct()));
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  LoginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((Snapshot) {
      Snapshot.docs.forEach((result) {
        if (result.data()["username"] != usernamecontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Enter Corect username",
                style: TextStyle(fontSize: 20),
              )));
        } else if (result.data()["password"] !=
            passwordcontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Wrong password",
                style: TextStyle(fontSize: 20),
              )));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProduct()));
        }
      });
    });
  }
}
