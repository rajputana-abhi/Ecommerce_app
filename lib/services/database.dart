import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/pages/signup.dart';
import 'package:ecommerce_app/pages/home.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userinfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userinfoMap);
  }

  Future addAllProducts(Map<String, dynamic> userinfoMap) async {
    return await FirebaseFirestore.instance
        .collection("Products")
        .add(userinfoMap);
  }

  Future addProduct(
      Map<String, dynamic> userinfoMap, String categoryname) async {
    return await FirebaseFirestore.instance
        .collection(categoryname)
        .add(userinfoMap);
  }

  Future<Stream<QuerySnapshot>> getProducts(String category) async {
    return await FirebaseFirestore.instance.collection(category).snapshots();
  }

  Future<QuerySnapshot> search(String updatedname) async {
    return await FirebaseFirestore.instance
        .collection("Products")
        .where("SearchKey",
            isEqualTo: updatedname.substring(0, 1).toUpperCase())
        .get();
  }
}
