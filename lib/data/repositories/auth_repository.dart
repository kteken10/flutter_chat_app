import 'package:firebase_auth/firebase_auth.dart';
import '../../services/firebase/auth_service.dart';
import '../models/user_model.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<String> signUpUser({
    required String email,
    required String password,
    required String? name,
  }) async {
    return await _authService.signUpUser(
      email: email,
      password: password,
      name: name!,
    );
  }

  Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      String result = await _authService.loginUser(email: email, password: password);
      if (result != "success") {
        throw Exception(result);
      }

      User? user = await _authService.getCurrentUser();
      if (user != null) {
        return UserModel(
          uid: user.uid,
          email: user.email!,
        );
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
  }

  Future<UserModel?> getCurrentUser() async {
    User? user = await _authService.getCurrentUser();
    if (user != null) {
      return UserModel(
        uid: user.uid,
        email: user.email!,
      );
    } else {
      return null;
    }
  }
}