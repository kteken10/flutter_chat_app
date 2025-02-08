import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importez Provider
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/user_provider.dart';
import 'message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseFirestore fs = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  void _checkUser() async {
    User? user = _auth.currentUser;
    if (user == null) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> _sendMessage() async {
    String trimmedMessage = messageController.text.trim();
    if (trimmedMessage.isEmpty) return;

    setState(() {
      _isSending = true;
    });

    // Récupérez l'email depuis le UserProvider
    final email = Provider.of<UserProvider>(context, listen: false).email;

    await fs.collection('Messages').add({
      'message': trimmedMessage,
      'time': Timestamp.fromDate(DateTime.now()),
      'email': email, // Utilisez l'email récupéré
    });

    messageController.clear();

    setState(() {
      _isSending = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Récupérez l'email depuis le UserProvider
    final email = Provider.of<UserProvider>(context).email;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'), // Affichez l'email dans l'AppBar
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOut();
              Provider.of<UserProvider>(context, listen: false).clearEmail(); // Déconnexion
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.purple[100],
                hintText: 'Rechercher un message...',
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: MessageScreen(
              email: email!, 
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.purple[100],
                      hintText: 'Message',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _isSending
                    ? const CircularProgressIndicator()
                    : IconButton(
                        onPressed: _sendMessage,
                        icon: const Icon(Icons.send, color: Colors.purple),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}