import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/providers/auth_provider.dart';
import '../auth/login.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Paramètres")),
      body: Column(
        children: [
          const ListTile(title: Text("Modifier le profil"), leading: Icon(Icons.person)),
          const ListTile(title: Text("Changer le mot de passe"), leading: Icon(Icons.lock)),
          ListTile(
            title: const Text("Déconnexion"),
            leading: const Icon(Icons.logout),
            onTap: () async {
              await authProvider.logout();
              Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}