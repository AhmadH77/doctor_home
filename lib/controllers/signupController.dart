import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:rapid_medical_info_system/constants/constants.dart';
import 'package:rapid_medical_info_system/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  var nameController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var idController = TextEditingController();
  var registerKey = GlobalKey<FormState>().obs;
  var registerMedKey = GlobalKey<FormState>().obs;
  var registeradminKey = GlobalKey<FormState>().obs;
  var selected = 1.obs;
  var gender = "".obs;
  var isLoading = false.obs;
  String api = "http://firstmedicalsystem.000webhostapp.com/api";

  Future<void> signUp(context) async {
    isLoading(true);
    debugPrint('signUp start  123 $api');
    var url = Uri.parse("$api/register_patient");
    try {
      post(url, body: {
        "national_id": idController.text,
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "phone": phoneController.text,
      }).then((value) {
        isLoading(false);
        debugPrint('signUp patient  ${value.body}');
        var response = json.decode(value.body);

        if(response['status']) {
          SharedPreferences.getInstance().then((value){
            value.setBool("logged", true);
            value.setString("id", idController.text);
            value.setString("type", 'P');
          });
          Get.offAll(()=> HomeScreen(source: 'P',));
        }
        else{
          showToast(response['msg'] ?? 'Something went wrong!',
              context: context,
              animation: StyledToastAnimation.slideFromTop,
              position: StyledToastPosition.top,
              animDuration: Duration(seconds: 1),
              duration: Duration(seconds: 4),
              backgroundColor: Colors.red,
              curve: Curves.elasticOut,
              reverseCurve: Curves.fastOutSlowIn);

        }
      }).timeout(const Duration(seconds: 10)).catchError((e) {
        isLoading(false);
        debugPrint('signUpMed  Exception $e');
        showToast('Something went wrong!',
            context: context,
            animation: StyledToastAnimation.slideFromTop,
            position: StyledToastPosition.top,
            animDuration: Duration(seconds: 1),
            duration: Duration(seconds: 4),
            backgroundColor: Colors.red,
            curve: Curves.elasticOut,
            reverseCurve: Curves.fastOutSlowIn);
      });
    } on Exception catch (e) {
      // TODO
      isLoading(false);
      debugPrint('signUp patient Exception $e');
      showToast('Something went wrong!',
          context: context,
          animation: StyledToastAnimation.slideFromTop,
          position: StyledToastPosition.top,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red,
          curve: Curves.elasticOut,
          reverseCurve: Curves.fastOutSlowIn);

    }


  }

  Future<void> signUpMed(context) async {
    isLoading(true);
    debugPrint('signUpMed start');
    var url = Uri.parse("$api/register_doctor");
    try {
      post(url, body: {
        "national_id": idController.text,
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "phone": phoneController.text,
      }).then((value) {
        isLoading(false);
        debugPrint('signUpMed   ${value.body}');
        var response = json.decode(value.body);

        if(response['status']) {
          SharedPreferences.getInstance().then((value){
            value.setBool("logged", true);
            value.setString("id", idController.text);
            value.setString("type", 'M');
          });
          Get.offAll(()=> HomeScreen(source: 'M',));

        }
        else{
          showToast(response['msg'] ?? 'Something went wrong!',
              context: context,
              animation: StyledToastAnimation.slideFromTop,
              position: StyledToastPosition.top,
              animDuration: Duration(seconds: 1),
              duration: Duration(seconds: 4),
              backgroundColor: Colors.red,
              curve: Curves.elasticOut,
              reverseCurve: Curves.fastOutSlowIn);

        }
      }).timeout(const Duration(seconds: 10))
          .catchError((e) {
        isLoading(false);
        debugPrint('signUpMed  Exception $e');
        showToast('Something went wrong!',
            context: context,
            animation: StyledToastAnimation.slideFromTop,
            position: StyledToastPosition.top,
            animDuration: Duration(seconds: 1),
            duration: Duration(seconds: 4),
            backgroundColor: Colors.red,
            curve: Curves.elasticOut,
            reverseCurve: Curves.fastOutSlowIn);
      });
    } on Exception catch (e) {
      // TODO
      isLoading(false);
      debugPrint('signUpMed  Exception $e');
      showToast('Something went wrong!',
          context: context,
          animation: StyledToastAnimation.slideFromTop,
          position: StyledToastPosition.top,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red,
          curve: Curves.elasticOut,
          reverseCurve: Curves.fastOutSlowIn);

    }


  }

  Future<void> signUpAdmin(context) async {
    isLoading(true);
    debugPrint('signUpMed start');
    var url = Uri.parse("$api/register_doctor");
    try {
      post(url, body: {
        "national_id": idController.text,
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "phone": phoneController.text,
      }).then((value) {
        isLoading(false);
        debugPrint('signUpMed   ${value.body}');

      }).timeout(const Duration(seconds: 10))
          .catchError((e) {
        isLoading(false);
        debugPrint('signUpMed  Exception $e');
        showToast('Something went wrong!',
            context: context,
            animation: StyledToastAnimation.slideFromTop,
            position: StyledToastPosition.top,
            animDuration: Duration(seconds: 1),
            duration: Duration(seconds: 4),
            backgroundColor: Colors.red,
            curve: Curves.elasticOut,
            reverseCurve: Curves.fastOutSlowIn);
      });
    } on Exception catch (e) {
      // TODO
      isLoading(false);
      debugPrint('signUpMed  Exception $e');
      showToast('Something went wrong!',
          context: context,
          animation: StyledToastAnimation.slideFromTop,
          position: StyledToastPosition.top,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red,
          curve: Curves.elasticOut,
          reverseCurve: Curves.fastOutSlowIn);

    }


  }

  resetPassword() async {
    isLoading(true);
    debugPrint('email: ${emailController.text}');

  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    idController.clear();
  }
}
