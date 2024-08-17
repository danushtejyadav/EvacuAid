import 'package:evacuaid/src/common_widgets/model/model_loader.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:math' as Math;// Ensure this import is correct based on your project structure

class DonatingPage extends StatefulWidget {
  @override
  _DonatingPageState createState() => _DonatingPageState();
}

class _DonatingPageState extends State<DonatingPage> {
  late Map<String, int> labelMapping;
  String _output = "Predicted Calories will be shown here";
  late Interpreter _interpreter;
  List<Map<String, TextEditingController>> foodItems = [];
  double _predictedCalories = 0.0;

  @override
  void initState() {
    super.initState();
    loadModelAndMapping();
    addFoodItemInput();
  }

  Future<void> loadModelAndMapping() async {
    try {
      _interpreter = await loadInterpreter();
      labelMapping = await loadLabelMapping();
    } catch (e) {
      print("Error loading model or label mapping: $e");
    }
  }

  Future<void> predictCalories() async {
    double totalCalories = 0.0;
    bool allItemsValid = true;

    for (var item in foodItems) {
      final foodItemController = item['foodItem'];
      final weightController = item['weight'];
      final foodItem = foodItemController!.text.toLowerCase();
      final weight = double.tryParse(weightController!.text) ?? 100;

      if (labelMapping.containsKey(foodItem)) {
        int encodedLabel = labelMapping[foodItem] ?? -1;
        var input = [encodedLabel];
        var output = List.filled(1, 0).reshape([1, 1]);

        _interpreter.run(input, output);

        double caloriesPer100g = output[0][0];
        totalCalories += (caloriesPer100g * weight) / 100;
      } else {
        allItemsValid = false;
        break;
      }
    }

    setState(() {
      if (allItemsValid) {
        _predictedCalories = totalCalories;
        _output = "Total calories: ${totalCalories.toStringAsFixed(2)} kcal";
      } else {
        _output = "One or more food items not found in label mapping";
      }
    });
  }

  Future<void> allocateResources() async {
    final location = Location();
    final userLocation = await location.getLocation();
    final double userLatitude = userLocation.latitude ?? 0.0;
    final double userLongitude = userLocation.longitude ?? 0.0;

    final familiesSnapshot = await FirebaseFirestore.instance.collection('families').get();

    List<Map<String, dynamic>> familiesWithDistance = [];

    for (var doc in familiesSnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final double? familyLatitude = double.tryParse(data['latitude']?.toString() ?? '');
      final double? familyLongitude = double.tryParse(data['longitude']?.toString() ?? '');
      final bool allocated = data['allocated'] == 'yes';
      final bool needHelp = data['needHelp'] == 'no';

      if (familyLatitude != null && familyLongitude != null && !allocated) {
        final double distance = calculateDistance(userLatitude, userLongitude, familyLatitude, familyLongitude);
        familiesWithDistance.add({
          'id': doc.id,
          'distance': distance,
          'totalCalories': double.tryParse(data['totalCalories']?.toString() ?? ''),
          'needs': data['additionalNeeds'],
          'members': data['numberOfFamilyMembers'],
          'latitude': familyLatitude,
          'longitude': familyLongitude,
        });
      }
    }

    // Sort families by distance
    familiesWithDistance.sort((a, b) => a['distance'].compareTo(b['distance']));

    // Show sorted list to user
    if (familiesWithDistance.isNotEmpty) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select a Family'),
              content: SingleChildScrollView(
                child: Column(
                  children: familiesWithDistance.map((family) {
                    return ListTile(
                      title: Text('Family ID: ${family['id']}'),
                      subtitle: Text(
                        'Distance: ${family['distance'].toStringAsFixed(2)} km\n'
                            'Total Calories: ${family['totalCalories']?.toStringAsFixed(2) ?? 'N/A'}\n'
                            'Needs: ${family['needs']}\n'
                            'Members: ${family['members']}\n'
                            'Coordinates: (${family['latitude']}, ${family['longitude']})',
                      ),
                      onTap: () async {
                        Navigator.of(context).pop(); // Close the dialog

                        // Fetch the members' additionalNeeds
                        final membersSnapshot = await FirebaseFirestore.instance.collection('families').doc(family['id']).collection('members').get();
                        List<String> additionalNeedsList = [];
                        for (var memberDoc in membersSnapshot.docs) {
                          final memberData = memberDoc.data();
                          final additionalNeeds = memberData['additionalNeeds'] as String? ?? 'N/A';
                          additionalNeedsList.add(additionalNeeds);
                        }
                        final additionalNeedsString = additionalNeedsList.join(', ');

                        if (mounted) {
                          if (_predictedCalories < family['totalCalories']) {
                            // Case 1: Update totalCalories in Firestore without changing allocation status
                            await FirebaseFirestore.instance.collection('families').doc(family['id']).update({
                              'totalCalories': (family['totalCalories'] - _predictedCalories).toString(),
                            });
                            setState(() {
                              _output = "Assigned to family ${family['id']}. Updated total calories in database.\n"
                                  "Coordinates: (${family['latitude']}, ${family['longitude']})\n"
                                  "Members' Additional Needs: $additionalNeedsString";
                            });
                          } else {
                            // Case 2: Update allocation status and other details
                            await FirebaseFirestore.instance.collection('families').doc(family['id']).update({
                              'assigned': 'yes',
                            });
                            setState(() {
                              _output = "Assigned to family ${family['id']}. Distance: ${family['distance'].toStringAsFixed(2)} km.\n"
                                  "Coordinates: (${family['latitude']}, ${family['longitude']})\n"
                                  "Members' Additional Needs: $additionalNeedsString";
                            });
                          }
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
      }
    } else {
      if (mounted) {
        setState(() {
          _output = "No suitable family found";
        });
      }
    }
  }


  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295;
    const c = Math.cos;
    final a = 0.5 - c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * Math.asin(Math.sqrt(a));
  }

  void addFoodItemInput() {
    setState(() {
      foodItems.add({
        'foodItem': TextEditingController(),
        'weight': TextEditingController(),
      });
    });
  }

  void removeFoodItemInput(int index) {
    setState(() {
      foodItems[index]['foodItem']?.dispose();
      foodItems[index]['weight']?.dispose();
      foodItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Calorie Predictor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ...foodItems.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, TextEditingController> item = entry.value;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: item['foodItem'],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Food Item',
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: item['weight'],
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Weight (grams)',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.remove, color: Colors.red),
                      onPressed: () {
                        removeFoodItemInput(index);
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
            ElevatedButton(
              onPressed: () {
                addFoodItemInput();
              },
              child: Text('+ Add More Food Item'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: predictCalories,
              child: Text('Predict Calories'),
            ),
            ElevatedButton(
              onPressed: allocateResources,
              child: Text('Allocate'),
            ),
            SizedBox(height: 20),
            Text(
              _output,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _interpreter.close();
    for (var item in foodItems) {
      item['foodItem']?.dispose();
      item['weight']?.dispose();
    }
    super.dispose();
  }
}
