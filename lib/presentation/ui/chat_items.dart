import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String userName;
  final String lastMessage;
  final String userProfilePicture;
  final String messageTime; // Heure du dernier message
  final int unreadCount; // Nombre de messages non lus

  const ChatItem({
    super.key,
    required this.userName,
    required this.lastMessage,
    required this.userProfilePicture,
    required this.messageTime,
    this.unreadCount = 0, // Par défaut, aucun message non lu
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8), // Marge en bas pour séparer les éléments
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(userProfilePicture),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligne les éléments à gauche et à droite
          children: [
            Text(
              userName,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Couleur du texte du nom d'utilisateur
            ),
            Text(
              messageTime,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ), // Heure du message à droite
          ],
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                lastMessage,
                style: const TextStyle(
                  color: Colors.grey, // Couleur du texte du dernier message
                ),
              ),
            ),
            if (unreadCount > 0) // Affiche le badge uniquement s'il y a des messages non lus
              Container(
                margin: const EdgeInsets.only(left: 4), // Espace entre le message et le badge
                padding: const EdgeInsets.all(4), // Rembourrage du badge
                decoration: BoxDecoration(
                  color: Colors.red, // Couleur du badge
                  borderRadius: BorderRadius.circular(30), // Bord arrondi
                ),
                child: Text(
                  unreadCount.toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white, // Couleur du texte
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        onTap: () {
          // Naviguer vers l'écran de chat
        },
      ),
    );
  }
}