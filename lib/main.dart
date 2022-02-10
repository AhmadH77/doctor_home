import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_medical_info_system/constants/constants.dart';
import 'package:rapid_medical_info_system/screens/auth/login.dart';
import 'package:rapid_medical_info_system/screens/auth/login_med_stuff.dart';
import 'package:rapid_medical_info_system/screens/auth/register_med_stuff.dart';

import 'screens/start.dart';

void main() {
  runApp(const GetMaterialApp(home:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hajj Health',
      theme: ThemeData(
        primarySwatch: Constants().createMaterialColor(Constants.teal),
        primaryColor: Constants().createMaterialColor(Constants.teal),

      ),
      home: StartScreen(),
    );
  }
}
