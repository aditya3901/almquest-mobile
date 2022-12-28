import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../utils/constants.dart';
import '../widgets/navigation_drawer.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

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
            color: kTextColor,
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
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Ultimate Design Solution",
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "AlmQuest brings to you the opportunity to be the one to donate food or, be the one to get in touch with such donors and distribute the food where its needed.",
                style: TextStyle(
                  color: kLightTextColor,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 58, 114, 235),
                ),
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Get In Touch",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Follow Us",
                style: TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      LineIcons.github,
                      color: kTextColor,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      LineIcons.linkedinIn,
                      color: kTextColor,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      LineIcons.twitter,
                      color: kTextColor,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      LineIcons.instagram,
                      color: kTextColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: kLightTextColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                color: kBackgroundColor,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            formField(
                              "Full Name",
                              TextInputType.name,
                              _nameController,
                            ),
                            formField(
                              "Email address",
                              TextInputType.emailAddress,
                              _emailController,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: TextFormField(
                                controller: _messageController,
                                style: const TextStyle(
                                  color: kTextColor,
                                  fontSize: 14,
                                ),
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kLightTextColor),
                                  ),
                                  labelText: "Message",
                                  labelStyle: TextStyle(
                                    color: kTextColor,
                                    fontSize: 14,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 100,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Message required";
                                  }
                                  return null;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 58, 114, 235),
                        ),
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Get In Touch",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
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
