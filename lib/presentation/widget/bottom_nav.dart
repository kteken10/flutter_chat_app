import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart'; // Importez Provider
import '../../core/theme.dart';
import '../../data/providers/bottom_nav_provider.dart';
import '../screens/call/calls_screen.dart';
import '../screens/discussion/discussions.dart';
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
    const SettingsScreen(),
  ];

  final List<PersistentBottomNavBarItem> _navBarItems = [
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.message1, size: 22),
      title: "Discussions",
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.story, size: 22),
      title: "Stories",
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.call, size: 22),
      title: "Appels",
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.setting1, size: 22),
      title: "Paramètres",
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Barre de navigation
          if (bottomNavProvider.isVisible)
            PersistentTabView(
              context,
              controller: _controller,
              screens: _screens,
              items: _navBarItems,
              navBarStyle: NavBarStyle.style6,
              backgroundColor: AppColors.bottomBackColor,
              padding: const EdgeInsets.only(bottom: 8, top: 8),
            ),

          // Bordure supérieure avec marge
          if (bottomNavProvider.isVisible)
            Positioned(
              bottom: 78,
              left: 0,
              right: 0,
              child: Container(
                height: 1,
                color: AppColors.inputBackground,
              ),
            ),
        ],
      ),
    );
  }
}