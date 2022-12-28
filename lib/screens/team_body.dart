import 'package:almquest/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class TeamBody extends StatelessWidget {
  const TeamBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _profileCard(String imageUrl, String name, String role) {
      return Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: kLightTextColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        color: kBackgroundColor,
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: kTextColor,
                child: CircleAvatar(
                  radius: 76,
                  foregroundImage: NetworkImage(imageUrl),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                name,
                style: const TextStyle(
                  color: kTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                role,
                style: const TextStyle(
                  color: Color.fromARGB(220, 224, 224, 224),
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      LineIcons.linkedinIn,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 28,
                    ),
                    tooltip: 'Linked In',
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.mail,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    tooltip: 'Mail ID',
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      LineIcons.github,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 28,
                    ),
                    tooltip: 'GitHub',
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Meet Our Development Team",
              style: TextStyle(
                color: kTextColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _profileCard(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuptVqZE6-xdsNirk9X1ZzZEUYQlktFIfWHw&usqp=CAU",
                      "Aditya Das",
                      "Backend Developer",
                    ),
                    const SizedBox(height: 20),
                    _profileCard(
                      "https://consequence.net/wp-content/uploads/2022/07/tom-cruise.jpg?quality=80",
                      "Tamonash Bhattacharyya",
                      "AI/ML Developer",
                    ),
                    const SizedBox(height: 20),
                    _profileCard(
                      "https://pbs.twimg.com/media/Fj7zP3xXgAAFPG2?format=jpg&name=large",
                      "Suddhabrato Ghosh",
                      "Frontend Developer",
                    ),
                    const SizedBox(height: 20),
                    _profileCard(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgT_z1t-Ft-T2KTvg3zeNhZsQPLfaPEoHSig&usqp=CAU",
                      "Anirban Roy",
                      "Team Lead",
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
