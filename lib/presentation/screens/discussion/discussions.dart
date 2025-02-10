import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DiscussionsScreen extends StatelessWidget {
  const DiscussionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('Discussions')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('conversations')
            .where('participants', arrayContains: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Aucune conversation trouvée.'));
          }

          final conversations = snapshot.data!.docs;

          return ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final conversation = conversations[index];
              final participants = conversation['participants'] as List<dynamic>;
              final otherUserId = participants.firstWhere((id) => id != userId);

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('users').doc(otherUserId).get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const ListTile(title: Text('Chargement...'));
                  }

                  if (userSnapshot.hasError || !userSnapshot.hasData) {
                    return const ListTile(title: Text('Utilisateur inconnu'));
                  }

                  final user = userSnapshot.data!;
                  final userName = user['name'];
                  final userProfilePicture = user['profilePicture'];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(userProfilePicture),
                    ),
                    title: Text(userName),
                    subtitle: const Text('Dernier message...'), // À remplacer par le dernier message
                    onTap: () {
                      // Naviguer vers l'écran de chat
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}