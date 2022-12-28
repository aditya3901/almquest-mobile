import 'package:flutter/material.dart';
import '../widgets/navigation_drawer.dart';
import 'package:almquest/utils/constants.dart';
import 'package:almquest/screens/team_body.dart';

class Team extends StatelessWidget {
  const Team({Key? key}) : super(key: key);

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
        body: const TeamBody());
  }
}
