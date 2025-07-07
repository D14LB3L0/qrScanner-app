import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MobileScannerController();

    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR')),
      body: MobileScanner(
        controller: controller,
        onDetect: (barcodeCapture) {
          final barcode = barcodeCapture.barcodes.first;
          final value = barcode.rawValue;

          // final value = 'https://https://github.com/D14LB3L0';

          if (value != null) {
            controller.stop(); 
            Navigator.pop(context, value);
          }
        },
      ),
    );
  }
}
