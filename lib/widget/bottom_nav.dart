import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:iconsax/iconsax.dart';
import '../screens/call/calls_screen.dart';
import '../screens/discussion/discussions.dart';
import '../screens/peoples/people_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/stories/stories_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DiscussionsScreen(),
    const StoriesScreen(),
    const CallsScreen(),
    PeopleScreen(),      // Écran des utilisateurs (People)
    const SettingsScreen(), // Écran des paramètres
  ];

  final List<IconData> bottomNavIcons = [
    Iconsax.message,  // Discussions
    Iconsax.story,    // Stories
    Iconsax.call,     // Appels
    Iconsax.setting,  // Paramètres (dernier élément)
  ];

  final List<String> bottomNavTitles = [
    "Discussions",
    "Stories",
    "Appels",
    "Paramètres",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      
      // Floating Action Button (People au centre)
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          setState(() {
            _selectedIndex = 3; // Afficher l'écran des utilisateurs
          });
        },
        child: const Icon(Iconsax.people, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom Navigation Bar
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: bottomNavIcons.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? Colors.purple : Colors.black54;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(bottomNavIcons[index], size: 24, color: color),
              const SizedBox(height: 4), // Espacement
              Text(
                bottomNavTitles[index],
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          );
        },
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.center, // FAB (People) au centre
        notchSmoothness: NotchSmoothness.softEdge,
        backgroundColor: Colors.white,
        leftCornerRadius: 20,
        rightCornerRadius: 20,
        elevation: 10,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Navigation normale via la barre
          });
        },
      ),
    );
  }
}
