//member_form.dart
import 'package:evacuaid/src/features/authentication/models/member_model.dart';
import 'package:flutter/material.dart';

class MemberForm extends StatelessWidget {
  final MemberModel member;
  final String label;
  final VoidCallback onRemove;

  MemberForm({
    required this.member,
    required this.label,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.remove, color: Colors.red),
              onPressed: onRemove,
            ),
          ],
        ),
        SizedBox(height: 8),
        TextFormField(
          initialValue: member.name,
          decoration: InputDecoration(labelText: 'Name'),
          onChanged: (value) => member.name = value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
        ),
        TextFormField(
          initialValue: member.age,
          decoration: InputDecoration(labelText: 'Age (years)'),
          keyboardType: TextInputType.number,
          onChanged: (value) => member.age = value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your age';
            }
            return null;
          },
        ),
        TextFormField(
          initialValue: member.weight,
          decoration: InputDecoration(labelText: 'Weight (kg)'),
          keyboardType: TextInputType.number,
          onChanged: (value) => member.weight = value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your weight';
            }
            return null;
          },
        ),
        TextFormField(
          initialValue: member.height,
          decoration: InputDecoration(labelText: 'Height (cm)'),
          keyboardType: TextInputType.number,
          onChanged: (value) => member.height = value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your height';
            }
            return null;
          },
        ),
        DropdownButtonFormField<String>(
          value: member.gender,
          decoration: InputDecoration(labelText: 'Gender'),
          items: ['Male', 'Female']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) => member.gender = value ?? 'Male',
        ),
        DropdownButtonFormField<String>(
          value: member.activityLevel,
          decoration: InputDecoration(labelText: 'Activity Level'),
          items: ['Sedentary', 'Low active', 'Active', 'Very active']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) => member.activityLevel = value ?? 'Sedentary',
        ),
        TextFormField(
          initialValue: member.additionalNeeds,
          decoration: InputDecoration(labelText: 'Additional Needs'),
          onChanged: (value) => member.additionalNeeds = value,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
