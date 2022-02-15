import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rapid_medical_info_system/constants/constants.dart';
import 'package:rapid_medical_info_system/controllers/qrController.dart';
import 'package:rapid_medical_info_system/widgets/background.dart';

class ShowQRPage extends StatefulWidget {
  const ShowQRPage({Key? key}) : super(key: key);

  @override
  _ShowQRPageState createState() => _ShowQRPageState();
}

class _ShowQRPageState extends State<ShowQRPage> {
  QRController controller = Get.put(QRController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        source: 'M',
        child: Container(
          color: Constants.tr_light_blue_op,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Container(
              color: Constants.light_light_blue_op,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(colors: [
                          Constants.dark_blue,
                          Constants.mid_blue,
                          Constants.blue,
                        ])),
                    child: Text(
                      'QR Code',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  Center(
                    child: Obx(() => controller.isLoading.value
                        ? CircularProgressIndicator()
                        : Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.white,
                            child: QrImage(
                              padding: EdgeInsets.all(20),
                              data: controller.patientId.value,
                              version: QrVersions.auto,
                              size: 300.0,
                            ),
                          )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
