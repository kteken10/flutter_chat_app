import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/theme.dart';

class MediaSelectionModal extends StatelessWidget {
  final Function() onPickImage;
  final Function() onPickVideo;
  final Function() onPickFile;

  const MediaSelectionModal({
    super.key,
    required this.onPickImage,
    required this.onPickVideo,
    required this.onPickFile,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Effet de flou
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundColor.withOpacity(0.9), // Fond noir semi-transparent
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Titre de la modal
            Text(
              "Choisir un média",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Texte en blanc pour contraster avec le fond noir
              ),
            ),
            const SizedBox(height: 20),
            // Options de sélection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Option pour sélectionner une image
                _buildMediaOption(
                  icon: Icons.image,
                  label: "Image",
                  color: Colors.blue,
                  onTap: () {
                    Navigator.pop(context); // Fermer la modal
                    onPickImage(); // Sélectionner une image
                  },
                ),
                // Option pour sélectionner une vidéo
                _buildMediaOption(
                  icon: Icons.video_library,
                  label: "Vidéo",
                  color: Colors.red,
                  onTap: () {
                    Navigator.pop(context); // Fermer la modal
                    onPickVideo(); // Sélectionner une vidéo
                  },
                ),
                // Option pour sélectionner un fichier
                _buildMediaOption(
                  icon: Icons.insert_drive_file,
                  label: "Fichier",
                  color: Colors.green,
                  onTap: () {
                    Navigator.pop(context); // Fermer la modal
                    onPickFile(); // Sélectionner un fichier
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Méthode pour construire une option de média
  Widget _buildMediaOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Conteneur pour l'icône avec un effet de profondeur
          Container(
            padding: const EdgeInsets.all(16), // Padding réduit
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: color,
              size: 30, // Taille réduite pour les icônes
            ),
          ),
          const SizedBox(height: 10),
          // Texte descriptif
          Text(
            label,
            style: TextStyle(
              color: Colors.white, // Texte en blanc pour contraster avec le fond noir
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}