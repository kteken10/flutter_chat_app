import 'dart:ui';

import 'package:chat_bubbles/chat_bubbles.dart';
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
  final ScrollController _scrollController = ScrollController(); // Ajouter un ScrollController
  int? _editingMessageIndex; // Index du message en cours de modification

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // Vous pouvez ajouter une logique ici si nécessaire
  }

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
      _scrollToBottom(); // Faire défiler vers le bas après l'ajout d'un nouveau message
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

  // Méthode pour faire défiler vers le bas
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Méthode pour afficher le menu contextuel
  void _showContextMenu(BuildContext context, GlobalKey key, int index) {
    _scrollToBottom();
    final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Positioned(
                top: offset.dy,
                left: _messages[index]['sender'] == 'me' ? null : offset.dx,
                right: _messages[index]['sender'] == 'me' ? offset.dx : null,
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: _messages[index]['sender'] == 'me'
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      BubbleSpecialThree(
                        text: _messages[index]['text']!,
                        isSender: _messages[index]['sender'] == 'me',
                        color: _messages[index]['sender'] == 'me'
                            ? AppColors.primaryColor
                            : Colors.grey[800]!,
                        tail: true,
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        sent: true,
                        seen: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          _messages[index]['time']!,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: offset.dy + renderBox.size.height,
                right: _messages[index]['sender'] == 'me' ? offset.dx : null,
                left: _messages[index]['sender'] == 'me' ? null : offset.dx,
                child: GestureDetector(
                  onTap: () {},
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildMenuOption(
                            icon: Icons.copy,
                            label: "Copier",
                            onTap: () {
                              Navigator.pop(context);
                              _copyMessage(index);
                            },
                          ),
                          _buildMenuOption(
                            icon: Icons.push_pin,
                            label: "Épingler",
                            onTap: () {
                              Navigator.pop(context);
                              _pinMessage(index);
                            },
                          ),
                          _buildMenuOption(
                            icon: Icons.forward,
                            label: "Transférer",
                            onTap: () {
                              Navigator.pop(context);
                              _forwardMessage(index);
                            },
                          ),
                          _buildMenuOption(
                            icon: Icons.delete,
                            label: "Supprimer",
                            onTap: () {
                              Navigator.pop(context);
                              _deleteMessage(index);
                            },
                          ),
                          _buildMenuOption(
                            icon: Icons.edit,
                            label: "Modifier",
                            onTap: () {
                              Navigator.pop(context);
                              _editMessage(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      trailing: Icon(icon, color: Colors.white, size: 20),
      title: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      onTap: onTap,
    );
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
              controller: _scrollController, // Associer le ScrollController
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final GlobalKey key = GlobalKey();
                return MessageBubble(
                  key: key, // Passer le GlobalKey
                  text: message['text']!,
                  isMe: message['sender'] == 'me',
                  time: message['time']!,
                  onCopy: () => _copyMessage(index),
                  onPin: () => _pinMessage(index),
                  onForward: () => _forwardMessage(index),
                  onDelete: () => _deleteMessage(index),
                  onEdit: () => _editMessage(index), // Ajouter la fonction de modification
                  onLongPress: () => _showContextMenu(context, key, index), // Ajouter la fonction de menu contextuel
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