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

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Appeler signUpUser et récupérer directement le UserModel
      final user = await _authRepository.signUpUser(
        email: email,
        password: password,
        name: name,
      );
      _user = user; // Mettre à jour l'utilisateur connecté
      notifyListeners(); // Notifier les écouteurs
    } catch (e) {
      rethrow; // Propager l'erreur pour l'afficher dans l'interface utilisateur
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      // Appeler loginUser et récupérer directement le UserModel
      final user = await _authRepository.loginUser(
        email: email,
        password: password,
      );

      if (user != null) {
        _user = user; // Mettre à jour l'utilisateur connecté
        notifyListeners(); // Notifier les écouteurs
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      rethrow; // Propager l'erreur pour l'afficher dans l'interface utilisateur
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _user = null; // Réinitialiser l'utilisateur connecté
    notifyListeners(); // Notifier les écouteurs
  }
}
