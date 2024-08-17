class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;

  const UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  toJson(){
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}