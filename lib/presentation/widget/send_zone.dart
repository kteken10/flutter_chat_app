import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../../../core/theme.dart';
import '../ui/input.dart';
import 'media_selection_modal.dart';

class SendZone extends StatefulWidget {
  final TextEditingController messageController;
  final VoidCallback onSendMessage;
  final Function(String) onSendMedia;
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
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // Appeler la callback avec le chemin de l'image
        widget.onSendMedia(image.path);
      }
    } catch (e) {
      print("Erreur lors de la sélection de l'image : $e");
    }
  }

  // Méthode pour sélectionner une vidéo depuis la galerie
  Future<void> _pickVideo() async {
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        // Appeler la callback avec le chemin de la vidéo
        widget.onSendMedia(video.path);
      }
    } catch (e) {
      print("Erreur lors de la sélection de la vidéo : $e");
    }
  }

  // Méthode pour sélectionner un fichier (document, image, vidéo, etc.)
  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        if (file.path != null) {
          // Appeler la callback avec le chemin du fichier
          widget.onSendMedia(file.path!);
        } else {
          print("Le fichier sélectionné n'a pas de chemin valide.");
        }
      } else {
        print("Aucun fichier sélectionné.");
      }
    } catch (e) {
      print("Erreur lors de la sélection du fichier : $e");
    }
  }

  // Méthode pour afficher le ModalBottomSheet moderne
  void _showMediaSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Fond transparent pour le style moderne
      builder: (BuildContext context) {
        return MediaSelectionModal(
          onPickImage: _pickImage,
          onPickVideo: _pickVideo,
          onPickFile: _pickFile,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: AppColors.bottomBackColor,
      child: Row(
        children: [
          // Bouton pour ouvrir la modal de sélection de médias
          IconButton(
            icon: const Icon(Icons.attach_file, color: Colors.white),
            onPressed: () => _showMediaSelectionModal(context),
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