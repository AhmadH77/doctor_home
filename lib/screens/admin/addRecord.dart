import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_medical_info_system/constants/constants.dart';
import 'package:rapid_medical_info_system/controllers/addRecordController.dart';
import 'package:rapid_medical_info_system/widgets/authTextField.dart';
import 'package:rapid_medical_info_system/widgets/background.dart';
import 'package:rapid_medical_info_system/widgets/dropItemField.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({Key? key}) : super(key: key);

  @override
  _AddRecordPageState createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  AddRecordController controller = Get.put(AddRecordController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        withTitle: true,
        title: Text('Add Record',style: TextStyle(color: Constants.teal,fontSize: 30,fontWeight: FontWeight.bold)),
        source: 'AR',
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
                    Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: DropItemField(
                              hintText: controller.isGetPatientLoading.value ? 'Loading...':'Select Patient',
                              onChange: (value) =>
                                  controller.selectedPatient(value),
                              value: controller.selectedPatient.value == '-1' ? null : controller.selectedPatient.value,
                              dropdownItems:
                                  controller.patientsList.value.map((e) {
                                debugPrint('test  ${e.name}');
                                return DropdownMenuItem<String>(
                                    value: e.id, child: Text(e.name));
                              }).toList(),
                            ),
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
                      child: addButton(size),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  addButton(size) {
    return ElevatedButton(
      onPressed: () {
        if (!controller.isLoading.value) {
          if (controller.addRecKey.value.currentState!.validate()) {
            controller.addRecord(context);
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
                "Add",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
      ),
    );
  }
}
