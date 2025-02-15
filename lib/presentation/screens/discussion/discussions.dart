import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/theme.dart';
import '../../ui/chat_items.dart'; // Assurez-vous que le chemin est correct
import '../../ui/search_input.dart';

class DiscussionsScreen extends StatelessWidget {
  const DiscussionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    // Données aléatoires pour les conversations
    final List<Map<String, dynamic>> conversations = [
      {
        'userName': 'Alice',
        'lastMessage': 'Salut, comment ça va ?',
        'userProfilePicture': 'https://via.placeholder.com/150',
        'messageTime': '10:30', // Heure du message
        'unreadCount': 3, // Nombre de messages non lus
      },
      {
        'userName': 'Bob',
        'lastMessage': 'Tu as vu le dernier film ?',
        'userProfilePicture': 'https://via.placeholder.com/150',
        'messageTime': '11:15', // Heure du message
        'unreadCount': 0, // Aucun message non lu
      },
      {
        'userName': 'Charlie',
        'lastMessage': 'On se voit demain ?',
        'userProfilePicture': 'https://via.placeholder.com/150',
        'messageTime': '12:45', // Heure du message
        'unreadCount': 1, // Nombre de messages non lus
      },
      {
        'userName': 'Diana',
        'lastMessage': 'Je t\'envoie le document ce soir.',
        'userProfilePicture': 'https://via.placeholder.com/150',
        'messageTime': '14:00', // Heure du message
        'unreadCount': 5, // Nombre de messages non lus
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: SearchInput(controller: searchController),
        backgroundColor: AppColors.bottomBackColor,
      ),
      body: Column(
        children: [
          const SizedBox(height: 4),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            height: 1, // Épaisseur de la bordure
            color: AppColors.inputBackground, // Couleur de la bordure
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return ChatItem(
                  userName: conversation['userName']!,
                  lastMessage: conversation['lastMessage']!,
                  userProfilePicture: conversation['userProfilePicture']!,
                  messageTime: conversation['messageTime']!,
                  unreadCount: conversation['unreadCount'], // Nombre de messages non lus
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.bottomBackColor,
    );
  }
}