import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserSurnameNameKey = "USERSURNAMENAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";
  static String sharedPreferenceNotificationTokenKey = "NOTIFICATIONTOKENKEY";

  static bool isLogin = false;
  static String loginUserName = "";
  static String loginUserSurname = "";
  static String loginUserEmail = "";
  static String loginNotificationToken = "";

  //SAVE
  static Future saveUserLoggedInSharedPreference(bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("ISLOGGEDIN", isUserLoggedIn);
    // ignore: avoid_print
    print("saveUserLoggedInSharedPreference Fonksiyonu Çalıştı");
    getUserLoggedInSharedPreference();
  }

  static Future saveUserNameSharedPreference(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("USERNAMEKEY", userName);
    // ignore: avoid_print
    print("saveUserNameSharedPreference Fonksiyonu Çalıştı");
    getUserNameSharedPreference();
  }

  static Future saveUserSurnameSharedPreference(String userSurname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("USERSURNAMENAMEKEY", userSurname);
    // ignore: avoid_print
    print("saveUserSurnameSharedPreference Fonksiyonu Çalıştı");
    getUserSurnameSharedPreference();
  }

  static Future saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("USEREMAILKEY", userEmail);
    // ignore: avoid_print
    print("saveUserEmailSharedPreference Fonksiyonu Çalıştı");
    getUserEmailSharedPreference();
  }

  static Future saveNotificationTokenSharedPreference(
      String notificationToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("NOTIFICATIONTOKENKEY", notificationToken);
    // ignore: avoid_print
    print("saveNotificationTokenSharedPreference Fonksiyonu Çalıştı");
    getNotificationTokenSharedPreference();
  }

  //GET
  static getUserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool("ISLOGGEDIN") ?? false;
    // ignore: avoid_print
    print("getUserLoggedInSharedPreference Fonksiyonu Çalıştı");
    return isLogin;
  }

  static getUserNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginUserName = prefs.getString("USERNAMEKEY") ?? "";
    // ignore: avoid_print
    print("getUserNameSharedPreference Fonksiyonu Çalıştı");
    return loginUserName;
  }

  static getUserSurnameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginUserSurname = prefs.getString("USERSURNAMENAMEKEY") ?? "";
    // ignore: avoid_print
    print("getUserSurnameSharedPreference Fonksiyonu Çalıştı");
    return loginUserSurname;
  }

  static getUserEmailSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginUserEmail = prefs.getString("USEREMAILKEY") ?? "";
    // ignore: avoid_print
    print("getUserEmailSharedPreference Fonksiyonu Çalıştı");
    return loginUserEmail;
  }

  static getNotificationTokenSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginNotificationToken = prefs.getString("NOTIFICATIONTOKENKEY") ?? "";
    // ignore: avoid_print
    print("getNotificationTokenSharedPreference Fonksiyonu Çalıştı");
    return loginNotificationToken;
  }

  static Future deleteSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: avoid_print
    print("deleteSharedPreference Fonksiyonu Çalıştı");
    prefs.clear();
  }
}
