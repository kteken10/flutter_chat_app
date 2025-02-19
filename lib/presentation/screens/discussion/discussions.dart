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
        title: SearchInput(controller: searchController),
        backgroundColor: AppColors.bottomBackColor,
      ),
      body: Column(
        children: [
          const SizedBox(height: 4),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            height: 1, 
            color: AppColors.inputBackground, 
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