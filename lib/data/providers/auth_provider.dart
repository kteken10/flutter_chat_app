import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  UserModel? _user;

  UserModel? get user => _user;

  AuthProvider() {
    _authRepository.getCurrentUser().then((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<String> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    String result = await _authRepository.signUpUser(
      email: email,
      password: password,
      name: name,
    );
    if (result == "success") {
      _user = await _authRepository.getCurrentUser();
      notifyListeners();
    }
    return result;
  }

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    UserModel? user = await _authRepository.loginUser(
      email: email,
      password: password,
    );
    if (user != null) {
      _user = user;
      notifyListeners();
    }
    return user;
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _user = null;
    notifyListeners();
  }
}