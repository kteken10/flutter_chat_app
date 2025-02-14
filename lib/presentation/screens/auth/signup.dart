import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:iconsax/iconsax.dart'; // Importation de IconSax
import '../../../core/theme.dart';
import '../../../core/utils.dart';
import '../../../data/providers/auth_provider.dart';
import '../../ui/button.dart';
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
      backgroundColor: AppColors.bottomBackColor,
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
                  icon: const Icon(Iconsax.user, color: Colors.white,size:18), // Icône IconSax pour le nom
                ),
                const SizedBox(height: 32.0),
                InputField(
                  controller: _emailController,
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  icon: const Icon(Iconsax.sms, color: Colors.white,size:18), // Icône IconSax pour l'email
                ),
                const SizedBox(height: 32.0),
                InputField(
                  controller: _passwordController,
                  label: "Mot de passe",
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  icon: const Icon(Iconsax.lock, color: Colors.white,size:18), // Icône IconSax pour le mot de passe
                ),
                const SizedBox(height: 32.0),
                // Remplacer l'ElevatedButton par le composant Bouton
                Bouton(
                  text: "S'inscrire",
                  onPressed: _isLoading ? null : _signUp,
                  isLoading: _isLoading,
                  color: AppColors.primaryColor,
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