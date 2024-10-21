import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/pages/signup.dart';

class SharedPreferncesHelper {
  static String UserIdKey = "USERIDKEY";
  static String UserNameKey = "USERNAMEKEY";
  static String UserEmailKey = "USEREMAILKEY";
  static String UserImageKey = "USERIMAGEKEY";

  Future<bool> saveuserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(UserIdKey, getUserId);
  }

  Future<bool> saveuserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(UserNameKey, getUserName);
  }

  Future<bool> saveuserEmail(String getUserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(UserEmailKey, getUserEmail);
  }

  Future<bool> saveuserImage(String getUserImages) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(UserImageKey, getUserImages);
  }

  Future<String?> getuserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(UserIdKey);
  }

  Future<String?> getusername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(UserNameKey);
  }

  Future<String?> getuserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(UserEmailKey);
  }

  Future<String?> getuserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(UserImageKey);
  }
}
