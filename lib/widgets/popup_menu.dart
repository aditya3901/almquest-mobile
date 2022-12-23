import 'dart:convert';
import 'package:almquest/screens/screens.dart';
import 'package:almquest/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopUpMenu extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;

  const PopUpMenu({Key? key, required this.menuList, this.icon})
      : super(key: key);

  void onSelected(BuildContext context, dynamic value) async {
    if (value == "signout") {
      final pref = await SharedPreferences.getInstance();
      pref.clear();
      await GoogleSignIn().signOut();
      Get.offAll(() => Home());
    } else if (value == "profile") {
      final prefs = await SharedPreferences.getInstance();
      final user = jsonDecode(prefs.getString("reg_user")!);
      Get.offAll(
        () => Profile(
          userType: user["userType"],
          id: user["id"],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => menuList,
      icon: icon,
      color: kBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onSelected: (item) => onSelected(context, item),
    );
  }
}
