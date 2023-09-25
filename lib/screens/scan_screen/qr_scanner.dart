import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 5,
          child: QRView(
            key: qrkey,
            overlay: QrScannerOverlayShape(
              borderWidth: 10,
              borderLength: 20,
              borderRadius: 10,
              borderColor: Theme.of(context).highlightColor,
              cutOutSize: MediaQuery.of(context).size.width * 0.8,
            ),
            onQRViewCreated: onQRViewCamera,
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Center(
              child: (result != null)
                  ? Text(
                      'Data:${result!.code}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        backgroundColor: Colors.amberAccent,
                      ),
                    )
                  : const Text(
                      'Scan a code',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        backgroundColor: Colors.amberAccent,
                      ),
                    ),
            ),
          ),
        )
      ]),
    );
  }

  void onQRViewCamera(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
