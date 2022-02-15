import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_medical_info_system/constants/constants.dart';
import 'package:rapid_medical_info_system/controllers/addRecordController.dart';
import 'package:rapid_medical_info_system/model/patient.dart';
import 'package:rapid_medical_info_system/widgets/authTextField.dart';
import 'package:rapid_medical_info_system/widgets/background.dart';
import 'package:rapid_medical_info_system/widgets/dropItemField.dart';

class UpdateRecordPage extends StatefulWidget {
  int? index;
   UpdateRecordPage(index, {Key? key}) : super(key: key);

  @override
  _UpdateRecordPageState createState() => _UpdateRecordPageState();
}

class _UpdateRecordPageState extends State<UpdateRecordPage> {
  AddRecordController controller = Get.put(AddRecordController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        withTitle: true,
        title: Text('Edit Record',style: TextStyle(color: Constants.teal,fontSize: 30,fontWeight: FontWeight.bold)),
        source: 'ER',
        child: SingleChildScrollView(
          child: Obx(() => Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: controller.addRecKey.value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/report2.png',height: 150,),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: AuthTextField(
                      required: false,
                      enabled: false,
                      borderColor: Colors.black,
                      controller: TextEditingController(),
                      labelText: controller.recordsList[controller.recordIndex.value].patient.name
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: AuthTextField(
                      required: false,
                      borderColor: Colors.black,
                      controller: controller.endemicController,
                      labelText: "Please specify Endemic if have any"),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: AuthTextField(
                      maxLines: 10,
                      borderColor: Colors.black,
                      controller: controller.diseaseController,
                      labelText: "Enter Disease"),
                ),
                SizedBox(height: size.height * 0.05),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: updateButton(size),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  updateButton(size) {
    return ElevatedButton(
      onPressed: () {
        if (!controller.isLoading.value) {
          if (controller.addRecKey.value.currentState!.validate()) {
            controller.updateRecord(context,widget.index);
          }
        }
      },
      style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
          textStyle: MaterialStateProperty.all(const TextStyle(
            color: Colors.white,
          ))),
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        width: size.width * 0.3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Constants.dark_teal),
        padding: const EdgeInsets.all(0),
        child: Obx(() => controller.isLoading.value
            ? const CircularProgressIndicator(
          color: Colors.white,
        )
            : const Text(
          "Update",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
