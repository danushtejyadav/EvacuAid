import "package:cloud_firestore/cloud_firestore.dart";
import "package:evacuaid/src/features/authentication/models/member_model.dart";
import "package:flutter/material.dart";

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getFamilyDocument(String familyId) async {
    return await _db.collection('families').doc(familyId).get();
  }

  Future<void> createFamilyDocument(String familyId, List<MemberModel> members, double totalCalories) async {
    await _db.collection('families').doc(familyId).set({
      'members': members.map((m) => m.toMap()).toList(),
      'totalCalories': totalCalories,
      'needHelp': 'no', // Default value
      'assigned': 'no', // Default value
    });
  }
  Future<List<String>> getFamilyAdditionalNeeds(String familyId) async {
    try {
      DocumentSnapshot familyDoc = await getFamilyDocument(familyId);
      if (familyDoc.exists) {
        List<dynamic> membersData = familyDoc['members'];
        List<String> additionalNeeds = membersData
            .map((data) => MemberModel.fromMap(data).additionalNeeds)
            .toList();
        return additionalNeeds;
      }
      return [];
    } catch (e) {
      print('Error fetching additional needs: $e');
      return [];
    }
  }
  Future<void> updateFamilyDocument(String familyId, List<MemberModel> members, double totalCalories) async {
    await _db.collection('families').doc(familyId).update({
      'members': members.map((m) => m.toMap()).toList(),
      'totalCalories': totalCalories,
    });
  }
}
