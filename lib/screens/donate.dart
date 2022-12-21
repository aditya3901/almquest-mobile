import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  String userImg = "";

  void initVars() async {
    final prefs = await SharedPreferences.getInstance();
    final user = jsonDecode(prefs.getString("reg_user")!);
    userImg = user["picture"];
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
          userImg == ""
              ? Container()
              : Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: CircleAvatar(
                        radius: 16,
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
      body: Container(),
    );
  }
}
