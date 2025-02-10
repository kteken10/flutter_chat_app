import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _uid; // ID de l'utilisateur
  String? _email; // Email de l'utilisateur
  String? _name; // Nom de l'utilisateur
  String? _profilePicture; // URL de la photo de profil
  bool _isLoggedIn = false; // État de connexion

  // Getters pour accéder aux informations de l'utilisateur
  String? get uid => _uid;
  String? get email => _email;
  String? get name => _name;
  String? get profilePicture => _profilePicture;
  bool get isLoggedIn => _isLoggedIn;

  // Méthode pour mettre à jour toutes les informations de l'utilisateur
  void setUser({
    required String uid,
    required String email,
    required String name,
    String? profilePicture,
  }) {
    _uid = uid;
    _email = email;
    _name = name;
    _profilePicture = profilePicture;
    _isLoggedIn = true; // L'utilisateur est connecté
    notifyListeners(); // Notifie les écrans qui écoutent ce Provider
  }

  // Méthode pour mettre à jour uniquement l'email (optionnel)
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  // Méthode pour mettre à jour la photo de profil (optionnel)
  void setProfilePicture(String profilePicture) {
    _profilePicture = profilePicture;
    notifyListeners();
  }

  // Méthode pour déconnecter l'utilisateur
  void logout() {
    _uid = null;
    _email = null;
    _name = null;
    _profilePicture = null;
    _isLoggedIn = false; // L'utilisateur est déconnecté
    notifyListeners();
  }

  // Méthode pour vérifier si l'utilisateur est connecté
  bool isUserLoggedIn() {
    return _isLoggedIn;
  }
}