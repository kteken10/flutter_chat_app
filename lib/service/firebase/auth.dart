import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 

  bool _validatePassword(String password) {
    return password.length >= 6;
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      if (!validateEmail(email)) {
        return "Veuillez entrer un email valide.";
      }
      if (!_validatePassword(password)) {
        return "Le mot de passe doit contenir au moins 6 caractères.";
      }
      if (name.isEmpty) {
        return "Veuillez entrer un nom.";
      }

      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(credential.user!.uid).set({
        'uid': credential.user!.uid,
        'name': name,
        'email': email,
        'profilePicture': '',
        'createdAt': Timestamp.now(),
      });

      return "success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return "Cet email est déjà utilisé.";
        case 'weak-password':
          return "Le mot de passe est trop faible.";
        default:
          return e.message ?? "Erreur inconnue lors de l'inscription.";
      }
    } catch (e) {
      return "Une erreur s'est produite. Veuillez réessayer.";
    }
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      if (!validateEmail(email)) {
        return "Veuillez entrer un email valide.";
      }
      if (!_validatePassword(password)) {
        return "Le mot de passe doit contenir au moins 6 caractères.";
      }

      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return "Aucun utilisateur trouvé avec cet email.";
        case 'wrong-password':
          return "Mot de passe incorrect.";
        default:
          return e.message ?? "Erreur inconnue lors de la connexion.";
      }
    } catch (e) {
      return "Une erreur s'est produite. Veuillez réessayer.";
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}