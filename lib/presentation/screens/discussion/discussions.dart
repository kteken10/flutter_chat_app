import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/theme.dart';
import '../../ui/chat_items.dart';
import '../../ui/modal_options.dart';
import '../../ui/search_input.dart';
import '../../widget/section_tab.dart';
import 'chat.dart';

class DiscussionsScreen extends StatefulWidget {
  const DiscussionsScreen({super.key});

  @override
  State<DiscussionsScreen> createState() => _DiscussionsScreenState();
}

class _DiscussionsScreenState extends State<DiscussionsScreen> {
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

  // Méthode pour afficher la modale
  void _showModalOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: AppColors.bottomBackColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: ModalOptions(
              onOptionSelected: (option) {
                print('Option sélectionnée : $option');
              },
              onUserSelected: (userName, userProfilePicture) {
                // Ferme la modale
                Navigator.pop(context);

                // Ajoute une nouvelle conversation
                _addNewConversation(userName, userProfilePicture);

                // Redirige vers l'écran de chat
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      userName: userName,
                      userProfilePicture: userProfilePicture,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  // Méthode pour ajouter une nouvelle conversation
  void _addNewConversation(String userName, String userProfilePicture) {
    setState(() {
      conversations.insert(0, {
        'userName': userName,
        'lastMessage': 'Nouvelle conversation',
        'userProfilePicture': userProfilePicture,
        'messageTime': 'Maintenant',
        'unreadCount': 1,
        'messageStatus': MessageStatus.sent,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        actions: [
          IconButton(
            icon: Container(
              width: 25,
              height: 25,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.adb,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            splashColor: const Color.fromARGB(255, 202, 207, 217),
            highlightColor: AppColors.primaryColor,
            onPressed: () {
              // Action pour l'autre bouton
            },
          ),
          IconButton(
            onPressed: () {
              _showModalOptions(context); // Ouvre la modale
            },
            iconSize: 25,
            padding: EdgeInsets.zero,
            icon: Container(
              width: 25,
              height: 25,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            splashColor: const Color.fromARGB(255, 202, 207, 217),
            highlightColor: AppColors.primaryColor,
          ),
          const SizedBox(width: 16),
        ],
        backgroundColor: AppColors.bottomBackColor,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'WeeChax',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SearchInput(controller: searchController),
          ),
          SectionTab(
            tabs: const ["Toutes", "Non lues", "Favoris", "Groupes"],
            onTabSelected: (index) {
              print("Onglet sélectionné : $index");
            },
          ),
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
                  onTap: () {
                    // Naviguer vers l'écran de chat
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          userName: conversation['userName']!,
                          userProfilePicture: conversation['userProfilePicture']!,
                        ),
                      ),
                    );
                  },
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