import 'dart:convert';
import 'package:almquest/screens/screens.dart';
import 'package:almquest/widgets/navigation_drawer.dart';
import 'package:almquest/widgets/popup_menu.dart';
import 'package:almquest/widgets/popup_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
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
  var user = {};
  Channel? _channel;
  List<dynamic> notifs = [];
  bool checkNotif = false;

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
        user = {
          "name": googleUser.displayName,
          "email": googleUser.email,
          "picture": data["picture"],
          "userType": data["userType"],
          "id": data["id"],
        };
        prefs!.setString("reg_user", jsonEncode(user));
        userImg = user["picture"];

        getNotifs();
        _initPusher();
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
      user = jsonDecode(userStr);
      userImg = user["picture"];

      getNotifs();
      _initPusher();
    } else {
      await GoogleSignIn().signOut();
      isLoggedIn = false;
      setState(() {});
    }
  }

  Future<void> getNotifs() async {
    final res = await http.get(
      Uri.parse(
          "https://almquest-server.onrender.com/api/${user["userType"]}/${user["id"]}/getNotifs"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    final json = jsonDecode(res.body);
    notifs = json["notifs"];
    notifs = notifs.reversed.toList();
    setState(() {
      isLoggedIn = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initVars();
  }

  void _initPusher() async {
    try {
      await Pusher.init(
        "b369bdc486176cddddfd",
        PusherOptions(
          cluster: "ap2",
        ),
      );

      Pusher.connect();
      _channel = await Pusher.subscribe("almquest-channel");
      _channel!.bind(
        user["id"],
        (onEvent) async {
          await getNotifs();
          setState(() {
            checkNotif = true;
          });
          final event = jsonDecode(onEvent.data);
          Get.snackbar(
            "New notification",
            event["message"],
            backgroundColor: kLightTextColor,
            duration: const Duration(seconds: 3),
          );
        },
      );
    } catch (err) {
      print(err);
    }
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
                    PopUpNav(
                      menuList: notifs.map((notif) {
                        final date1 = DateTime.parse(notif["timestamp"]);
                        final date2 = DateTime.now();
                        var time = "";
                        if (date2.difference(date1).inMinutes < 60) {
                          time = "${date2.difference(date1).inMinutes}m";
                        } else if (date2.difference(date1).inHours < 24) {
                          time = "${date2.difference(date1).inHours}h";
                        } else {
                          time = "${date2.difference(date1).inDays}d";
                        }

                        return PopupMenuItem(
                          padding: const EdgeInsets.all(0),
                          value: {
                            "userType": user["userType"],
                            "notif": notif,
                          },
                          child: ListTile(
                            tileColor: notif["notif_seen"] != null &&
                                    notif["notif_seen"] == true
                                ? Colors.transparent
                                : Colors.white12,
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(notif["photo"] ?? userImg),
                              onBackgroundImageError:
                                  (exception, stackTrace) {},
                            ),
                            title: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: kTextColor,
                                  fontSize: 12,
                                ),
                                children: [
                                  notif["user_type"] == "Donor"
                                      ? TextSpan(
                                          text: notif["status"] == "Paired"
                                              ? "Hurray! We have found a distributor for your package!"
                                              : "Oops! We could not find a distributor for your package!",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : const TextSpan(
                                          text:
                                              "Hurray! We have assigned you to a donor!",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                  TextSpan(
                                    text: " $time ago",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      icon: Icon(
                        checkNotif
                            ? Icons.notification_add_outlined
                            : Icons.notifications_outlined,
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
                                "https://res.cloudinary.com/locer/image/upload/v1672113907/default_user.png";
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
      body: Container(),
    );
  }
}
