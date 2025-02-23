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
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  int? _editingMessageIndex; // Index du message en cours de modification

  // Méthode pour formater l'heure
  String _formatTime(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  // Méthode pour envoyer un message média
  void _sendMedia(String mediaPath) {
    // Implémentez la logique pour envoyer un message média
    print('Envoyer un message média');
  }

  // Méthode pour envoyer un message texte
  void _sendMessage() {
    final String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        if (_editingMessageIndex != null) {
          // Modifier le message existant
          _messages[_editingMessageIndex!] = {
            'text': messageText,
            'sender': 'me',
            'time': _formatTime(DateTime.now()),
          };
          _editingMessageIndex = null; // Réinitialiser l'index de modification
        } else {
          // Ajouter un nouveau message
          _messages.add({
            'text': messageText,
            'sender': 'me',
            'time': _formatTime(DateTime.now()),
          });
        }
      });
      _messageController.clear();
    }
  }

  // Méthode pour envoyer un message vocal
  void _sendVoice() {
    // Implémentez la logique pour envoyer un message vocal
    print('Envoyer un message vocal');
  }

  // Méthode pour modifier un message
  void _editMessage(int index) {
    setState(() {
      _editingMessageIndex = index;
      _messageController.text = _messages[index]['text']!;
    });
  }

  // Méthode pour supprimer un message
  void _deleteMessage(int index) {
    setState(() {
      _messages.removeAt(index);
    });
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
                  time: message['time']!,
                  onCopy: () => _copyMessage(index),
                  onPin: () => _pinMessage(index),
                  onForward: () => _forwardMessage(index),
                  onDelete: () => _deleteMessage(index),
                  onEdit: () => _editMessage(index), // Ajouter la fonction de modification
                );
              },
            ),
          ),
          // Zone de saisie et d'envoi de message
          SendZone(
            messageController: _messageController,
            onSendMessage: _sendMessage,
            onSendMedia: (mediaPath) => _sendMedia(mediaPath),
            onSendVoice: () => _sendVoice(),
          ),
        ],
      ),
      backgroundColor: AppColors.bottomBackColor,
    );
  }
}