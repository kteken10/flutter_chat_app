import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/providers/auth_provider.dart';


class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Paramètres")),
      body: Column(
        children: [
          ListTile(title: Text("Modifier le profil"), leading: Icon(Icons.person)),
          ListTile(title: Text("Changer le mot de passe"), leading: Icon(Icons.lock)),
          // ListTile(
          //   title: Text("Déconnexion"),
          //   leading: Icon(Icons.logout),
          //   onTap: () => authProvider.signOut(),
          // ),
        ],
      ),
    );
  }
}
