import 'package:flutter/material.dart';

class PeopleScreen extends StatelessWidget {
  final List<String> users = [
    'Alice',
    'Bob',
    'Charlie',
    'David',
    'Emma',
    'Frank'
  ];

  PeopleScreen({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Utilisateurs')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(users[index][0]), // Première lettre du nom
            ),
            title: Text(users[index]),
            subtitle: const Text('En ligne'),
            onTap: () {
              // Action sur clic utilisateur
            },
          );
        },
      ),
    );
  }
}
