import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
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
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

 
  final List<Widget> _screens = [
    const DiscussionsScreen(),
    const StoriesScreen(),
    const CallsScreen(),
     PeopleScreen(), 
  SettingsScreen(), 
  ];

 
  final List<PersistentBottomNavBarItem> _navBarItems = [
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.message),
      title: "Discussions",
      activeColorPrimary: Colors.purple,
      inactiveColorPrimary: Colors.black54,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.story),
      title: "Stories",
      activeColorPrimary: Colors.purple,
      inactiveColorPrimary: Colors.black54,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.call),
      title: "Appels",
      activeColorPrimary: Colors.purple,
      inactiveColorPrimary: Colors.black54,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.people),
      title: "People",
      activeColorPrimary: Colors.purple,
      inactiveColorPrimary: Colors.black54,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.setting),
      title: "Paramètres",
      activeColorPrimary: Colors.purple,
      inactiveColorPrimary: Colors.black54,
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
      backgroundColor: Colors.white, 
      padding: const EdgeInsets.only( bottom: 8,top: 8),


       
    //  padding: const EdgeInsets.symmetric(vertical: 20),
    //  margin:const EdgeInsets.symmetric(vertical: 16)
     
    );
  }
}