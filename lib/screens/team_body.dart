import 'package:almquest/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/cupertino.dart';

class TeamBody extends StatelessWidget {
  const TeamBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: kLightTextColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      color: kBackgroundColor,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const CircleAvatar(
                              radius: 80,
                              foregroundImage: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuptVqZE6-xdsNirk9X1ZzZEUYQlktFIfWHw&usqp=CAU'),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Aditya Das",
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Backend Developer",
                              style: TextStyle(
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
                                  ),
                                  tooltip: 'Linked In',
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(
                                    LineIcons.envelope,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  tooltip: 'Mail ID',
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(
                                    LineIcons.github,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  tooltip: 'GitHub',
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: kLightTextColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      color: kBackgroundColor,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const CircleAvatar(
                              radius: 80,
                              foregroundImage: NetworkImage(
                                  'https://consequence.net/wp-content/uploads/2022/07/tom-cruise.jpg?quality=80'),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Tamonash Bhattacharyya",
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "AI/ML Developer",
                              style: TextStyle(
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
                                  ),
                                  tooltip: 'Linked In',
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(
                                    LineIcons.envelope,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  tooltip: 'Mail ID',
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(
                                    LineIcons.github,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  tooltip: 'GitHub',
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: kLightTextColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      color: kBackgroundColor,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const CircleAvatar(
                              radius: 80,
                              foregroundImage: NetworkImage(
                                  'https://pbs.twimg.com/media/Fj7zP3xXgAAFPG2?format=jpg&name=large'),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Suddhabrato Ghosh",
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Frontend Developer",
                              style: TextStyle(
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
                                  ),
                                  tooltip: 'Linked In',
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(
                                    LineIcons.envelope,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  tooltip: 'Mail ID',
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(
                                    LineIcons.github,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  tooltip: 'GitHub',
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: kLightTextColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      color: kBackgroundColor,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const CircleAvatar(
                              radius: 80,
                              foregroundImage: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgT_z1t-Ft-T2KTvg3zeNhZsQPLfaPEoHSig&usqp=CAU'),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Banchod Roy",
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Frontend Lead",
                              style: TextStyle(
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
                                  ),
                                  tooltip: 'Linked In',
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(
                                    LineIcons.envelope,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  tooltip: 'Mail ID',
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(
                                    LineIcons.github,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  tooltip: 'GitHub',
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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
