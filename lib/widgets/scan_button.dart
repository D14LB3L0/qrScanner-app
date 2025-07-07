import 'package:flutter/material.dart';

import '../pages/pages.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus, color: Colors.white),
      onPressed: () async {
       final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ScanPage()),
        );

        if (result != null) {
          print("RESULTADO ESCANEADOOOOOOOOOO: $result");
          // Aquí puedes guardar el resultado, llamar a un Provider, etc.
        }
      },
    );
  }
}
