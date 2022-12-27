import 'dart:convert';
import 'package:almquest/screens/screens.dart';
import 'package:almquest/widgets/popup_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isSending = false;
  final formKey = GlobalKey<FormState>();
  String userEmail = "";
  String userName = "";
  String userImg = "";

  String selectedBtn = "donor";
  final types = ["Individual", "Organisation", "Food Chain"];
  String? type;
  var coord = [];

  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _travelController = TextEditingController();
  final _carryController = TextEditingController();

  void getCoordFromLocation() async {
    final query = _locationController.text;
    var addr = await Geocoder.local.findAddressesFromQuery(query);
    var first = addr.first;

    coord = [first.coordinates.latitude, first.coordinates.longitude];

    submitForm();
  }

  void submitForm() async {
    setState(() {
      isSending = true;
    });

    var body = {};
    if (selectedBtn == "donor") {
      body = {
        "name": userName,
        "email": userEmail,
        "picture": userImg,
        "phone": _phoneController.text,
        "location": {
          "address": _locationController.text,
          "coordinates": coord,
        },
        "distanceRange": _travelController.text,
        "donorType": type,
      };
    } else {
      body = {
        "name": userName,
        "email": userEmail,
        "picture": userImg,
        "phone": _phoneController.text,
        "location": {
          "address": _locationController.text,
          "coordinates": coord,
        },
        "distanceRange": _travelController.text,
        "maxCapacity": _carryController.text,
      };
    }

    final reqBody = jsonEncode(body);

    final res = await http.post(
      Uri.parse(
          "https://almquest-server.onrender.com/api/$selectedBtn/register"),
      headers: {"Content-Type": "application/json"},
      body: reqBody,
    );

    final json = jsonDecode(res.body);
    final regUser = {
      "name": userName,
      "email": userEmail,
      "picture": userImg,
      "userType": selectedBtn,
      "id": json["data"]["_id"],
    };
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("reg_user", jsonEncode(regUser));

    Get.offAll(() => Home());
  }

  @override
  void initState() {
    super.initState();
    initVars();
  }

  void initVars() async {
    final prefs = await SharedPreferences.getInstance();
    final userStr = prefs.getString("temp_user");

    final user = jsonDecode(userStr!);
    userEmail = user["email"];
    userImg = user["photo"] ??
        "https://res.cloudinary.com/locer/image/upload/v1672113907/default_user.png";
    userName = user["name"];
    setState(() {});
  }

  Widget selectedButton(VoidCallback onTap, IconData icon, String title) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(primary: const Color(0xFF3B81F6)),
      icon: Icon(
        icon,
        color: kTextColor,
        size: 20,
      ),
      label: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget notSelectedButton(VoidCallback onTap, IconData icon, String title) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          width: 1,
          color: Color(0xFF3B81F6),
        ),
      ),
      icon: Icon(
        icon,
        color: const Color(0xFF3B81F6),
        size: 20,
      ),
      label: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF3B81F6),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget formField(String label, TextInputType inputType,
        TextEditingController? controller, String? initVal) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: initVal != null
            ? TextFormField(
                readOnly: true,
                initialValue: initVal,
                style: const TextStyle(
                  color: kTextColor,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: kLightTextColor),
                  ),
                  labelText: label,
                  labelStyle: const TextStyle(
                    color: kLightTextColor,
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: const OutlineInputBorder(),
                ),
              )
            : TextFormField(
                controller: controller,
                style: const TextStyle(
                  color: kTextColor,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: kLightTextColor),
                  ),
                  labelText: label,
                  labelStyle: const TextStyle(
                    color: kLightTextColor,
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: const OutlineInputBorder(),
                ),
                keyboardType: inputType,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "$label required";
                  }
                  return null;
                },
              ),
      );
    }

    return Scaffold(
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
              userImg != ""
                  ? PopUpMenu(
                      menuList: const [
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
                    )
                  : Container(),
            ],
          ),
        ],
      ),
      body: userEmail == ""
          ? const Center(
              child: CupertinoActivityIndicator(
                radius: 18,
                color: kTextColor,
              ),
            )
          : isSending
              ? const Center(
                  child: CupertinoActivityIndicator(
                    radius: 18,
                    color: kTextColor,
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Get Your Free Account Now",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kTextColor,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Let's get you all set up so you can verify your personal account and begin setting up your profile.",
                          style: TextStyle(color: kLightTextColor),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Select type of account",
                          style: TextStyle(color: kTextColor),
                        ),
                        const SizedBox(height: 10),
                        selectedBtn == "donor"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  selectedButton(
                                    () {
                                      setState(() {
                                        selectedBtn = "donor";
                                      });
                                    },
                                    CupertinoIcons.heart,
                                    "Donor",
                                  ),
                                  const SizedBox(height: 10),
                                  notSelectedButton(
                                    () {
                                      setState(() {
                                        selectedBtn = "distributor";
                                      });
                                    },
                                    CupertinoIcons.gift,
                                    "Distributor",
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  notSelectedButton(
                                    () {
                                      setState(() {
                                        selectedBtn = "donor";
                                      });
                                    },
                                    CupertinoIcons.heart,
                                    "Donor",
                                  ),
                                  const SizedBox(height: 10),
                                  selectedButton(
                                    () {
                                      setState(() {
                                        selectedBtn = "distributor";
                                      });
                                    },
                                    CupertinoIcons.gift,
                                    "Distributor",
                                  ),
                                ],
                              ),
                        const SizedBox(height: 15),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              formField(
                                "Name",
                                TextInputType.name,
                                null,
                                userName,
                              ),
                              formField(
                                "Email",
                                TextInputType.emailAddress,
                                null,
                                userEmail,
                              ),
                              formField(
                                "Phone",
                                TextInputType.phone,
                                _phoneController,
                                null,
                              ),
                              formField(
                                "Location",
                                TextInputType.text,
                                _locationController,
                                null,
                              ),
                              selectedBtn == "donor"
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 6),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: kLightTextColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              hint: const Text(
                                                "Select Category",
                                                style: TextStyle(
                                                  color: kTextColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              dropdownColor: kBackgroundColor,
                                              value: type,
                                              isExpanded: true,
                                              style: TextStyle(
                                                color: kTextColor,
                                                fontFamily:
                                                    GoogleFonts.robotoSerif()
                                                        .fontFamily,
                                              ),
                                              items: types
                                                  .map(buildMenuItem)
                                                  .toList(),
                                              onChanged: (String? value) =>
                                                  setState(() {
                                                type = value!;
                                              }),
                                            ),
                                          ),
                                        ),
                                        formField(
                                          "How far can you travel?",
                                          TextInputType.number,
                                          _travelController,
                                          null,
                                        ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        formField(
                                          "How much can you carry?",
                                          TextInputType.number,
                                          _carryController,
                                          null,
                                        ),
                                        formField(
                                          "How far can you travel?",
                                          TextInputType.number,
                                          _travelController,
                                          null,
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              getCoordFromLocation();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF3B81F6)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Register as Distributor",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      );
}
