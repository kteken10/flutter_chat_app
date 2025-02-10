// models/user_model.dart
class UserModel {
  final String uid;
  final String email;

  UserModel({required this.uid, required this.email});

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'],
    );
  }
}
