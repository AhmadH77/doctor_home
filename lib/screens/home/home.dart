import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_medical_info_system/constants/constants.dart';
import 'package:rapid_medical_info_system/screens/admin/addRecord.dart';
import 'package:rapid_medical_info_system/screens/admin/records.dart';
import 'package:rapid_medical_info_system/screens/auth/login.dart';
import 'package:rapid_medical_info_system/screens/auth/register_med_stuff.dart';
import 'package:rapid_medical_info_system/screens/start.dart';
import 'package:rapid_medical_info_system/widgets/background.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final String? source;

  const HomeScreen({Key? key, required this.source}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 50.0, left: 10, right: 10),
              child: Text(
                'WELCOME !',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
            ),
            widget.source == 'A' ? recordsButton(size) : Container(),
            logout(size)
          ],
        ),
      ),
    );
  }

  recordsButton(size) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () => Get.to(() => RecordsPage()),
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            textStyle: MaterialStateProperty.all(const TextStyle(
              color: Colors.white,
            ))),
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          width: size.width * 0.7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Constants.mid_blue),
          padding: const EdgeInsets.all(0),
          child: const Text(
            "Records",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  logout(size) {
    return ElevatedButton(
      onPressed: () => SharedPreferences.getInstance().then((value) {
        value.clear();
        Get.offAll(() => StartScreen());
      }),
      style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
          textStyle: MaterialStateProperty.all(const TextStyle(
            color: Colors.white,
          ))),
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        width: size.width * 0.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: Constants.teal),
        padding: const EdgeInsets.all(0),
        child: const Text(
          "Log out",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
