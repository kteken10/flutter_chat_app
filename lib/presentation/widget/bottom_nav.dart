import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme.dart';
import '../screens/call/calls_screen.dart';
import '../screens/discussion/discussions.dart';
import '../screens/peoples/people_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/stories/stories_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  final List<Widget> _screens = [
    const DiscussionsScreen(),
    const StoriesScreen(),
    const CallsScreen(),
    const PeopleScreen(),
    const SettingsScreen(),
  ];

  final List<PersistentBottomNavBarItem> _navBarItems = [
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.message2, size: 22), // Réduction de la taille de l'icône
      title: "Discussions",
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.story, size: 22), // Réduction de la taille de l'icône
      title: "Stories",
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.call, size: 22), // Réduction de la taille de l'icône
      title: "Appels",
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.people, size: 22), // Réduction de la taille de l'icône
      title: "People",
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.setting1, size: 22), // Réduction de la taille de l'icône
      title: "Paramètres",
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens,
      items: _navBarItems,
      navBarStyle: NavBarStyle.style6,
      backgroundColor: AppColors.bottomBackColor,
      padding: const EdgeInsets.only(bottom: 8, top: 8),
    );
  }
}
