import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/pages/category_product.dart';
import 'package:ecommerce_app/services/database.dart';
import 'package:ecommerce_app/services/shared_prefs.dart';
import 'package:ecommerce_app/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/pages/home.dart';
import 'package:ecommerce_app/pages/order.dart';
import 'package:ecommerce_app/pages/profile.dart';
import 'package:ecommerce_app/pages/signup.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool Search = false;
  List categories = [
    "assest/images/headphone_icon.png",
    "assest/images/laptop.png",
    "assest/images/watch.png",
    "assest/images/TV.png"
  ];

  List categoriesname = ['headphones', 'Laptops', "watch", "tv"];

  var QueryResultSet = [];
  var tempsearchstore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        QueryResultSet = [];
        tempsearchstore = [];
      });
    }
    setState(() {
      Search = true;
    });
    var capitalizeValue =
        value.subString(0, 1).toUpperCase() + value.subString(1);
    if (QueryResultSet.isEmpty && value.length == 1) {
      DatabaseMethods().search(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          QueryResultSet.add(docs.docs[i].data());
        }
      });
    } else {
      tempsearchstore = [];
      QueryResultSet.forEach((element) {
        if (element["UpdatedName"].startsWith(capitalizeValue)) {
          setState(() {
            tempsearchstore.add(element);
          });
        }
        ;
      });
    }
  }

  String? name, image;
  gethesharedprefs() async {
    name = await SharedPreferncesHelper().getusername();
    image = await SharedPreferncesHelper().getuserImage();
    setState(() {});
  }

  ontheload() async {
    await gethesharedprefs();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2f2f2),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 40),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Hey,",
                      style: AppWidget.boldTextFieldStyle(),
                    ),
                    name == null
                        ? Text(
                            "$name",
                            style: AppWidget.boldTextFieldStyle(),
                          )
                        : Text(
                            "Guest",
                            style: AppWidget.boldTextFieldStyle(),
                          )
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset(
                    "assest/images/boy.jpg",
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            Text(
              "Good Morning",
              style: AppWidget.lightTextFieldStyle(),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: TextField(
                onChanged: (value) {
                  initiateSearch(value);
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Search
                ? ListView(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    primary: false,
                    shrinkWrap: true,
                    children: tempsearchstore.map((element) {
                      return buildResultCard(element);
                    }).toList(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: AppWidget.lightTextFieldStyle(),
                        ),
                        Text(
                          "See all",
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )
                      ],
                    ),
                  ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(left: 10),
                  height: 150,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "All",
                        style: AppWidget.lightTextFieldStyle(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 140,
                    child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return categoriesTiles(
                            image: categories[index],
                            name: categoriesname[index],
                          );
                        }),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Products",
                  style: AppWidget.lightTextFieldStyle(),
                ),
                Text(
                  "See all",
                  style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(color: Colors.white),
                  height: 150,
                  width: 150,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Image.asset(
                              'assest/images/headphone2.png',
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Headphones",
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              width: 50,
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text(
                                  "\$100",
                                  style: TextStyle(
                                      color: Color(0xFFfd6f3e), fontSize: 20),
                                ),
                                SizedBox(
                                  width: 50,
                                  height: 30,
                                ),
                                Icon(
                                  Icons.add,
                                  color: Color(0xFFfd6f3e),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(color: Colors.white),
                  height: 150,
                  width: 150,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Image.asset(
                              'assest/images/laptop.png',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Headphones",
                              style: TextStyle(color: Colors.black),
                            ),
                            Row(
                              children: [
                                Text(
                                  "\$100",
                                  style: TextStyle(
                                      color: Color(0xFFfd6f3e), fontSize: 20),
                                ),
                                Icon(
                                  Icons.add,
                                  color: Color(0xFFfd6f3e),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildResultCard(data) {
    return Container(
      height: 100,
      child: Row(children: [
        Image.network(
          data["Image"],
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
        Text(
          data["Name"],
          style: AppWidget.lightTextFieldStyle(),
        )
      ]),
    );
  }
}

class categoriesTiles extends StatelessWidget {
  String image, name;
  categoriesTiles({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => productCategory(category: name)));
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(left: 20),
        height: 150,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Image.asset(
              image,
              height: 50,
              width: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }
}
