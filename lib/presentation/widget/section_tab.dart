import 'package:flutter/material.dart';

class SectionTab extends StatefulWidget {
  final List<String> tabs;
  final Function(int) onTabSelected;

  const SectionTab({
    super.key,
    required this.tabs,
    required this.onTabSelected,
  });

  @override
  State<SectionTab> createState() => _SectionTabState();
}

class _SectionTabState extends State<SectionTab> {
  int _selectedIndex = 0; // Index de l'onglet sélectionné

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8), // Marge horizontale et verticale
      width: double.infinity, // Prendre toute la largeur disponible
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Défilement horizontal
        child: Row(
          children: widget.tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tabLabel = entry.value;
            final isSelected = index == _selectedIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index; // Mettre à jour l'index sélectionné
                });
                widget.onTabSelected(index); // Appeler la fonction de rappel
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),// Marge horizontale entre les onglets
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.grey[200], // Couleur de fond
                  borderRadius: BorderRadius.circular(20.0), // Bord arrondi
                ),
                child: Center(
                  child: Text(
                    tabLabel,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black, // Couleur du texte
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}