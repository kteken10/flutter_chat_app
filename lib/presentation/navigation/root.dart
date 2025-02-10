import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/providers/user_provider.dart';

import '../screens/auth/login.dart';
import '../screens/auth/signup.dart';
import '../widget/bottom_nav.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ChatApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/bottomNav': (context) => const BottomNav(),
        },
      ),
    );
  }
}
