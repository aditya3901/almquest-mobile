import 'dart:convert';
import 'package:almquest/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../utils/constants.dart';

class Transaction extends StatefulWidget {
  final String userType;
  final String pid;
  const Transaction({
    Key? key,
    required this.pid,
    required this.userType,
  }) : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  bool isLoading = true;
  var package = {};
  String date = "";

  void getPackage() async {
    final res = await http.get(
      Uri.parse(
          "https://almquest-server.onrender.com/api/package/${widget.pid}"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    final response = jsonDecode(res.body);
    package = response["package"];

    final dt = DateTime.parse(package["timestamp"]);
    date = DateFormat("E d MMM, y  hh:mm").format(dt);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getPackage();
  }

  Widget packageDetail(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
              maxLines: 2,
              style: const TextStyle(
                color: kTextColor,
                overflow: TextOverflow.ellipsis,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(
                radius: 18,
                color: kTextColor,
              ),
            ),
          )
        : WillPopScope(
            onWillPop: () async {
              Get.offAll(() => Home());
              return false;
            },
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  "AlmQuest",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(26),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Package Details",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kTextColor,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2,
                            color: const Color(0xFF60A5FA),
                          ),
                        ),
                        child: Text(
                          "Status: ${package["current_state"]}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF60A5FA),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white12,
                        ),
                        child: Text(
                          "Package ID: ${package["_id"]}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      packageDetail(CupertinoIcons.calendar, date),
                      packageDetail(
                        Icons.cookie_outlined,
                        "${package["quantity"]} Meals",
                      ),
                      const Divider(color: kLightTextColor),
                      packageDetail(
                        CupertinoIcons.location,
                        package["pair"]["meet_location"]["address"],
                      ),
                      const SizedBox(height: 10),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/bg_map.jpeg",
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF60A5FA),
                            ),
                            onPressed: () {
                              Get.to(
                                () => MapScreen(
                                  userLocation: widget.userType == "donor"
                                      ? package["location"]
                                      : package["pair"]["distributor_location"],
                                  meetLocation: package["pair"]
                                      ["meet_location"],
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "View Path",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Divider(color: kLightTextColor),
                      const SizedBox(height: 15),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Donor Information",
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      packageDetail(
                        CupertinoIcons.profile_circled,
                        package["donor_name"],
                      ),
                      packageDetail(
                        CupertinoIcons.phone,
                        package["donor_phone"],
                      ),
                      const Divider(color: kLightTextColor),
                      const SizedBox(height: 15),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Distributor Information",
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      packageDetail(
                        CupertinoIcons.profile_circled,
                        package["pair"]["distributor_name"],
                      ),
                      packageDetail(
                        CupertinoIcons.phone,
                        package["pair"]["distributor_phone"],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
