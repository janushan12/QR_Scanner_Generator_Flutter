import 'package:application/screens/generate_screen/qr_image.dart';
import 'package:flutter/material.dart';

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({super.key});

  @override
  State<GenerateQRCode> createState() => _GenerateQRCodeState();
}

class _GenerateQRCodeState extends State<GenerateQRCode> {
  TextEditingController controller = TextEditingController();
  //final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter the details'),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRImage(controller: controller),
                    ),
                  );
                },
                child: const Text('Generate QR Code')),
          ],
        ),
      ),
    );
  }
}
