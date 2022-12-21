import 'dart:convert';

import 'package:almquest/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/screens.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: SingleChildScrollView(
          child: Wrap(
            runSpacing: 14,
            children: [
              ListTile(
                onTap: () async {
                  Navigator.of(context).pop();
                  final pref = await SharedPreferences.getInstance();
                  final userStr = pref.getString("reg_user");
                  if (userStr != null) {
                    Get.to(() => Donate());
                  } else {
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: kBackgroundColor,
                        title: const ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              "You have to login first to donate",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kTextColor,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            "You have to register to AlmQuest first as a Donor to be able to donate a package.",
                            style: TextStyle(color: kLightTextColor),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "OK",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
                leading: const Icon(
                  CupertinoIcons.gift,
                  color: kTextColor,
                ),
                title: const Text(
                  "Donate Package",
                  style: TextStyle(
                    color: kTextColor,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                },
                leading: const Icon(
                  CupertinoIcons.question_circle,
                  color: kTextColor,
                ),
                title: const Text(
                  "About AlmQuest",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 14,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                },
                leading: const Icon(
                  CupertinoIcons.person_2_alt,
                  color: kTextColor,
                ),
                title: const Text(
                  "Our Team",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 14,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                },
                leading: const Icon(
                  Icons.feedback_outlined,
                  color: kTextColor,
                ),
                title: const Text(
                  "Feedback",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 14,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                },
                leading: const Icon(
                  CupertinoIcons.scope,
                  color: kTextColor,
                ),
                title: const Text(
                  "Features",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
