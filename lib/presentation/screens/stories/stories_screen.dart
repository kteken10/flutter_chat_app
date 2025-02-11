import 'package:flutter/material.dart';

import '../../../core/theme.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stories'),
       backgroundColor: AppColors.backgroundColor,
      ),
      body: const Center(child: Text('Section des stories'))
      ,
       backgroundColor: AppColors.backgroundColor,
    );
  }
}
