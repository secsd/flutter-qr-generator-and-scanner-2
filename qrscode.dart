import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class QrCodeScan extends StatefulWidget {
  @override
  _QrCodeScanState createState() => _QrCodeScanState();
}

class _QrCodeScanState extends State<QrCodeScan> {
  String result = "Waiting QR Scan Text";

  Future _scanQR() async {
    try {
      ScanResult qrScanResult = await BarcodeScanner.scan();
      String qrResult = qrScanResult.rawContent;
      setState(() {
        result = qrResult as String;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = "Camera permission denied";
        });
      } else {
        setState(() {
          result = "Unkown error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (e) {
      setState(() {
        result = "Unkown error $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _scanQR,
        label: Text("Scan"),
        icon: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text("Qr Scan Code"),
      ),
      body: Center(
          child: Text(
        result,
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }
}
