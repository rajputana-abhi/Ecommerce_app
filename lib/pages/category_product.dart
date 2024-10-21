import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/pages/product_details.dart';
import 'package:ecommerce_app/services/database.dart';
import 'package:ecommerce_app/widget/support_widget.dart';
import 'package:flutter/material.dart';

class productCategory extends StatefulWidget {
  String category;
  productCategory({required this.category});

  @override
  State<productCategory> createState() => _productCategoryState();
}

class _productCategoryState extends State<productCategory> {
  Stream? categoryStream;

  getintheload() async {
    categoryStream = await DatabaseMethods().getProducts(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    getintheload();
    super.initState();
  }

  Widget allProduct() {
    return StreamBuilder(
        stream: categoryStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, Index) {
                    DocumentSnapshot ds = snapshot.data.docs[Index];
                    return Container(
                      margin: EdgeInsets.only(right: 10, left: 10),
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(color: Colors.white),
                      height: 10,
                      width: 250,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Image.network(
                                  ds["Image"],
                                  height: 100,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  ds["Name"],
                                  style: AppWidget.lightTextFieldStyle(),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      ds["Price"],
                                      style: TextStyle(
                                          color: Color(0xFFfd6f3e),
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 30,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    productDetails(
                                                        details: ds["Deatils"],
                                                        Image: ds["Image"],
                                                        Name: ds["Name"],
                                                        price: ds["Price"])));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFfd6f3e),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2f2f2),
      body: Container(
        margin: EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 20),
        child: Column(
          children: [Expanded(child: allProduct())],
        ),
      ),
    );
  }
}
