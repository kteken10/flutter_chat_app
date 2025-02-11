import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../core/theme.dart';
import '../../../core/utils.dart';
import '../../../data/providers/auth_provider.dart';
import '../../ui/input.dart';
import '../../widget/bottom_nav.dart';

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
  bool _isLoading = false;

  void _signUp() async {
    setState(() {
      _isLoading = true;
    });

    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    // Validation des champs
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      showToast("Veuillez remplir tous les champs !");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (!validateEmail(email)) {
      showToast("Veuillez entrer un email valide.");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      // Appeler la méthode signUp de AuthProvider
      await Provider.of<AuthProvider>(context, listen: false).signUp(
        email: email,
        password: password,
        name: name,
      );

      // Afficher un message de succès
      showAwesomeDialog(context, "Inscription réussie !", DialogType.success);

      // Rediriger vers l'écran principal
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNav()),
      );
    } catch (e) {
      // Afficher l'erreur
      showAwesomeDialog(context, e.toString(), DialogType.error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
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
                    onPressed: _isLoading ? null : _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "S'inscrire",
                            style: TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    "Déjà un compte ? Connectez-vous",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}