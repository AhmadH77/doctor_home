import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:rapid_medical_info_system/constants/constants.dart';
import 'package:rapid_medical_info_system/model/patient.dart';

class AddRecordController extends GetxController{
  var diseaseController = TextEditingController();
  var selectedPatient = '-1'.obs;
  var addRecKey = GlobalKey<FormState>().obs;
  var isLoading = false.obs;
  var isGetPatientLoading = false.obs;
  String api = "http://firstmedicalsystem.000webhostapp.com/api";

  var patientsList = [].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPatients();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    diseaseController.clear();
  }
  getPatients(){
    isGetPatientLoading(true);
    debugPrint('getPatients start  123 $api');
    var url = Uri.parse("$api/show_patient");
    try {
      get(url).then((value) {
        debugPrint('getPatients  ${value.body}');
        var response = json.decode(value.body);
        isGetPatientLoading(false);
        debugPrint('getPatients  ${response['patient']}');

        for(var patient in response['patient']){
          patientsList.add(Patient(patient['id'].toString(), patient['name'], patient['email'], patient['phone'], '', patient['password'], patient['national_id']));
        }
      });
    } on Exception catch (e) {
      // TODO
      isGetPatientLoading(false);
      debugPrint('getPatients Exception $e');
    }
  }

  void addRecord(context) {
    isLoading(true);
    debugPrint('addRecord start  123 $api');
    var url = Uri.parse("$api/add_record");
    try {
      post(url, body: {
        "id": selectedPatient.value,
        "disease": diseaseController.text,
      }).then((value) {
        isLoading(false);
        debugPrint('addRecord  ${value.body}');
        var response = json.decode(value.body);

        if(response['status']) {
          showToast(response['msg'] ?? 'The record has been Added Successfully',
              context: context,
              animation: StyledToastAnimation.slideFromTop,
              position: StyledToastPosition.top,
              animDuration: Duration(seconds: 1),
              duration: Duration(seconds: 4),
              backgroundColor: Constants.teal,
              curve: Curves.elasticOut,
              reverseCurve: Curves.fastOutSlowIn);
          Get.back();

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
        debugPrint('addRecord  Exception $e');
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
      debugPrint('addRecord Exception $e');
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
}