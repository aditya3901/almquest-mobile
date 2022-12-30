import 'package:almquest/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TeamBody extends StatelessWidget {
  const TeamBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _profileCard(
      String imageUrl,
      String name,
      String role,
      String linkedin,
      String github,
      String mail,
    ) {
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
                  foregroundImage: AssetImage(imageUrl),
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
                      CupertinoIcons.mail,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    tooltip: 'Mail ID',
                    onPressed: () async {
                      String url = "mailto:$mail";
                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url);
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      LineIcons.linkedinIn,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 28,
                    ),
                    tooltip: 'Linked In',
                    onPressed: () async {
                      if (await canLaunchUrlString(linkedin)) {
                        await launchUrlString(linkedin);
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      LineIcons.github,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 28,
                    ),
                    tooltip: 'GitHub',
                    onPressed: () async {
                      if (await canLaunchUrlString(github)) {
                        await launchUrlString(github);
                      }
                    },
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
                      "assets/team/aditya.jpeg",
                      "Aditya Das",
                      "Backend Developer",
                      "https://www.linkedin.com/in/aditya-das-86069b202/",
                      "https://github.com/aditya3901",
                      "suvosig6d@gmail.com",
                    ),
                    const SizedBox(height: 20),
                    _profileCard(
                      "assets/team/tamonash.jpeg",
                      "Tamonash Bhattacharyya",
                      "AI/ML Developer",
                      "https://www.linkedin.com/in/tamonash-bhattacharyya-b9a527223/",
                      "https://github.com/DevUpTam",
                      "tamonashbhattacharyya2@gmail.com",
                    ),
                    const SizedBox(height: 20),
                    _profileCard(
                      "assets/team/sudo.jpeg",
                      "Suddhabrato Ghosh",
                      "Frontend Developer",
                      "https://www.linkedin.com/in/suddhabrato-ghosh/",
                      "https://github.com/suddhabrato",
                      "suddhabratoghosh@gmail.com",
                    ),
                    const SizedBox(height: 20),
                    _profileCard(
                      "assets/team/anirban.jpeg",
                      "Anirban Roy",
                      "Content Writer",
                      "https://www.linkedin.com/in/wrrikk/",
                      "https://github.com/Wrrikk",
                      "royrik23@gmail.com",
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
