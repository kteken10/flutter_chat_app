import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import '../../../core/theme.dart';

class MessageBubble extends StatefulWidget {
  final String text;
  final bool isMe;
  final String time;
  final Function() onCopy;
  final Function() onPin;
  final Function() onForward;
  final Function() onDelete;
  final Function() onEdit;
  final Function() onLongPress; // Ajouter le callback onLongPress
  @override
  // ignore: overridden_fields
  final GlobalKey key; // Ajouter un GlobalKey

  const MessageBubble({
    required this.text,
    required this.isMe,
    required this.time,
    required this.onCopy,
    required this.onPin,
    required this.onForward,
    required this.onDelete,
    required this.onEdit,
    required this.onLongPress,
    required this.key, // Ajouter un GlobalKey
  }) : super(key: key);

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  double _opacity = 0.0; // Initial opacity
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Trigger the animation after a short delay
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0; // Make the bubble appear
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      child: Align(
        alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: GestureDetector(
          onLongPress: widget.onLongPress, // Utiliser le callback onLongPress
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment:
                  widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Message bubble
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
                // Timestamp
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
        ),
      ),
    );
  }
}