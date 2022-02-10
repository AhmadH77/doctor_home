import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:rapid_medical_info_system/constants/constants.dart';
import 'package:rapid_medical_info_system/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var idController = TextEditingController();
  var nameController = TextEditingController();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var loginKey = GlobalKey<FormState>().obs;
  var loginMedKey = GlobalKey<FormState>().obs;
  var isLoading = false.obs;
  var isPatientUser = ''.obs;
   String api = "http://firstmedicalsystem.000webhostapp.com/api";

  Future<void> logIn(context) async {
    isLoading(true);
    debugPrint('logIn start');
    var url = Uri.parse("$api/login_patient");
    try {
      post(url, body: {
        "national_id": idController.text,
        "password": passwordController.text,
      }).then((value) {
        var response = json.decode(value.body);

        isLoading(false);
        debugPrint('logIn patient  ${value.body}');
        if(response['status']){
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
      debugPrint('logIn patient Exception $e');
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

  Future<void> logInMedStuff(context) async {
    isLoading(true);
    debugPrint('logInMedStuff start');
    var url = Uri.parse("$api/login_doctor");
    try {
      post(url, body: {
        "national_id": idController.text,
        "password": passwordController.text,
      }).then((value) {
        var response = json.decode(value.body);
        isLoading(false);
        debugPrint('logInMedStuff patient $response ${response['status']}');
        if(response['status']){
          SharedPreferences.getInstance().then((value){
            value.setBool("logged", true);
            value.setString("id", idController.text);
            value.setString("type", 'M');
          });
          Get.offAll(()=> HomeScreen(source: 'M'));
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
      debugPrint('logInMedStuff patient Exception $e');
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

  Future<void> logInAdmin(context) async {
    isLoading(true);
    debugPrint('logInAdmin start');
    var url = Uri.parse("$api/login_admin");
    try {
      post(url, body: {
        "email": emailController.text,
        "password": passwordController.text,
      }).then((value) {
        var response = json.decode(value.body);
        isLoading(false);
        debugPrint('logInAdmin patient $response ${response['status']}');
        if(response['status']){
          SharedPreferences.getInstance().then((value){
            value.setBool("logged", true);
            value.setString("id", idController.text);
            value.setString("type", 'A');
          });
          Get.offAll(()=> HomeScreen(source: 'A'));
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
        debugPrint('logInAdmin  Exception $e');
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
      debugPrint('logInAdmin patient Exception $e');
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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    emailController.clear();
    passwordController.clear();
  }
}
