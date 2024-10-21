import 'dart:io';

import 'package:ecommerce_app/pages/bottom_nav.dart';
import 'package:ecommerce_app/pages/login.dart';
import 'package:ecommerce_app/services/auth.dart';
import 'package:ecommerce_app/services/database.dart';
import 'package:ecommerce_app/services/shared_prefs.dart';
import 'package:ecommerce_app/widget/support_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/pages/home.dart';
import 'package:ecommerce_app/pages/order.dart';
import 'package:ecommerce_app/pages/profile.dart';
import 'package:ecommerce_app/pages/signup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  String? image, name, email;

  getthwsharedprefs() async {
    image = await SharedPreferncesHelper().getuserImage();
    name = await SharedPreferncesHelper().getusername();
    email = await SharedPreferncesHelper().getuserEmail();
    setState(() {});
  }

  @override
  void initState() {
    getthwsharedprefs();
    super.initState();
  }

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    uploadItem();
    setState(() {});
  }

  uploadItem() async {
    if (selectedImage != null) {
      String addId = randomAlphaNumeric(10);
      Reference FirebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImage").child(addId);

      final UploadTask task = FirebaseStorageRef.putFile(selectedImage!);
      var downlordUrl = await (await task).ref.getDownloadURL();
      await SharedPreferncesHelper().saveuserImage(downlordUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2f2f2),
      appBar: AppBar(
        backgroundColor: Color(0xFFf2f2f2),
        title:
            // Row(
            //   children: [
            Center(
          child: Text(
            "Profile",
            style: AppWidget.boldTextFieldStyle(),
          ),
        ),
        //     Spacer(),
        //     GestureDetector(
        //       onTap: () {
        //         Navigator.pushReplacement(
        //             context, MaterialPageRoute(builder: (context) => login()));
        //       },
        //       child: Text(
        //         "Login",
        //         style: AppWidget.boldTextFieldStyle(),
        //       ),
        //     )
        //   ],
        // ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            selectedImage != null
                ? Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.file(selectedImage!,
                          height: 100, width: 100, fit: BoxFit.cover),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Center(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        "assest/images/boy.jpg",
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    )),
                  ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_2_outlined,
                        size: 35,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: AppWidget.lightTextFieldStyle(),
                          ),
                          Text(
                            "Abhi Tomar",
                            style: AppWidget.lightTextFieldStyle(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.mail_lock_outlined,
                        size: 35,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: AppWidget.lightTextFieldStyle(),
                          ),
                          Text(
                            "tomarbhi@gmail.com",
                            style: AppWidget.lightTextFieldStyle(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                await AuthMethods().SignOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => bottomNav()));
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout_outlined,
                          size: 35,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              "LogOut",
                              style: AppWidget.lightTextFieldStyle(),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                await AuthMethods().deleteuser().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => bottomNav()));
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline,
                          size: 35,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              "Delete Account",
                              style: AppWidget.lightTextFieldStyle(),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
