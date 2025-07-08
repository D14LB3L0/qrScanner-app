import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class ScanTitles extends StatelessWidget {
  final String type;

  const ScanTitles({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(
            context,
            listen: false,
          ).deleteScanById(scans[i].id!);
        },
        child: ListTile(
          leading: Icon(
            type == 'http' ? Icons.keyboard_arrow_right : Icons.map,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scans[i].value),
          subtitle: Text(scans[i].id.toString()),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => print(scans[i].id),
        ),
      ),
    );
  }
}
