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
      duration: const Duration(milliseconds: 300), 
      curve: Curves.easeIn,
      child: Align(
        alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Bulle de message
            BubbleSpecialThree(
              text: widget.text,
              isSender: widget.isMe, 
              color: widget.isMe ? AppColors.primaryColor : Colors.grey[800]!, 
              tail: true, 
              textStyle: const TextStyle(
                fontSize: 14,
                color: Colors.white, 
              ),
              sent: true, 
              seen: true, 
            ),
            // Horodatage
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                widget.time,
                style: TextStyle(
                  // ignore: deprecated_member_use
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