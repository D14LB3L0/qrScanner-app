import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

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

          // final value = 'geo:15.33.15.66';

          final scanListProvider = Provider.of<ScanListProvider>(
            context,
            listen: false,
          );

          if (value != null) {
            controller.stop();
            scanListProvider.newScan(value);
            Navigator.pop(context, value);
          }
        },
      ),
    );
  }
}
