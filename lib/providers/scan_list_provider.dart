import 'package:flutter/material.dart';
import 'package:qr_reader/models/models.dart';
import 'package:qr_reader/providers/providers.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = 'http';

  newScan(String value) async {
    final newScan = ScanModel(value: value);
    final id = await DBProvider.db.newScan(newScan);

    newScan.id = id;

    if (selectedType == newScan.type) {
      scans.add(newScan);
      notifyListeners();
    }
  }

  uploadScans() async{
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans!];

    notifyListeners();
  }

  uploadScansByType(String type) async{
    final scans= await DBProvider.db.getScansByType(type);
    this.scans = [...scans!];
    selectedType = type;
    notifyListeners();
  }

  deleteAll() async{
    await DBProvider.db.deleteAllScans();
    scans = [];

    notifyListeners();
  }

  deleteScanById(int id) async{
    await DBProvider.db.deleteScan(id);
  }

}
