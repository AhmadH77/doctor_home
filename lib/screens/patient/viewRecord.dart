import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_medical_info_system/constants/constants.dart';
import 'package:rapid_medical_info_system/controllers/addRecordController.dart';
import 'package:rapid_medical_info_system/widgets/background.dart';

class ViewRecordPage extends StatefulWidget {
  const ViewRecordPage({Key? key}) : super(key: key);

  @override
  _ViewRecordPageState createState() => _ViewRecordPageState();
}

class _ViewRecordPageState extends State<ViewRecordPage> {
  AddRecordController controller = Get.put(AddRecordController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getRecord(controller.qrResult.value);
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
          source: 'M',
          child: SingleChildScrollView(
            child: Obx(()=> controller.isGetRecordLoading.value
                ? CircularProgressIndicator()
                : Column(
              children: [
                //
                Container(
                  padding: EdgeInsets.all(10),
                  width: size.width,
                  color: Constants.light_blue,
                  child: Text(
                    'Patient Medical Record',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                        color: Constants.dark_blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  color: Constants.light_light_blue,
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 120,
                        color: Constants.dark_blue,
                      ),
                      SizedBox(
                        height: 180,
                        child: VerticalDivider(
                            thickness: 3,
                            indent: 20,
                            endIndent: 0,
                            width: 20,
                            color: Constants.tr_light_blue),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: 'Name : ', style: TextStyle(color: Constants.dark_blue,fontWeight: FontWeight.bold)),
                                TextSpan(text: '${controller.record.value.patient.name}' ,style: TextStyle(color: Constants.dark_blue)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: 'Age : ' ,style: TextStyle(color: Constants.dark_blue,fontWeight: FontWeight.bold)),
                                TextSpan(text: '${controller.record.value.patient.age}', style: TextStyle(color: Constants.dark_blue)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: 'Number : ', style: TextStyle(color: Constants.dark_blue,fontWeight: FontWeight.bold)),
                                TextSpan(text: '${controller.record.value.patient.phone}', style: TextStyle(color: Constants.dark_blue)),
                              ],
                            ),
                          ),

                        ],
                      ),

                    ],
                  ),
                ),

                //
                Container(
                  padding: EdgeInsets.all(10),
                  width: size.width,
                  color: Constants.light_blue,
                  child: Text(
                    'Medical Info',
                    style: TextStyle(
                        color: Constants.dark_blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  color: Constants.light_light_blue,
                  child: Column(
                    children: [
                      Card(
                        margin: EdgeInsets.only(bottom: 0,left: 8,right: 8,top: 8),
                        color: Constants.dark_blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Text('Disease',style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(bottom: 8,left: 8,right: 8,top: 0),
                        color: Colors.white,

                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Text(controller.record.value.disease,style: TextStyle(color: Constants.dark_blue),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  color: Constants.light_light_blue,
                  child: Column(
                    children: [
                      Card(
                        margin: EdgeInsets.only(bottom: 0,left: 8,right: 8,top: 8),
                        color: Constants.dark_blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Text('Endemic',style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(bottom: 8,left: 8,right: 8,top: 0),
                        color: Colors.white,

                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Text(
                                controller.record.value.endemic == '' ? '-' : controller.record.value.endemic ,style: TextStyle(color: Constants.dark_blue),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    addDiagnosisButton(size),
                    addMedicineButton(size)
                  ],
                )

              ],
            )),
          )),
    );
  }


  addMedicineButton(size) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        
        onPressed: () {},
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.only(left: 10,right: 10,)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            backgroundColor: MaterialStateProperty.all(Constants.mid_blue),
            textStyle: MaterialStateProperty.all(const TextStyle(
              color: Colors.white,
            ))),
        child: Container(
          alignment: Alignment.center,
          height: 50.0,

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Constants.mid_blue),
          padding: const EdgeInsets.all(0),
          child: const Text(
            "Add Medicine",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  addDiagnosisButton(size) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.only(left: 10,right: 10)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            backgroundColor: MaterialStateProperty.all(Constants.mid_blue),
            textStyle: MaterialStateProperty.all(const TextStyle(
              color: Colors.white,
            ))),
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Constants.mid_blue),
          padding: const EdgeInsets.all(0),
          child: const Text(
            "Add Diagnosis",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
