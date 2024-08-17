import 'dart:convert';
import 'package:flutter/services.dart';

class LabelEncoder {
  Map<String, int> _labelToIndex;
  Map<int, String> _indexToLabel;

  LabelEncoder._(this._labelToIndex, this._indexToLabel);

  static Future<LabelEncoder> load(String fileName) async {
    final jsonString = await rootBundle.loadString(fileName);
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    // Ensure the map is parsed correctly with proper types
    final labelToIndex = <String, int>{};
    final indexToLabel = <int, String>{};

    jsonMap.forEach((key, value) {
      final intValue = int.tryParse(value.toString());
      if (intValue != null) {
        labelToIndex[key] = intValue;
        indexToLabel[intValue] = key;
      }
    });

    return LabelEncoder._(labelToIndex, indexToLabel);
  }

  int encode(String label) => _labelToIndex[label] ?? -1;
  String decode(int index) => _indexToLabel[index] ?? '';
}
