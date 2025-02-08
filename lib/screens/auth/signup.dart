import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../service/firebase/auth.dart';
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

    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showMessage("Veuillez remplir tous les champs !");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    String result = await AuthService().signUpUser(
      email: email,
      password: password,
      name: name,
    );

    setState(() {
      _isLoading = false;
    });

    if (result == "success") {
      _showMessage("Inscription réussie !");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNav()), 
      );
    } else {
      _showMessage(result);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
