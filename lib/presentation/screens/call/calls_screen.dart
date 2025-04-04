import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appels'),  backgroundColor: AppColors.bottomBackColor,),
      body: const Center(child: Text('Historique des appels')),
      backgroundColor: AppColors.bottomBackColor,
    );
  }
}
