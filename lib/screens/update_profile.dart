import 'dart:convert';
import 'package:almquest/screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class UpdateProfile extends StatefulWidget {
  final String userType;
  final String id;
  final Map<dynamic, dynamic> user;

  const UpdateProfile({
    Key? key,
    required this.userType,
    required this.id,
    required this.user,
  }) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final formKey = GlobalKey<FormState>();
  bool isSending = false;
  var coord = [];

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _travelController = TextEditingController();

  void initVars() async {
    _nameController.text = widget.user["name"];
    _emailController.text = widget.user["email"];
    _phoneController.text = widget.user["phone"];
    _locationController.text = widget.user["location"]["address"];
    _travelController.text = "${widget.user["distanceRange"]}";

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initVars();
  }

  void getCoordFromLocation() async {
    setState(() {
      isSending = true;
    });
    final query = _locationController.text;
    var addr = await Geocoder.local.findAddressesFromQuery(query);
    var first = addr.first;

    coord = [first.coordinates.latitude, first.coordinates.longitude];
    submit();
  }

  void submit() async {
    final reqBody = {
      "name": _nameController.text,
      "email": _emailController.text,
      "phone": _phoneController.text,
      "location": {
        "address": _locationController.text,
        "coordinates": coord,
      },
      "distanceRange": _travelController.text,
    };

    await http.patch(
      Uri.parse(
          "https://almquest-server.onrender.com/api/${widget.userType}/update/${widget.id}"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(reqBody),
    );

    Get.offAll(() => Profile(userType: widget.userType, id: widget.id));
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
                          "Update personal details",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kTextColor,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Change the fields that you want to be updated in your profile and press Update Profile button to commit the changes.",
                          style: TextStyle(color: kLightTextColor),
                        ),
                        const SizedBox(height: 15),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              formField(
                                "Name",
                                TextInputType.text,
                                _nameController,
                              ),
                              formField(
                                "Email",
                                TextInputType.text,
                                _emailController,
                              ),
                              formField(
                                "Phone",
                                TextInputType.text,
                                _phoneController,
                              ),
                              formField(
                                "Location",
                                TextInputType.text,
                                _locationController,
                              ),
                              formField(
                                "Travel Capacity",
                                TextInputType.text,
                                _travelController,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              getCoordFromLocation();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xFFd97707)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Update Profile",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
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
