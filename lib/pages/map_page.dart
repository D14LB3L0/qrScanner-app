import 'package:flutter/material.dart';

import '../models/models.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)?.settings.arguments as ScanModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: Center(child: Text(scan.value)));
  }
}
