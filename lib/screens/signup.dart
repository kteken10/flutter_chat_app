import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../ui/input.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signUp() {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    // Ajouter la logique d'inscription ici
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Inscription",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 32.0),
            InputField(
              controller: _nameController,
              label: "Nom",
              keyboardType: TextInputType.text,
              obscureText: false,
            ),
            InputField(
              controller: _emailController,
              label: "Email",
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
            ),
            InputField(
              controller: _passwordController,
              label: "Mot de passe",
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                ),
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Text(
                "Déjà un compte ? Connectez-vous",
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
