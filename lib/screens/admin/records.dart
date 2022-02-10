import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_medical_info_system/constants/constants.dart';
import 'package:rapid_medical_info_system/widgets/background.dart';

import 'addRecord.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({Key? key}) : super(key: key);

  @override
  _RecordsPageState createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        source: 'R',
        withTitle: true,
        title: Text('Records',style: TextStyle(color: Constants.teal,fontSize: 30,fontWeight: FontWeight.bold)),
        child: Text('Records Page Here'),
      ),
      floatingActionButton: addRecordButton(),
    );
  }

  addRecordButton() {
    return FloatingActionButton(
      onPressed: ()=> Get.to(() => AddRecordPage()),
      child: Center(
        child: Icon(Icons.add),
      ),
    );
  }
}
