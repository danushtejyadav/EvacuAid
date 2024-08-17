class MemberModel {
  String name;
  String age;
  String weight;
  String height;
  String gender;
  String activityLevel;
  double caloriesRequired;
  String additionalNeeds;

  MemberModel({
    this.name = '',
    this.age = '',
    this.weight = '',
    this.height = '',
    this.gender = 'Male',
    this.activityLevel = 'Sedentary',
    this.caloriesRequired = 0,
    this.additionalNeeds = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'weight': weight,
      'height': height,
      'gender': gender,
      'activityLevel': activityLevel,
      'caloriesRequired': caloriesRequired,
      'additionalNeeds': additionalNeeds,
    };
  }

  static MemberModel fromMap(Map<String, dynamic> map) {
    return MemberModel(
      name: map['name'],
      age: map['age'],
      weight: map['weight'],
      height: map['height'],
      gender: map['gender'],
      activityLevel: map['activityLevel'],
      caloriesRequired: map['caloriesRequired'] ?? 0,
      additionalNeeds: map['additionalNeeds'],
    );
  }

}