import 'package:almquest/screens/screens.dart';
import 'package:almquest/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primarySwatch: kPrimarySwatch,
        backgroundColor: kBackgroundColor,
        fontFamily: GoogleFonts.robotoSerif().fontFamily,
        appBarTheme: const AppBarTheme(
          elevation: 2,
          backgroundColor: kAppBarColor,
        ),
      ),
      home: Home(),
    );
  }
}
