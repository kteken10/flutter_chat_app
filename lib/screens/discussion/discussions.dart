import 'package:flutter/material.dart';

class DiscussionsScreen extends StatelessWidget {
  const DiscussionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discussions')),
      body: const Center(child: Text('Liste des conversations')),
    );
  }
}
