//model_loader.dart
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

Future<Interpreter> loadInterpreter() async {
  try {
    return await Interpreter.fromAsset('assets/model/model.tflite');
  } catch (e) {
    throw Exception('Error loading model: $e');
  }
}

Future<Map<String, int>> loadLabelMapping() async {
  try {
    final String response = await rootBundle.loadString('assets/model/label_mapping.json');
    final data = json.decode(response) as Map<String, dynamic>;
    return data.map((key, value) => MapEntry(value.toString(), int.parse(key)));
  } catch (e) {
    throw Exception('Error loading label mapping: $e');
  }
}
