import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRController extends GetxController{

  var isLoading = true.obs;
  var patientId = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    SharedPreferences.getInstance().then((value) {
      isLoading(false);
      patientId(value.getString('id'));
      debugPrint('test id  ${patientId.value}');
    });
  }
}