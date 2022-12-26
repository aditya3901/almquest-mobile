import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/screens.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class PopUpNav extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;

  const PopUpNav({
    Key? key,
    required this.menuList,
    required this.icon,
  }) : super(key: key);

  void notifSeen(String id) async {
    await http.post(
      Uri.parse("https://almquest-server.onrender.com/api/notification/$id"),
      headers: {
        "Content-Type": "application/json",
      },
    );
  }

  void onSelected(BuildContext context, dynamic value) async {
    if (value["notif"]["notif_seen"] == false) {
      notifSeen(value["notif"]["_id"]);
    }

    Get.to(
      () => Transaction(
        pid: value["notif"]["packageId"],
        userType: value["userType"],
      ),
    );
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
