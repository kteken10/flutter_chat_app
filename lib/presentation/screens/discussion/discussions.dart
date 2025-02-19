import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/theme.dart';
import '../../ui/chat_items.dart';
import '../../ui/search_input.dart';

class DiscussionsScreen extends StatelessWidget {
  const DiscussionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    final List<Map<String, dynamic>> conversations = [
      {
        'userName': 'Alice',
        'lastMessage': 'Salut, comment ça va ?',
        'userProfilePicture': 'https://via.placeholder.com/150',
        'messageTime': '10:30',
        'unreadCount': 3,
        'messageStatus': MessageStatus.read,
      },
      {
        'userName': 'Bob',
        'lastMessage': 'Tu as vu le dernier film ?',
        'userProfilePicture': 'https://via.placeholder.com/150',
        'messageTime': '11:15',
        'unreadCount': 0,
        'messageStatus': MessageStatus.delivered,
      },
      {
        'userName': 'Charlie',
        'lastMessage': 'On se voit demain ?',
        'userProfilePicture': 'https://via.placeholder.com/150',
        'messageTime': '12:45',
        'unreadCount': 1,
        'messageStatus': MessageStatus.sent,
      },
      {
        'userName': 'Diana',
        'lastMessage': 'Je t\'envoie le document ce soir.',
        'userProfilePicture': 'https://via.placeholder.com/150',
        'messageTime': '14:00',
        'unreadCount': 5,
        'messageStatus': MessageStatus.read,
      },
    ];

    return Scaffold(
     appBar: AppBar(
 
  actions: [
    // Icône de l'intelligence artificielle
    IconButton(
      icon: Icon(Icons.adb, color: Colors.green), // Icône pour l'IA
      onPressed: () {
        // Action pour l'icône IA
      },
    ),
    // Icône "Plus" avec un fond bleu
    InkWell(
      onTap: () {
        // Action pour l'icône "+"
      },
      borderRadius: BorderRadius.circular(30),
      splashColor: const Color.fromARGB(255, 202, 207, 217),
      highlightColor: Colors.blue.withOpacity(0.7),
      child: Container(
        width: 25,
        height: 25,
        decoration: const BoxDecoration(
          color: Colors.blue, // Fond bleu
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.white, // Icône blanche
            size: 20,
          ),
        ),
      ),
    ),
    const SizedBox(width: 16), // Espacement entre les icônes et le bord droit
  ],
  backgroundColor: AppColors.bottomBackColor,
),
      body: Column(
        children: [
          // Deuxième ligne : Texte "WeeChax"
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'WeeChax',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
          ),
          // Troisième ligne : Champ de recherche
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SearchInput(controller: searchController),
          ),
          // Séparateur
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            height: 0.5,
            color: AppColors.inputBackground,
          ),
          // Liste des conversations
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
                  unreadCount: conversation['unreadCount'],
                  messageStatus: conversation['messageStatus'],
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