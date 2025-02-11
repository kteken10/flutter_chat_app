import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firebase/auth_service.dart';
import '../models/user_model.dart';

class AuthRepository {
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Inscription via Firebase Auth
      final result = await _authService.signUpUser(
        email: email,
        password: password,
        name: name,
      );

      // Vérifier si l'inscription a réussi
      if (result == "success") {
        // Récupérer l'utilisateur actuel
        final user = await _authService.getCurrentUser();
        if (user != null) {
          // Ajouter les informations de l'utilisateur dans Firestore
          await _firestore.collection('users').doc(user.uid).set({
            'email': email,
            'name': name,
          });

          // Retourner un modèle d'utilisateur (UserModel)
          return UserModel(
            uid: user.uid,   // Remplacer 'id' par 'uid'
            name: name,
            email: email,
          );
        }
      }
      return null; // Retourner null si quelque chose échoue
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authService.loginUser(
        email: email,
        password: password,
      );

      if (result != "success") {
        throw Exception(result);
      }

      final user = await _authService.getCurrentUser();
      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          return UserModel.fromMap(doc.data()!, user.uid);
        }
      }
      throw Exception("User not found");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
  }

  Future<UserModel?> getCurrentUser() async {
    final user = await _authService.getCurrentUser();
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data()!, user.uid);
      }
    }
    return null;
  }
}
