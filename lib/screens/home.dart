import 'dart:convert';
import 'package:almquest/screens/screens.dart';
import 'package:almquest/widgets/navigation_drawer.dart';
import 'package:almquest/widgets/popup_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoggedIn = false;
  SharedPreferences? prefs;
  String userImg = "";

  void signIn() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      final body = {"email": googleUser.email};
      final res = await http.post(
        Uri.parse("https://almquest-server.onrender.com/api/checkExist"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      final data = jsonDecode(res.body);
      if (data["isRegistered"]) {
        final regUser = {
          "name": googleUser.displayName,
          "email": googleUser.email,
          "picture": googleUser.photoUrl ?? "",
          "userType": data["userType"],
          "id": data["id"],
        };
        prefs!.setString("reg_user", jsonEncode(regUser));
        userImg = googleUser.photoUrl ?? "";
        isLoggedIn = true;
        setState(() {});
      } else {
        final data = {
          "name": googleUser.displayName,
          "email": googleUser.email,
          "photo": googleUser.photoUrl,
        };
        prefs!.setString("temp_user", jsonEncode(data));
        Get.to(() => Register());
      }
    } else {
      await GoogleSignIn().signOut();
    }
  }

  void initVars() async {
    prefs = await SharedPreferences.getInstance();
    final userStr = prefs!.getString("reg_user");
    if (userStr != null) {
      final user = jsonDecode(userStr);
      userImg = user["picture"];
      isLoggedIn = true;
    } else {
      await GoogleSignIn().signOut();
      isLoggedIn = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initVars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AlmQuest",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          !isLoggedIn
              ? Container(
                  margin: const EdgeInsets.only(
                    right: 12,
                    top: 6,
                    bottom: 6,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: kTextColor, width: 2),
                    ),
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextButton(
                        onPressed: () {
                          signIn();
                        },
                        child: const Text(
                          "Sign In",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_outlined,
                      ),
                    ),
                    PopUpMenu(
                      menuList: const [
                        PopupMenuItem(
                          value: "profile",
                          child: ListTile(
                            leading: Icon(
                              CupertinoIcons.person,
                              color: kTextColor,
                            ),
                            title: Text(
                              "View Profile",
                              style: TextStyle(color: kTextColor),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: "theme",
                          child: ListTile(
                            leading: Icon(
                              CupertinoIcons.moon,
                              color: kTextColor,
                            ),
                            title: Text(
                              "Change Theme",
                              style: TextStyle(color: kTextColor),
                            ),
                          ),
                        ),
                        PopupMenuDivider(),
                        PopupMenuItem(
                          value: "invite",
                          child: ListTile(
                            leading: Icon(
                              CupertinoIcons.person_add,
                              color: kTextColor,
                            ),
                            title: Text(
                              "Invite Others",
                              style: TextStyle(color: kTextColor),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: "help",
                          child: ListTile(
                            leading: Icon(
                              CupertinoIcons.question_circle,
                              color: kTextColor,
                            ),
                            title: Text(
                              "Help",
                              style: TextStyle(color: kTextColor),
                            ),
                          ),
                        ),
                        PopupMenuDivider(),
                        PopupMenuItem(
                          value: "signout",
                          child: ListTile(
                            leading: Icon(
                              Icons.logout,
                              color: kTextColor,
                            ),
                            title: Text(
                              "Sign Out",
                              style: TextStyle(color: kTextColor),
                            ),
                          ),
                        ),
                      ],
                      icon: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          userImg,
                        ),
                        onBackgroundImageError: (exception, stackTrace) {
                          userImg =
                              "https://t4.ftcdn.net/jpg/03/26/98/51/360_F_326985142_1aaKcEjMQW6ULp6oI9MYuv8lN9f8sFmj.jpg";
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
        ],
      ),
      drawer: NavigationDrawer(),
      body: Container(),
    );
  }
}
