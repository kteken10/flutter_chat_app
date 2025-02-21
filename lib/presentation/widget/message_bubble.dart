import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import '../../../core/theme.dart';

class MessageBubble extends StatefulWidget {
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
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  double _opacity = 0.0; // Initial opacity

  @override
  void initState() {
    super.initState();
    // Déclencher l'animation après un court délai
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0; // Faire apparaître la bulle
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 300), // Durée de l'animation
      curve: Curves.easeIn, // Courbe d'animation
      child: Align(
        alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Bulle de message
            BubbleNormal(
              text: widget.text,
              isSender: widget.isMe, // Détermine si le message est envoyé par l'utilisateur
              color: widget.isMe ? AppColors.primaryColor : Colors.grey[800]!, // Couleur de la bulle
              tail: true, // Ajoute une queue à la bulle pour un look plus réaliste
              textStyle: const TextStyle(
                fontSize: 14,
                color: Colors.white, // Couleur du texte
              ),
              sent: true, // Indique que le message a été envoyé
              seen: true, // Indique que le message a été vu
            ),
            // Horodatage
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                widget.time,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}