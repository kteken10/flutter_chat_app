import 'package:flutter/material.dart';
import '../../core/theme.dart';
import 'input.dart';  

class SearchInput extends StatelessWidget {
  final TextEditingController controller;

  const SearchInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,  // Garder les éléments à gauche
      children: [
        Expanded(
          child: SizedBox(
            child: InputField(
              height: 30,
              backgroundColor: AppColors.inputBackground,  // Couleur de fond personnalisée
              controller: controller,
              label: '',  // Le champ de recherche n'a pas de label
              keyboardType: TextInputType.text,
              obscureText: false,
            ),
          ),
        ),
        const SizedBox(width: 16),  // Ajouter un espace de 10px entre le champ et l'icône
        InkWell(
          onTap: () {
            // Action pour l'icône '+'
            // Vous pouvez définir l'action ici
          },
          borderRadius: BorderRadius.circular(30), // S'assurer que l'effet reste circulaire
          splashColor: const Color.fromARGB(255, 202, 207, 217),  // Couleur de l'effet de clic
          highlightColor: Colors.blue.withOpacity(0.7),  // Couleur de survol
          child: Container(
            width: 25,  // Largeur du cercle ajustée pour mieux contenir l'icône
            height: 25, // Hauteur du cercle (cercle parfait)
            decoration: const BoxDecoration(
              color: Colors.blue,  // Fond bleu
              shape: BoxShape.circle,  // Forme circulaire
            ),
            child: const Center(  // Centrer l'icône à l'intérieur du cercle
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,  // Taille ajustée de l'icône
              ),
            ),
          ),
        ),
      ],
    );
  }
}
