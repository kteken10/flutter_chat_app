import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class SendZone extends StatefulWidget {
  final TextEditingController messageController;
  final VoidCallback onSendMessage;
  final VoidCallback onSendMedia; // Pour sélectionner un média ou un fichier
  final VoidCallback onSendVoice;

  const SendZone({
    super.key,
    required this.messageController,
    required this.onSendMessage,
    required this.onSendMedia,
    required this.onSendVoice,
  });

  @override
  State<SendZone> createState() => _SendZoneState();
}

class _SendZoneState extends State<SendZone> {
  bool _isTyping = false; // Pour suivre si l'utilisateur est en train de taper

  @override
  void initState() {
    super.initState();
    // Écouter les changements dans le champ de saisie
    widget.messageController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    // Nettoyer le listener
    widget.messageController.removeListener(_onTextChanged);
    super.dispose();
  }

  // Méthode appelée lorsque le texte change
  void _onTextChanged() {
    setState(() {
      _isTyping = widget.messageController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: AppColors.bottomBackColor,
      child: Row(
        children: [
          // Bouton pour sélectionner un média ou un fichier
          IconButton(
            onPressed: widget.onSendMedia,
            icon: const Icon(Icons.attach_file, color: Colors.white),
          ),
          // Champ de saisie de texte
          Expanded(
            child: Container(
              height: 40, // Hauteur réduite du champ de saisie
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.inputBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: widget.messageController,
                decoration: const InputDecoration(
                  hintText: 'Écrire un message...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none, // Pas de bordure
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                ),
                style: const TextStyle(color: Colors.white),
                maxLines: 1, // Une seule ligne
              ),
            ),
          ),
          // Bouton pour enregistrer un message vocal ou envoyer un message texte
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200), // Durée de l'animation
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: _isTyping
                ? IconButton(
                    key: const ValueKey('send'),
                    onPressed: widget.onSendMessage,
                    icon: const Icon(Icons.send, color: Colors.white),
                  )
                : IconButton(
                    key: const ValueKey('mic'),
                    onPressed: widget.onSendVoice,
                    icon: const Icon(Icons.mic, color: Colors.white),
                  ),
          ),
        ],
      ),
    );
  }
}