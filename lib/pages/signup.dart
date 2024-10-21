import 'package:ecommerce_app/pages/bottom_nav.dart';
import 'package:ecommerce_app/pages/login.dart';
import 'package:ecommerce_app/services/database.dart';
import 'package:ecommerce_app/services/shared_prefs.dart';
import 'package:ecommerce_app/widget/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/pages/signup.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? name, email, password;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null && name != null && email != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "REgisterd Sucessfully",
              style: TextStyle(fontSize: 20),
            )));
        String id = randomAlpha(10);
        await SharedPreferncesHelper().saveuserId(id);
        await SharedPreferncesHelper().saveuserEmail(mailcontroller.text);
        await SharedPreferncesHelper().saveuserName(namecontroller.text);
        await SharedPreferncesHelper().saveuserImage("");
        Map<String, dynamic> userinfoMap = {
          "Name": namecontroller.text,
          "Email": mailcontroller.text,
          "Id": id,
          "Image": Image.asset("assest/images/boys.png")
        };
        await DatabaseMethods().addUserDetails(userinfoMap, id);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => bottomNav()));
      } on FirebaseException catch (e) {
        if (e.code == "week_passwprd") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Week password",
                style: TextStyle(fontSize: 20),
              )));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Account already in use",
                style: TextStyle(fontSize: 20),
              )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 100, left: 20, right: 20),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Sign Up",
                  style: AppWidget.boldTextFieldStyle(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Please entre the  detail below to continue",
                style: AppWidget.lightTextFieldStyle(),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Name",
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
                        return "Please Enter your name";
                      }
                      return null;
                    },
                    controller: namecontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Name"),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                "Email",
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
                        return "Please Enter your Email";
                      }
                      return null;
                    },
                    controller: mailcontroller,
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
                        return "Please Enter your Password";
                      }
                      return null;
                    },
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Password"),
                  )),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          name = namecontroller.text;
                          email = mailcontroller.text;
                          password = passwordcontroller.text;
                        });
                      }
                      registration();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => login()));
                    },
                    child: Center(
                      child: Text(
                        "SIGN UP",
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have a acoount?  ",
                    style: AppWidget.lightTextFieldStyle(),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => login()));
                    },
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
