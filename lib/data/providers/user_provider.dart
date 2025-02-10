// lib/data/providers/user_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/firebase/user_service.dart';


class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();

  Stream<QuerySnapshot> getUsersStream() {
    return _userService.getUsersStream();
  }
}