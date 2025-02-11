import 'package:firebase_auth/firebase_auth.dart';



class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        // Mettre à jour les informations de l'utilisateur
        await result.user!.updateDisplayName(name);
      }

      return "success";
    } catch (e) {
      rethrow;
    }
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user == null) {
        throw Exception("Authentication failed");
      }

      return "success";
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
