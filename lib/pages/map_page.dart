import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/models.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final mapController = MapController();
  double _currentZoom = 13.0;
  late LatLng _scanLatLng;
  late LatLng _currentCenter;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)?.settings.arguments as ScanModel;

    try {
      _scanLatLng = getLatLngFromScan(scan.value);
      _currentCenter = _scanLatLng;
    } catch (e) {
      _scanLatLng = LatLng(-12.0464, -77.0428); // Lima como fallback
      _currentCenter = _scanLatLng;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: _scanLatLng,
              initialZoom: _currentZoom,
              minZoom: 3,
              maxZoom: 18,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
              onTap: (tapPosition, latLng) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Tocaste en: ${latLng.latitude}, ${latLng.longitude}",
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              onPositionChanged: (position, hasGesture) {
                setState(() {
                  _currentZoom = position.zoom ?? _currentZoom;
                  if (position.center != null) {
                    _currentCenter = position.center!;
                  }
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 60.0,
                    height: 60.0,
                    point: _scanLatLng,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 20,
            right: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'zoom_in',
                  mini: true,
                  onPressed: () {
                    setState(() {
                      _currentZoom += 1;
                    });
                    mapController.move(_currentCenter, _currentZoom);
                  },
                  child: const Icon(Icons.zoom_in, color: Colors.white,),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'zoom_out',
                  mini: true,
                  onPressed: () {
                    setState(() {
                      _currentZoom -= 1;
                    });
                    mapController.move(_currentCenter, _currentZoom);
                  },
                  child: const Icon(Icons.zoom_out, color: Colors.white,),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'reset',
                  mini: true,
                  onPressed: () {
                    mapController.move(_scanLatLng, 13.0);
                  },
                  child: const Icon(Icons.my_location, color: Colors.white,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  LatLng getLatLngFromScan(String value) {
    final coords = value.replaceAll('geo:', '').split(',');
    final lat = double.parse(coords[0]);
    final lng = double.parse(coords[1]);
    return LatLng(lat, lng);
  }
}
