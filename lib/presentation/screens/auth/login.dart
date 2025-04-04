import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:iconsax/iconsax.dart'; 
import '../../../core/theme.dart';
import '../../../core/utils.dart';
import '../../../data/providers/auth_provider.dart';
import '../../ui/button.dart';
import '../../widget/bottom_nav.dart';
import '../../ui/input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
      backgroundColor: AppColors.bottomBackColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
      SizedBox(height: (MediaQuery.of(context).size.height * 0.2)-64),
                 Image.asset(
      'assets/chatlogo.png',
      height: 180, 
      width: 180,
      ),
    const SizedBox(height: 16.0), 
                const Text(
                  "Connexion",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                InputField(
                  controller: _emailController,
                  height: 70,
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  icon: const Icon(Iconsax.sms, color: Colors.white,size: 18),
                ),
                const SizedBox(height: 16),
                InputField(
                  controller: _passwordController,
                  height: 70,
                  label: "Mot de passe",
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  icon: const Icon(Iconsax.lock, color: Colors.white,size: 18), 
                ),
                const SizedBox(height: 16),
                Bouton(
                  text: "Se connecter", 
                  onPressed: _login,
                  isLoading: _isLoading,
                  color: AppColors.primaryColor,
                ),
                 const SizedBox(height: 16),
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