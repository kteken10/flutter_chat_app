import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _email; // Stocke l'email de l'utilisateur

  // Getter pour accéder à l'email
  String? get email => _email;

  // Méthode pour mettre à jour l'email
  void setEmail(String email) {
    _email = email;
    notifyListeners(); // Notifie les écrans qui écoutent ce Provider
  }

  // Méthode pour déconnecter l'utilisateur (optionnel)
  void clearEmail() {
    _email = null;
    notifyListeners();
  }
}