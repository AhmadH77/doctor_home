import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_medical_info_system/constants/constants.dart';
import 'package:rapid_medical_info_system/controllers/addRecordController.dart';
import 'package:rapid_medical_info_system/screens/admin/updateRecord.dart';
import 'package:rapid_medical_info_system/widgets/background.dart';

import 'addRecord.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({Key? key}) : super(key: key);

  @override
  _RecordsPageState createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  AddRecordController controller = Get.put(AddRecordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        source: 'R',
        withTitle: true,
        title: Text('Records',
            style: TextStyle(
                color: Constants.teal,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
        child: Obx(() => controller.isLoading.value
            ? CircularProgressIndicator()
            : recordList()),
      ),
      floatingActionButton: addRecordButton(),
    );
  }

  addRecordButton() {
    return FloatingActionButton(
      onPressed: () {
        controller.clear();
        Get.to(() => AddRecordPage());
      },
      child: Center(
        child: Icon(Icons.add),
      ),
    );
  }

  recordList() {

    return Padding(
      padding: const EdgeInsets.only(top: 75.0),
      child: ListView.builder(
        itemCount: controller.recordsList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 8,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ExpansionTile(

              childrenPadding: EdgeInsets.zero,
              tilePadding: EdgeInsets.zero,
              title: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Patient name ',
                          style: TextStyle(fontSize: 15, color: Constants.teal),
                        ),
                        TextSpan(
                          text: controller.recordsList[index].patient.name.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15, color: Constants.teal),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                          onTap: () {
                            controller.initData(index);
                            Get.to(()=>UpdateRecordPage(index));
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit_outlined,
                              color: Constants.teal,
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                          onTap: () {
                            controller.deleteRecord(context, index);
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                          )),
                    ),

                  ],
                ),

                ListTile(
                  title: Text('Disease'),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                '${controller.recordsList[index].disease}',
                style: TextStyle(fontWeight: FontWeight.w300)),
                  ),
                ),
                ListTile(
                  title: Text('Endemic'),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        '${controller.recordsList[index].endemic == '' ? '-' : controller.recordsList[index].endemic}',
                        style: TextStyle(fontWeight: FontWeight.w300)),
                  ),
                ),
                ListTile(
                  title: Text('Diagnosis'),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        '${controller.recordsList[index].diagnosis == '' ? '-' : controller.recordsList[index].diagnosis}',
                        style: TextStyle(fontWeight: FontWeight.w300)),
                  ),
                ),
                ListTile(
                  title: Text('Drugs'),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        '${controller.recordsList[index].drugs == '' ? '-' : controller.recordsList[index].drugs}',
                        style: TextStyle(fontWeight: FontWeight.w300)),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
