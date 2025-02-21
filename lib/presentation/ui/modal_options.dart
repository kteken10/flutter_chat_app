import 'package:flutter/material.dart';
import '../screens/discussion/chat.dart';
import 'search_input.dart'; // Importez le composant de recherche

class ModalOptions extends StatefulWidget {
  final Function(String) onOptionSelected;
  final Function(String, String) onUserSelected; // Ajout de la photo de profil

  const ModalOptions({
    super.key,
    required this.onOptionSelected,
    required this.onUserSelected,
  });

  @override
  State<ModalOptions> createState() => _ModalOptionsState();
}

class _ModalOptionsState extends State<ModalOptions> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ValueNotifier<String> currentLetterNotifier = ValueNotifier<String>('A');

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_updateCurrentLetter);
  }

  @override
  void dispose() {
    scrollController.removeListener(_updateCurrentLetter);
    scrollController.dispose();
    currentLetterNotifier.dispose();
    super.dispose();
  }

  // Méthode pour mettre à jour la lettre actuelle
  void _updateCurrentLetter() {
    final double scrollPosition = scrollController.offset;
    final Map<String, double> letterPositions = {};

    // Calculer les positions des lettres
    double offset = 0;
    for (final entry in groupedUsers.entries) {
      letterPositions[entry.key] = offset;
      offset += (entry.value.length * 60); // Hauteur estimée par utilisateur
    }

    // Trouver la lettre actuellement visible
    String currentLetter = 'A';
    for (final entry in letterPositions.entries) {
      if (scrollPosition >= entry.value) {
        currentLetter = entry.key;
      } else {
        break;
      }
    }

    // Mettre à jour la lettre actuelle
    if (currentLetterNotifier.value != currentLetter) {
      currentLetterNotifier.value = currentLetter;
    }
  }

  // Liste des utilisateurs (groupés par lettre pour le défilement)
  final Map<String, List<Map<String, String>>> groupedUsers = {
    'A': [
      {'name': 'Alice', 'profilePicture': 'https://via.placeholder.com/150'},
    ],
    'B': [
      {'name': 'Bob', 'profilePicture': 'https://via.placeholder.com/150'},
    ],
    'C': [
      {'name': 'Charlie', 'profilePicture': 'https://via.placeholder.com/150'},
    ],
    'D': [
      {'name': 'Diana', 'profilePicture': 'https://via.placeholder.com/150'},
    ],
    'E': [
      {'name': 'Eve', 'profilePicture': 'https://via.placeholder.com/150'},
    ],
    'F': [
      {'name': 'Frank', 'profilePicture': 'https://via.placeholder.com/150'},
    ],
    'G': [
      {'name': 'Grace', 'profilePicture': 'https://via.placeholder.com/150'},
    ],
    'H': [
      {'name': 'Hank', 'profilePicture': 'https://via.placeholder.com/150'},
    ],
  };

  // Liste plate de tous les utilisateurs (pour l'affichage)
  List<Map<String, String>> get allUsers {
    return groupedUsers.values.expand((users) => users).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header de la modale
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40), // Pour centrer le texte "Nouveau Message"
              const Text(
                'Nouveau Message',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Ferme la modale
                },
                child: const Text(
                  'Annulé',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Champ de recherche
          SearchInput(controller: searchController),
          const SizedBox(height: 16),

          // Options
          _buildOptionButton(context, 'Nouveau groupe', Icons.group),
          _buildOptionButton(context, 'Nouveau contact', Icons.person_add),
          _buildOptionButton(context, 'Nouveau canal', Icons.people),
          const SizedBox(height: 16),
          const Divider(color: Colors.white54),

          // Indicateur de lettre actuelle
          ValueListenableBuilder<String>(
            valueListenable: currentLetterNotifier,
            builder: (context, currentLetter, child) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  currentLetter,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),

          // Liste des utilisateurs (sans lettres de séparation)
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: allUsers.length,
              itemBuilder: (context, index) {
                final user = allUsers[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user['profilePicture']!),
                  ),
                  title: Text(
                    user['name']!,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                 Navigator.pop(context); // Ferme la modale
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          userName: user['name']!,
                          userProfilePicture: user['profilePicture']!,
                        ),
                      ),
                    );
                  
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour construire un bouton d'option
  Widget _buildOptionButton(BuildContext context, String label, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () {
        widget.onOptionSelected(label); // Appel de la callback
        Navigator.pop(context); // Ferme la modale
      },
    );
  }
}