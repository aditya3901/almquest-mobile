import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  final formKey = GlobalKey<FormState>();
  var address = "";

  final _quantityController = TextEditingController();
  final _travelController = TextEditingController();
  final _locationController = TextEditingController();

  void initVars() async {
    final prefs = await SharedPreferences.getInstance();
    final regUser = jsonDecode(prefs.getString("reg_user")!);

    final res = await http.get(
      Uri.parse(
        "https://almquest-server.onrender.com/api/donor/${regUser["id"]}",
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    final json = jsonDecode(res.body);
    address = json["data"]["location"]["address"];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initVars();
  }

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
      ),
      body: address == ""
          ? Container()
          : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Add a package",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Add your package details, your current location and how far you can carry the package from your current location.",
                      style: TextStyle(color: kLightTextColor),
                    ),
                    const SizedBox(height: 15),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          formField(
                            "Number of meals",
                            TextInputType.number,
                            _quantityController,
                            null,
                          ),
                          formField(
                            "Travel Capacity",
                            TextInputType.number,
                            _travelController,
                            null,
                          ),
                          formField(
                            "Your Location",
                            TextInputType.text,
                            _locationController,
                            address,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF3B81F6)),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Donate Package",
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
}
