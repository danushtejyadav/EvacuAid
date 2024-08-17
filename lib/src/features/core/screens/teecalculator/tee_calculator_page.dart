import "package:cloud_firestore/cloud_firestore.dart";
import "package:evacuaid/src/common_widgets/loading/loading_page.dart";
import "package:evacuaid/src/features/authentication/models/member_model.dart";
import "package:evacuaid/src/features/core/screens/dashboard/dashboard.dart";
import "package:evacuaid/src/features/core/screens/teecalculator/tee_member_form_widget.dart";
import "package:evacuaid/src/repository/firebase_repository/firestore_service/firestore_service.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class TeeCalculatorPage extends StatefulWidget {
  final String familyId;
  final bool editMode;

  TeeCalculatorPage({required this.familyId, required this.editMode});

  @override
  _TeeCalculatorPageState createState() => _TeeCalculatorPageState();
}

class _TeeCalculatorPageState extends State<TeeCalculatorPage>{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService firestoreService = FirestoreService();
  final _formKey = GlobalKey<FormState>();
  List<MemberModel> _members = [];
  bool _isLoading = true;

  @override
  void initState(){
    super.initState();
    if(widget.editMode){
      _loadFamilyData();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadFamilyData() async {
    try {
      DocumentSnapshot familyDoc = await firestoreService.getFamilyDocument(
          widget.familyId);
      if (familyDoc.exists) {
        List<dynamic> membersData = familyDoc['members'];
        _members =
            membersData.map((data) => MemberModel.fromMap(data)).toList();
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading family data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addMember() {
    setState(() {
      _members.add(MemberModel());
    });
  }

  Future<void> _calculateAndSave() async {
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();

      double totalCalories = 0;
      for(var member in _members){
        member.caloriesRequired = _calculateTEE(member);
        totalCalories += member.caloriesRequired;
      }

      if (widget.editMode){
        await _updateFamilyDocument(totalCalories);
      } else {
        await _createFamilyDocument(totalCalories);
      }

      List<String> additionalNeeds = await firestoreService.getFamilyAdditionalNeeds(widget.familyId);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Additional Needs'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: additionalNeeds.isNotEmpty
                    ? additionalNeeds.map((need) => Text('- $need')).toList()
                    : [Text('No additional needs specified')],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Family data saved successfully"),
                    ));
                    Get.to(() => LoadingPage());
                  },
                  child: Text('Close'),
                )
              ],
            );
          }
      );
    }
  }

  double _calculateTEE(MemberModel member){
    int age = int.parse(member.age);
    double weight = double.parse(member.weight);
    double height = double.parse(member.height);

    double heightm = height / 100;

    double pa = getPAValue(member.activityLevel,member.gender);

    if (member.gender == 'Male') {
      return 864 - 9.72 * age + pa * (14.2 * weight + 503 * heightm);
    } else {
      return 387 - 7.31 * age + pa * (10.9 * weight + 660.7 * heightm);
    }
  }

  double getPAValue(String activityLevel, String gender) {
    if (gender == 'Male') {
      switch (activityLevel) {
        case 'Sedentary':
          return 1.0;
        case 'Low active':
          return 1.12;
        case 'Active':
          return 1.27;
        case 'Very active':
          return 1.54;
        default:
          return 1.0;
      }
    } else {
      switch (activityLevel) {
        case 'Sedentary':
          return 1.0;
        case 'Low active':
          return 1.14;
        case 'Active':
          return 1.27;
        case 'Very active':
          return 1.45;
        default:
          return 1.0;
      }
    }
  }

  Future<void> _createFamilyDocument(double totalCalories) async {
    await firestoreService.createFamilyDocument(widget.familyId, _members, totalCalories);
  }

  Future<void> _updateFamilyDocument(double totalCalories) async {
    await firestoreService.updateFamilyDocument(widget.familyId, _members, totalCalories);
  }

  void _removeMember(MemberModel member) {
    setState(() {
      _members.remove(member);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Family Details'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ..._members.map((member) {
                return MemberForm(
                  member: member,
                  label: 'Member ${_members.indexOf(member) + 1}',
                  onRemove: () => _removeMember(member),
                );
              }).toList(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addMember,
                child: Text('Add Member'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateAndSave,
                child: Text('Calculate and Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}