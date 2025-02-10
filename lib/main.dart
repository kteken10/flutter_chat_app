import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'presentation/navigation/root.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    
    print('Error initializing Firebase: $e');

  }
  runApp(const Root());
}
