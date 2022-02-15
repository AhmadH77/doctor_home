import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:rapid_medical_info_system/constants/constants.dart';
import 'package:rapid_medical_info_system/model/patient.dart';
import 'package:rapid_medical_info_system/model/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRecordController extends GetxController{
  var diseaseController = TextEditingController();
  var endemicController = TextEditingController();
  var selectedPatient = '-1'.obs;
  var qrResult = ''.obs;
  var recordIndex = 0.obs;
  var addRecKey = GlobalKey<FormState>().obs;
  var isLoading = false.obs;
  var isGetRecordLoading = false.obs;
  var isDeleteLoading = false.obs;
  var isGetPatientLoading = false.obs;
  var record = Rx<Record>(Record(0,0,'','','','',Patient('0','','','','','','','')));
  String api = "http://firstmedicalsystem.000webhostapp.com/api";

  var patientsList = <Patient>[].obs;
  var recordsList = <Record>[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPatients();
    getRecords();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    diseaseController.clear();
    endemicController.clear();
  }

  initData(index){
    diseaseController.text = recordsList[index].disease.toString();
    endemicController.text = recordsList[index].endemic.toString();
    selectedPatient(recordsList[index].patient_id.toString());
    recordIndex(index);
  }

  getRecord(id) async {
    isGetRecordLoading(true);
    debugPrint('getRecord start  123 $api   $id');

    var url = Uri.parse("$api/show_record_by_id");
    try {
      post(url,body: {
        "id": id,
      }).then((value) {
        debugPrint('getRecord  ${value.body}');
        var response = json.decode(value.body);
        isGetRecordLoading(false);
        debugPrint('getRecord  ${Record.fromJson(response['Record'][0])}');
        record(Record.fromJson(response['Record'][0]));


      });
    } on Exception catch (e) {
      // TODO
      isGetRecordLoading(false);
      debugPrint('getRecord Exception $e');
    }
  }

  getPatients(){
    isGetPatientLoading(true);
    patientsList.clear();
    debugPrint('getPatients start  123 $api');
    var url = Uri.parse("$api/show_patient");
    try {
      get(url).then((value) {
        debugPrint('getPatients  ${value.body}');
        var response = json.decode(value.body);
        isGetPatientLoading(false);
        debugPrint('getPatients  ${Patient.fromJson(response['patient'][0])}');

        for(var patient in response['patient']){
          patientsList.add(Patient.fromJson(patient));
        }
      });
    } on Exception catch (e) {
      // TODO
      isGetPatientLoading(false);
      debugPrint('getPatients Exception $e');
    }
  }

  getRecords(){
    isLoading(true);
    recordsList.clear();
    debugPrint('getRecords start  123 $api');
    var url = Uri.parse("$api/show_record");
    try {
      get(url).then((value) {
        debugPrint('getRecords  ${value.body}');
        var response = json.decode(value.body);
        isLoading(false);
        debugPrint('getRecords  ${Record.fromJson(response['Record'][0])}');

        for(var record in response['Record']){
          recordsList.add(Record.fromJson(record));
        }
      });
    } on Exception catch (e) {
      // TODO
      isLoading(false);
      debugPrint('getRecords Exception $e');
    }
  }

  void addRecord(context) {
    isLoading(true);
    debugPrint('addRecord start  123 $api ');
    var url = Uri.parse("$api/add_record");
    try {
      post(url, body: {
        "id": selectedPatient.value,
        "disease": diseaseController.text,
        "endemic": endemicController.text,
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
          diseaseController.clear();
          endemicController.clear();
          selectedPatient('-1');
          getRecords();

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

  void updateRecord(context, index) {
    isLoading(true);
    debugPrint('updateRecord start  123 $api ${recordsList[recordIndex.value].id}');
    var url = Uri.parse("$api/update_record");
    try {
      post(url, body: {
        "id": recordsList[recordIndex.value].id.toString(),
        "disease": diseaseController.text,
        "endemic": endemicController.text,
      }).then((value) {
        isLoading(false);
        debugPrint('updateRecord  ${value.body}');
        var response = json.decode(value.body);

        if(response['status']) {
          showToast(response['msg'] ?? 'The record has been Updated Successfully',
              context: context,
              animation: StyledToastAnimation.slideFromTop,
              position: StyledToastPosition.top,
              animDuration: Duration(seconds: 1),
              duration: Duration(seconds: 4),
              backgroundColor: Constants.teal,
              curve: Curves.elasticOut,
              reverseCurve: Curves.fastOutSlowIn);
          Get.back();
          Future.delayed(Duration(seconds: 1),()=>getRecords());
          diseaseController.clear();
          endemicController.clear();
          selectedPatient('-1');

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
        debugPrint('updateRecord  Exception $e');
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
      debugPrint('updateRecord Exception $e');
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

  void deleteRecord(context, index) {
    isDeleteLoading(true);
    debugPrint('deleteRecord start  123 $api ${recordsList[index].id}');
    var url = Uri.parse("$api/delete_record");
    try {
      post(url, body: {
        "id": recordsList[index].id.toString(),
      }).then((value) {
        isDeleteLoading(false);
        debugPrint('deleteRecord  ${value.body}');
        var response = json.decode(value.body);

        if(response['status']) {
          showToast(response['msg'] ?? 'The record has been Updated Successfully',
              context: context,
              animation: StyledToastAnimation.slideFromTop,
              position: StyledToastPosition.top,
              animDuration: Duration(seconds: 1),
              duration: Duration(seconds: 4),
              backgroundColor: Constants.teal,
              curve: Curves.elasticOut,
              reverseCurve: Curves.fastOutSlowIn);
          getRecords();


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
        isDeleteLoading(false);
        debugPrint('deleteRecord  Exception $e');
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
      isDeleteLoading(false);
      debugPrint('deleteRecord Exception $e');
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

  clear(){
    diseaseController.clear();
    endemicController.clear();
    selectedPatient('-1');
  }
}