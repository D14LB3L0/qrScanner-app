import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScanTitles(type: 'geo');
  }
}
