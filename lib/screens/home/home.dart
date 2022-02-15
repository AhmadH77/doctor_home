import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rapid_medical_info_system/constants/constants.dart';
import 'package:rapid_medical_info_system/controllers/addRecordController.dart';
import 'package:rapid_medical_info_system/screens/admin/addRecord.dart';
import 'package:rapid_medical_info_system/screens/admin/records.dart';
import 'package:rapid_medical_info_system/screens/auth/login.dart';
import 'package:rapid_medical_info_system/screens/auth/register_med_stuff.dart';
import 'package:rapid_medical_info_system/screens/patient/showQR.dart';
import 'package:rapid_medical_info_system/screens/patient/viewRecord.dart';
import 'package:rapid_medical_info_system/screens/start.dart';
import 'package:rapid_medical_info_system/widgets/background.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final String? source;

  const HomeScreen({Key? key, required this.source}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  AddRecordController recordController = Get.put(AddRecordController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 50.0, left: 10, right: 10),
              child: Text(
                'WELCOME !',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
            ),
            widget.source == 'A' ? recordsButton(size) : Container(),
            widget.source == 'P' ? qrCodeButton(size) : Container(),
            widget.source == 'M' ? scanQRCodeButton(size) : Container(),

            logout(size)
          ],
        ),
      ),
    );
  }

  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      debugPrint('scanData.code ${scanData.code}');
      recordController.qrResult(scanData.code);
      Get.back();
      Get.to(()=>ViewRecordPage());
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }


  recordsButton(size) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () => Get.to(() => RecordsPage()),
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            textStyle: MaterialStateProperty.all(const TextStyle(
              color: Colors.white,
            ))),
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          width: size.width * 0.7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Constants.mid_blue),
          padding: const EdgeInsets.all(0),
          child: const Text(
            "Records",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  qrCodeButton(size) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () => Get.to(()=> ShowQRPage()),
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            textStyle: MaterialStateProperty.all(const TextStyle(
              color: Colors.white,
            ))),
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          width: size.width * 0.7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Constants.mid_blue),
          padding: const EdgeInsets.all(0),
          child: const Text(
            "QR code",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  scanQRCodeButton(size) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () =>
            showDialog(context: context, builder: (context) =>
            AlertDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
          title:
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
              'Scan QR Code',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
              alignment: Alignment.center,
              content:
              Container(
                height: 400,
                width: size.width,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Center(
                        child: QRView(
                          overlayMargin: EdgeInsets.only(top: 30),
                          overlay: QrScannerOverlayShape(
                              borderColor: Constants.dark_blue,
                              borderRadius: 10,
                              borderLength: 30,
                              borderWidth: 10,
                              cutOutSize: scanArea),
                          key: qrKey,
                          onQRViewCreated: _onQRViewCreated,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
        ),),
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            textStyle: MaterialStateProperty.all(const TextStyle(
              color: Colors.white,
            ))),
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          width: size.width * 0.7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Constants.mid_blue),
          padding: const EdgeInsets.all(0),
          child: const Text(
            "Scan QR code",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  logout(size) {
    return ElevatedButton(
      onPressed: () => SharedPreferences.getInstance().then((value) {
        value.clear();
        Get.offAll(() => StartScreen());
      }),
      style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
          textStyle: MaterialStateProperty.all(const TextStyle(
            color: Colors.white,
          ))),
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        width: size.width * 0.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: Constants.teal),
        padding: const EdgeInsets.all(0),
        child: const Text(
          "Log out",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
