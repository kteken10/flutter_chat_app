import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../core/theme.dart';
import '../../../core/utils.dart';
import '../../../data/providers/auth_provider.dart';
import '../../widget/bottom_nav.dart';
import '../../ui/input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    // Validation des champs
    if (email.isEmpty || password.isEmpty) {
      showToast("Veuillez remplir tous les champs !");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      // Appeler la méthode login de AuthProvider
      await Provider.of<AuthProvider>(context, listen: false).login(
        email: email,
        password: password,
      );

      // Afficher un message de succès
      showAwesomeDialog(context, "Connexion réussie !", DialogType.success);

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
      backgroundColor: AppColors.backgroundColor,
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
                  "Connexion",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 32.0),
                InputField(
                  controller: _emailController,
                  height: 70,
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                ),
                 const SizedBox(height: 24.0),
                InputField(
                  controller: _passwordController,
                   height: 70,
                  label: "Mot de passe",
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
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
                            "Se connecter",
                            style: TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text(
                    "Pas encore de compte ? Inscrivez-vous",
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
