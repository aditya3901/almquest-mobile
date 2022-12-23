import 'dart:convert';
import 'dart:ui';
import 'package:almquest/screens/screens.dart';
import 'package:almquest/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../widgets/navigation_drawer.dart';
import '../widgets/popup_menu.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading = true;
  var user = {};
  var userImg = "";

  void getProfile() async {
    final pref = await SharedPreferences.getInstance();
    var userLocal = jsonDecode(pref.getString("reg_user")!);
    final id = userLocal["id"];

    final res = await http.get(
      Uri.parse("https://almquest-server.onrender.com/api/donor/$id"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    final response = jsonDecode(res.body);
    user = response["data"];

    userImg = user["picture"] ?? "";
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Widget profileItem(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: kTextColor,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: kTextColor,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Scaffold(
            appBar: AppBar(
              title: const Text(
                "AlmQuest",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: const Center(
              child: CupertinoActivityIndicator(
                radius: 18,
                color: kTextColor,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                "AlmQuest",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                Row(
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
                        backgroundColor: kTextColor,
                        child: CircleAvatar(
                          radius: 14,
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
                    ),
                  ],
                ),
              ],
            ),
            drawer: NavigationDrawer(),
            body: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: kLightTextColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                      top: 100,
                    ),
                    elevation: 10,
                    color: kBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 70),
                          Text(
                            user["name"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: kTextColor,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Card(
                            color: kBackgroundColor,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: kTextColor,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Lifetime Donation: ${user["lifetimeDonation"]}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: kTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          profileItem(
                            CupertinoIcons.person_circle,
                            "AlmQuest Donor",
                          ),
                          profileItem(CupertinoIcons.mail, user["email"]),
                          profileItem(
                            CupertinoIcons.phone,
                            user["phone"].toString().startsWith("+91")
                                ? user["phone"]
                                : "+91 - ${user["phone"]}",
                          ),
                          profileItem(
                            CupertinoIcons.location,
                            user["location"]["address"],
                          ),
                          profileItem(
                              CupertinoIcons.person_3, user["donorType"]),
                          profileItem(
                            CupertinoIcons.cart,
                            "${user["distanceRange"]}  kilometres",
                          ),
                          const SizedBox(height: 20),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF3B81F6)),
                              child: const ListTile(
                                trailing: Icon(
                                  Icons.edit,
                                  color: kTextColor,
                                ),
                                title: Text(
                                  "Update Profile",
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(() => Donate());
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white10),
                              child: const ListTile(
                                trailing: Icon(
                                  CupertinoIcons.gift,
                                  color: kTextColor,
                                ),
                                title: Text(
                                  "Donate Package",
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 25),
                      CircleAvatar(
                        radius: 74,
                        backgroundColor: const Color(0xFF60A5FA),
                        child: CircleAvatar(
                          radius: 70,
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
            ),
          );
  }
}
