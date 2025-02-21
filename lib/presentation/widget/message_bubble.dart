import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import '../../../core/theme.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return BubbleNormal(
      text: text,
      isSender: isMe, // Détermine si le message est envoyé par l'utilisateur
      color: isMe ? AppColors.primaryColor : Colors.grey[800]!, // Couleur de la bulle
      tail: true, // Ajoute une queue à la bulle pour un look plus réaliste
      textStyle: const TextStyle(
        fontSize: 14,
        color: Colors.white, // Couleur du texte
      ),
      sent: true, // Indique que le message a été envoyé
      seen: true, // Indique que le message a été vu
    
      
    );
  }
}