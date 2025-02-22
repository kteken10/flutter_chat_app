import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; 
import '../../../core/theme.dart';
import '../ui/input.dart';


class SendZone extends StatefulWidget {
  final TextEditingController messageController;
  final VoidCallback onSendMessage;
  final Function(String) onSendMedia; // Callback pour envoyer le chemin du média
  final VoidCallback onSendVoice;

  const SendZone({
    super.key,
    required this.messageController,
    required this.onSendMessage,
    required this.onSendMedia,
    required this.onSendVoice,
  });

  @override
  State<SendZone> createState() => _SendZoneState();
}

class _SendZoneState extends State<SendZone> {
  bool _isTyping = false; // Pour suivre si l'utilisateur est en train de taper
  final ImagePicker _picker = ImagePicker(); // Instance de ImagePicker

  @override
  void initState() {
    super.initState();
    // Écouter les changements dans le champ de saisie
    widget.messageController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    // Nettoyer le listener
    widget.messageController.removeListener(_onTextChanged);
    super.dispose();
  }

  // Méthode appelée lorsque le texte change
  void _onTextChanged() {
    setState(() {
      _isTyping = widget.messageController.text.isNotEmpty;
    });
  }

  // Méthode pour sélectionner une image depuis la galerie
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Appeler la callback avec le chemin de l'image
      widget.onSendMedia(image.path);
    }
  }

  // Méthode pour sélectionner une vidéo depuis la galerie
  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      // Appeler la callback avec le chemin de la vidéo
      widget.onSendMedia(video.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: AppColors.bottomBackColor,
      child: Row(
        children: [
          // Bouton pour sélectionner un média ou un fichier
          PopupMenuButton<String>(
            icon: const Icon(Icons.attach_file, color: Colors.white),
            onSelected: (value) {
              if (value == 'image') {
                _pickImage(); // Sélectionner une image
              } else if (value == 'video') {
                _pickVideo(); // Sélectionner une vidéo
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'image',
                child: Text('Sélectionner une image'),
              ),
              const PopupMenuItem(
                value: 'video',
                child: Text('Sélectionner une vidéo'),
              ),
            ],
          ),
          // Utilisation du composant InputField
          Expanded(
            child: InputField(
              controller: widget.messageController,
              label: '', // Vous pouvez laisser le label vide ou mettre un placeholder
              keyboardType: TextInputType.text,
              obscureText: false,
              height: 30, // Hauteur réduite du champ de saisie
              backgroundColor: AppColors.inputBackground,
              borderRadius: 20, 
              applyFocusEffect: false, 
            ),
          ),
          // Bouton pour enregistrer un message vocal ou envoyer un message texte
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200), // Durée de l'animation
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: _isTyping
                ? IconButton(
                    key: const ValueKey('send'),
                    onPressed: widget.onSendMessage,
                    icon: const Icon(Icons.send, color: Colors.white),
                  )
                : IconButton(
                    key: const ValueKey('mic'),
                    onPressed: widget.onSendVoice,
                    icon: const Icon(Icons.mic, color: Colors.white),
                  ),
          ),
        ],
      ),
    );
  }
}