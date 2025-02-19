import 'package:flutter/material.dart';

// Enum pour représenter les différents statuts du message
enum MessageStatus {
  sent, // Message envoyé mais non livré
  delivered, // Message livré mais non lu
  read, // Message lu
}

class ChatItem extends StatelessWidget {
  final String userName;
  final String lastMessage;
  final String userProfilePicture;
  final String messageTime; // Heure du dernier message
  final int unreadCount; // Nombre de messages non lus
  final MessageStatus messageStatus; // Statut du message

  const ChatItem({
    super.key,
    required this.userName,
    required this.lastMessage,
    required this.userProfilePicture,
    required this.messageTime,
    this.unreadCount = 0, // Par défaut, aucun message non lu
    required this.messageStatus, // Statut du message
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 26, // Rayon de 26 pour un diamètre de 52 pixels
            backgroundImage: NetworkImage(userProfilePicture),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userName,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                    color: Colors.grey,
                  ),
                ),
              ),
              // Afficher l'icône de statut du message
              _buildMessageStatusIcon(messageStatus),
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
        const Divider(
          height: 1,
          color: Colors.grey, // Couleur du trait de séparation
          thickness: 0.5, // Épaisseur du trait de séparation
          indent: 84, // Ajuster le décalage pour correspondre à la nouvelle taille de l'avatar
        ),
      ],
    );
  }

  // Méthode pour afficher l'icône de statut du message
  Widget _buildMessageStatusIcon(MessageStatus status) {
    switch (status) {
      case MessageStatus.sent:
        return const Icon(Icons.check, size: 16, color: Colors.grey);
      case MessageStatus.delivered:
        return const Icon(Icons.done_all, size: 16, color: Colors.grey);
      case MessageStatus.read:
        return const Icon(Icons.done_all, size: 16, color: Colors.blue);
      default:
        return const SizedBox.shrink(); // Aucune icône par défaut
    }
  }
}