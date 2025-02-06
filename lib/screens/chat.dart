import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'message.dart';

class ChatScreen extends StatefulWidget {
  final String email;
  const ChatScreen({super.key, required this.email});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseFirestore fs = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  /// Vérifie si l'utilisateur est bien connecté
  void _checkUser() async {
    User? user = _auth.currentUser;
    if (user == null) {
      Navigator.pushReplacementNamed(context, '/login'); 
    }
  }

  /// Envoie un message à Firestore
  Future<void> _sendMessage() async {
    String trimmedMessage = messageController.text.trim();
    if (trimmedMessage.isEmpty) return;

    setState(() {
      _isSending = true;
    });

    await fs.collection('Messages').add({
      'message': trimmedMessage,
      'time': Timestamp.fromDate(DateTime.now()), 
      'email': widget.email,
    });

    messageController.clear();

    setState(() {
      _isSending = false;
    });

    /// Défilement automatique vers le dernier message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          /// Liste des messages
          Expanded(
            child: MessageScreen(email: widget.email),
          ),

          /// Zone d'envoi du message
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
                
                /// Bouton d'envoi
                _isSending
                    ? const CircularProgressIndicator() // ✅ Indicateur de chargement
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
