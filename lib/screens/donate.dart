import 'dart:convert';
import 'package:almquest/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  final formKey = GlobalKey<FormState>();
  var coord = [];
  var donorId = "";
  bool isSending = false;

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
    _locationController.text = json["data"]["location"]["address"];
    donorId = json["data"]["_id"];
    setState(() {});
  }

  void getCoordFromLocation() async {
    final query = _locationController.text;
    var addr = await Geocoder.local.findAddressesFromQuery(query);
    var first = addr.first;

    coord = [first.coordinates.latitude, first.coordinates.longitude];
    submit();
  }

  void submit() async {
    setState(() {
      isSending = true;
    });

    final reqBody = {
      "donor_id": donorId,
      "quantity": _quantityController.text,
      "travelCapacity": _travelController.text,
      "location": {
        "coordinates": coord,
        "address": _locationController.text,
      },
    };

    final res = await http.post(
      Uri.parse("https://almquest-server.onrender.com/api/donor/donate"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(reqBody),
    );

    final jsonRes = jsonDecode(res.body);
    final packageId = jsonRes["package"]["_id"];

    await http.get(
      Uri.parse(
        "https://almquest-pyserver.onrender.com/pair/$packageId",
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    Get.snackbar(
      "Package successfully added",
      "Please wait while we find you your perfect pair!",
      backgroundColor: kLightTextColor,
      duration: const Duration(seconds: 4),
    );
    Get.offAll(() => Home());
  }

  @override
  void initState() {
    super.initState();
    initVars();
  }

  Widget formField(String label, TextInputType inputType,
      TextEditingController? controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
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
      body: _locationController.text.isEmpty
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
                              ),
                              formField(
                                "Travel Capacity",
                                TextInputType.number,
                                _travelController,
                              ),
                              formField(
                                "Your Location",
                                TextInputType.text,
                                _locationController,
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
