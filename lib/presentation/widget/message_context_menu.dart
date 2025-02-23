import 'dart:ui';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class MessageContextMenu extends StatelessWidget {
  final Function() onCopy;
  final Function() onPin;
  final Function() onForward;
  final Function() onDelete;
  final bool isMe;
  final Offset offset;
  final double messageHeight;

  const MessageContextMenu({
    super.key,
    required this.onCopy,
    required this.onPin,
    required this.onForward,
    required this.onDelete,
    required this.isMe,
    required this.offset,
    required this.messageHeight,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool showBelow = offset.dy + messageHeight + 160 < screenHeight;

    return Stack(
      children: [
        // Effet de flou sur l'arrière-plan
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.transparent,
          ),
        ),
        // Positionnement du MessageBubble au-dessus du flou
        Positioned(
          top: offset.dy,
          left: isMe ? null : offset.dx, // Ajuster la position horizontale
          right: isMe ? offset.dx : null,
          child: Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // Bulle de message
                BubbleSpecialThree(
                  text: "", // Le texte est géré dans MessageBubble
                  isSender: isMe,
                  color: isMe ? AppColors.primaryColor : Colors.grey[800]!,
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
                    "", // L'horodatage est géré dans MessageBubble
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
        // Positionnement du menu contextuel
        Positioned(
          top: showBelow ? offset.dy + messageHeight : offset.dy - 160, // Ajuster la position verticale
          right: isMe ? offset.dx : null, // Ajuster la position horizontale
          left: isMe ? null : offset.dx,
          child: GestureDetector(
            onTap: () {
              // Empêcher la fermeture du menu lorsque l'utilisateur clique sur le menu
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 160, // Largeur fixe pour le menu
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
                    // Option pour copier
                    _buildMenuOption(
                      icon: Icons.copy,
                      label: "Copier",
                      onTap: () {
                        Navigator.pop(context); // Fermer le menu
                        onCopy(); // Appeler la fonction de copie
                      },
                    ),
                    // Option pour épingler
                    _buildMenuOption(
                      icon: Icons.push_pin,
                      label: "Épingler",
                      onTap: () {
                        Navigator.pop(context); // Fermer le menu
                        onPin(); // Appeler la fonction d'épinglage
                      },
                    ),
                    // Option pour transférer
                    _buildMenuOption(
                      icon: Icons.forward,
                      label: "Transférer",
                      onTap: () {
                        Navigator.pop(context); // Fermer le menu
                        onForward(); // Appeler la fonction de transfert
                      },
                    ),
                    // Option pour supprimer
                    _buildMenuOption(
                      icon: Icons.delete,
                      label: "Supprimer",
                      onTap: () {
                        Navigator.pop(context); // Fermer le menu
                        onDelete(); // Appeler la fonction de suppression
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Méthode pour construire une option du menu
  Widget _buildMenuOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      trailing: Icon(icon, color: Colors.white, size: 20), // Icône à droite
      title: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 14), // Texte plus petit
      ),
      onTap: onTap,
    );
  }
}