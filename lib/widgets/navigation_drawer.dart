import 'package:almquest/screens/screens.dart';
import 'package:almquest/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Wrap(
              runSpacing: 14,
              children: [
                Center(
                  child: Image.asset(
                    "assets/logo.png",
                    height: 150,
                  ),
                ),
                const Divider(
                  color: kLightTextColor,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.offAll(() => Home());
                  },
                  leading: const Icon(
                    Icons.home_outlined,
                    color: kTextColor,
                  ),
                  title: const Text(
                    "AlmQuest Home",
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 15,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.offAll(() => const Team());
                  },
                  leading: const Icon(
                    CupertinoIcons.person_2,
                    color: kTextColor,
                  ),
                  title: const Text(
                    "Our Team",
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 15,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.offAll(() => const ContactUs());
                  },
                  leading: const Icon(
                    Icons.feedback_outlined,
                    color: kTextColor,
                  ),
                  title: const Text(
                    "Contact Us",
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 15,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  leading: const Icon(
                    CupertinoIcons.settings,
                    color: kTextColor,
                  ),
                  title: const Text(
                    "Settings",
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
