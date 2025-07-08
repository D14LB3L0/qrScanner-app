import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/pages.dart';
import 'package:qr_reader/providers/providers.dart';

import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History '),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.delete_forever)),
        ],
      ),
      body: _HomePageBody(),

      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final int currentIndex = uiProvider.selectedMenuOpt;

    // final tempScan = ScanModel(value: 'http://github.com/D14');
    // DBProvider.db.newScan(tempScan).then(print);

    final scanListProvider = Provider.of<ScanListProvider>(
      context,
      listen: false,
    );

    switch (currentIndex) {
      case 0:
        scanListProvider.uploadScansByType('geo');
        return MapsPage();
      case 1:
        scanListProvider.uploadScansByType('http');
        return DirectionsPage();

      default:
        return MapsPage();
    }
  }
}
