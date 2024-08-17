import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = Location();
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  double currentZoom = 13.0;

  static const LatLng _pGooglePlex = LatLng(11.023970, 76.976393);
  LatLng? _currentP;

  Set<Polygon> polygonSet = HashSet<Polygon>();
  Set<Marker> markers = HashSet<Marker>();
  Set<Polyline> polylineSet = HashSet<Polyline>();

  @override
  void initState() {
    super.initState();
    _locationController.onLocationChanged.listen((l) {
      setState(() {
        _currentP = LatLng(l.latitude ?? 0.0, l.longitude ?? 0.0);
      });
    });
    _loadMarkerData();
    _loadPolygonData();
  }

  Future<void> _loadMarkerData() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/map_data.json';
    final file = File(filePath);

    if (await file.exists()) {
      final String response = await file.readAsString();
      final data = await json.decode(response);

      setState(() {
        for (var markerData in data['markers']) {
          markers.add(Marker(
            markerId: MarkerId(markerData['id']),
            position: LatLng(markerData['position']['lat'], markerData['position']['lng']),
            infoWindow: InfoWindow(title: markerData['infoWindow']['title']),
          ));
        }
      });
    }
  }

  Future<void> _loadPolygonData() async {
    final String response = await rootBundle.loadString('assets/extras/map_data.json');
    final data = await json.decode(response);

    setState(() {
      for (var polygonData in data['polygons']) {
        List<LatLng> polygonPoints = [];
        for (var point in polygonData['points']) {
          polygonPoints.add(LatLng(point['lat'], point['lng']));
        }

        Color fillColor = Color(int.parse(polygonData['fillColor'].substring(1, 7), radix: 16) + 0xFF000000).withOpacity(0.3);
        Color strokeColor = Color(int.parse(polygonData['strokeColor'].substring(1, 7), radix: 16) + 0xFF000000);

        polygonSet.add(Polygon(
          polygonId: PolygonId(polygonData['id']),
          points: polygonPoints,
          fillColor: fillColor,
          strokeColor: strokeColor,
          strokeWidth: polygonData['strokeWidth'],
        ));
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _pGooglePlex,
              zoom: currentZoom,
            ),
            onMapCreated: _onMapCreated,
            markers: markers,
            polygons: polygonSet,
            polylines: polylineSet,
          ),
        ],
      ),
    );
  }
}
