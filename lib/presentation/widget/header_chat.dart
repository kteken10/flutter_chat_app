import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart'; // Importez les icônes modernes
import 'package:iconsax/iconsax.dart';
import '../../core/theme.dart';

class HeaderChat extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String userProfilePicture;

  const HeaderChat({
    super.key,
    required this.userName,
    required this.userProfilePicture,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(userProfilePicture),
          ),
          const SizedBox(width: 10),
          Text(
            userName,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
      backgroundColor: AppColors.bottomBackColor,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: const Icon(Iconsax.call, size: 22), // Icône pour l'appel vocal
          onPressed: () {
            // Action à effectuer lors de l'appel vocal
          },
        ),
        IconButton(
          icon: const Icon(Iconsax.video, size: 22), // Icône pour l'appel vidéo
          onPressed: () {
            // Action à effectuer lors de l'appel vidéo
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1), // Hauteur du délimiteur
        child: Container(
          color: AppColors.inputBackground, // Couleur du délimiteur
          height: 0.5, // Épaisseur du trait
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}