// lib/screens/peoples/people_screen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/providers/user_provider.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Utilisateurs')),
      body: StreamBuilder<QuerySnapshot>(
        stream: userProvider.getUsersStream(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Aucun utilisateur trouvé.'));
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index].data() as Map<String, dynamic>;
              final username = user['name'] ?? 'Inconnu';
              final email = user['email'] ?? '';

              return ListTile(
                leading: CircleAvatar(
                  child: Text(username[0]), // Première lettre du nom
                ),
                title: Text(username),
                subtitle: Text(email),
                onTap: () {
                  // Action sur clic utilisateur
                },
              );
            },
          );
        },
      ),
    );
  }
}