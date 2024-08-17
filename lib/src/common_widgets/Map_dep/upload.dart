import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> fetchDataAndSaveToJson() async {
  final firestore = FirebaseFirestore.instance;

  // Fetch markers
  final markerSnapshot = await firestore.collection('markers').get();
  final markers = markerSnapshot.docs.map((doc) {
    final data = doc.data();
    return {
      'id': doc.id,
      'position': {'lat': data['position'].latitude, 'lng': data['position'].longitude},
      'infoWindow': {'title': data['title']},
    };
  }).toList();

  // Fetch polygons
  final polygonSnapshot = await firestore.collection('polygon').get();
  final polygons = polygonSnapshot.docs.map((doc) {
    final data = doc.data();
    final points = (data['points'] as List)
        .map((point) => {'lat': point.latitude, 'lng': point.longitude})
        .toList();
    return {
      'id': doc.id,
      'points': points,
      'fillColor': data['fillcolor'],
      'strokeColor': data['strokeColor'],
      'strokeWidth': data['strokeWidth'],
    };
  }).toList();

  // Combine data
  final data = {
    'markers': markers,
    'polygons': polygons,
    // Include polylines if needed
  };

  // Save data to JSON file
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/map_data.json';
  final file = File(filePath);
  await file.writeAsString(jsonEncode(data));
}
