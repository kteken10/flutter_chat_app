import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../widget/header_chat.dart';
import '../../widget/message_bubble.dart';
import '../../widget/send_zone.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String userProfilePicture;

  const ChatScreen({
    super.key,
    required this.userName,
    required this.userProfilePicture,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];

  // Méthode pour envoyer un message texte
  void _sendMessage() {
    final String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        _messages.add({
          'text': messageText,
          'sender': 'me', // 'me' pour l'utilisateur actuel
          'time': _formatTime(DateTime.now()), // Ajout de l'horodatage
        });
      });
      _messageController.clear();
    }
  }

  // Méthode pour envoyer un média (image ou vidéo)
  void _sendMedia(String mediaPath) {
    setState(() {
      _messages.add({
        'text': mediaPath,
        'sender': 'me', // 'me' pour l'utilisateur actuel
        'time': _formatTime(DateTime.now()), // Ajout de l'horodatage
        'type': mediaPath.endsWith('.mp4') ? 'video' : 'image', // Type de média
      });
    });
  }

  // Méthode pour enregistrer et envoyer un message vocal
  void _sendVoice() {
    // Implémentez la logique pour enregistrer et envoyer un message vocal
    print('Message vocal envoyé');
  }

  // Méthode pour formater l'heure
  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  // Méthode pour supprimer un message
  void _deleteMessage(int index) {
    setState(() {
      _messages.removeAt(index);
    });
  }

  // Méthode pour répondre à un message
  void _replyToMessage(int index) {
    // Implémentez la logique pour répondre à un message
    print('Répondre au message à l\'index $index');
  }

  // Méthode pour copier un message
  void _copyMessage(int index) {
    // Implémentez la logique pour copier un message
    print('Copier le message à l\'index $index');
  }

  // Méthode pour épingler un message
  void _pinMessage(int index) {
    // Implémentez la logique pour épingler un message
    print('Épingler le message à l\'index $index');
  }

  // Méthode pour transférer un message
  void _forwardMessage(int index) {
    // Implémentez la logique pour transférer un message
    print('Transférer le message à l\'index $index');
  }

  // Méthode pour sélectionner un message
  void _selectMessage(int index) {
    // Implémentez la logique pour sélectionner un message
    print('Sélectionner le message à l\'index $index');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderChat(
        userName: widget.userName,
        userProfilePicture: widget.userProfilePicture,
      ),
      body: Column(
        children: [
          // Liste des messages
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return MessageBubble(
                  text: message['text']!,
                  isMe: message['sender'] == 'me',
                  time: message['time']!, // Ajout de l'horodatage
                  onReply: () => _replyToMessage(index),
                  onCopy: () => _copyMessage(index),
                  onPin: () => _pinMessage(index),
                  onForward: () => _forwardMessage(index),
                  onDelete: () => _deleteMessage(index),
                  onSelect: () => _selectMessage(index),
                );
              },
            ),
          ),

          // Zone de saisie et d'envoi de message
          SendZone(
            messageController: _messageController,
            onSendMessage: _sendMessage,
            onSendMedia: _sendMedia,
            onSendVoice: _sendVoice,
          ),
        ],
      ),
      backgroundColor: AppColors.bottomBackColor,
    );
  }
}