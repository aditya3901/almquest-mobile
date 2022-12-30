import 'package:almquest/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              "assets/hero.png",
              height: 300,
            ),
            const SizedBox(height: 40),
            const Text(
              "Help us make the World a Better Place",
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
                primary: const Color(0xFFd97707),
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "JOIN US",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
            const SizedBox(
              width: double.infinity,
              child: Text(
                "About Us",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 14),
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Here on AlmQuest we bring two groups of people together - The ones who have excess food they can donate and the ones who have the opportunity and the scope to distribute that food to the under-priviledged and the ones in need.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kTextColor,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFd97707),
              ),
              onPressed: () {},
              icon: const Icon(Icons.light_mode_outlined),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  "Check Out Some More",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: double.infinity,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "Join Us In ",
                      style: TextStyle(
                        color: kTextColor,
                      ),
                    ),
                    TextSpan(
                      text: "Our Quest",
                      style: TextStyle(
                        color: Color(0xFFd97707),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const SizedBox(
              width: double.infinity,
              child: Text(
                "We provide this platform for bringing two kinds of people or organisation alike together who can fulfil each other's needs.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kLightTextColor,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/donate.png",
                    ),
                  ),
                ),
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
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Text(
                              "Join us as a Donor Now!",
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "You can be an Individual or an Organisation or a Food Chain. Take the first steps.",
                              style: TextStyle(
                                color: kTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/distribute.png",
                    ),
                  ),
                ),
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
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Text(
                              "Join us as a Distributor Now!",
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "You can be an Individual or a Social Service Group or a NGO. Take the first steps.",
                              style: TextStyle(
                                color: kTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 70),
            const Text(
              "Explore Our Awesome Features",
              style: TextStyle(
                color: kTextColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 50),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/features.png",
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFd97707),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        LineIcons.mobilePhone,
                        color: kTextColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Donate on the go",
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "No matter where you are, you can always donate meals in any quantity you wish. We pair you up with the best Distributor for you.",
                      style: TextStyle(
                        color: Color.fromARGB(220, 224, 224, 224),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFd97707),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        LineIcons.alternateExchange,
                        color: kTextColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Efficient Exchange",
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Whether you are a donor or a distributor, we chose the best place for your exchange. We regard your convenience the most and provide you with the best directions to exchange point.",
                      style: TextStyle(
                        color: Color.fromARGB(220, 224, 224, 224),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFd97707),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        LineIcons.truck,
                        color: kTextColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "See Where Your Package Goes",
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "With AlmQuest keeping track of when the package is received by the distributor and when it gets finally distributed, you can be rest assured that your goodwill meets its right end.",
                      style: TextStyle(
                        color: Color.fromARGB(220, 224, 224, 224),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "What Our Users Say",
              style: TextStyle(
                color: kTextColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: kLightTextColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              color: kBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "\"We have been in business for almost a decade now and the most morally derogatory problem that we had faced was the amount of food we had to throw away on a daily basis because we simply did not have the means to donate. But now with AlmQuest we can do that effortlessly.\"",
                      style: TextStyle(
                        color: Color.fromARGB(220, 224, 224, 224),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: kTextColor,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                              "https://im1.dineout.co.in/images/uploads/restaurant/sharpen/4/g/c/p46886-164187619861dd0ae6a708c.jpg?tr=tr:n-medium",
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Food Heaven",
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Family Restaurant",
                              style: TextStyle(
                                color: kLightTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: kLightTextColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              color: const Color(0xFFd97707),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "\"AlmQuest will hopefully help a lot in social development.\"",
                      style: TextStyle(
                        color: kTextColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: kTextColor,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1531590878845-12627191e687?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Jeny Doe",
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Tech Professional",
                              style: TextStyle(
                                color: kLightTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: kLightTextColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              color: kBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "\"We are a group of teachers at a High School in a remote area in the Nadia district of West Bengal, India. We have a lot of under-nourished population in the region surrroundingour school. Government provided food rations only help some and despite our best intention of feeding these people, we never had a food source to make that feasible. Well, now with AlmQuest we can do just that.\"",
                      style: TextStyle(
                        color: Color.fromARGB(220, 224, 224, 224),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: kTextColor,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                              "https://www.ngoregistration.org/wp-content/uploads/2014/07/non-government-organization-300x197.jpg",
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "New Light",
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "A teacher-run NGO",
                              style: TextStyle(
                                color: kLightTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "AlmQuest",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kTextColor,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "© Copyright 2022. All Rights Reserved.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kTextColor,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
