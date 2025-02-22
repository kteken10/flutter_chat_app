import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import '../../../core/theme.dart';

class MessageBubble extends StatefulWidget {
  final String text;
  final bool isMe;
  final String time;
  
  final Function() onCopy;
  final Function() onPin;
  final Function() onForward;
  final Function() onDelete;
  

  const MessageBubble({
    super.key,
    required this.text,
    required this.isMe,
    required this.time,
   
    required this.onCopy,
    required this.onPin,
    required this.onForward,
    required this.onDelete,
    
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  double _opacity = 0.0; // Initial opacity
  final ScrollController _scrollController = ScrollController(); // Contrôleur de défilement

  @override
  void initState() {
    super.initState();
    // Déclencher l'animation après un court délai
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0; // Faire apparaître la bulle
        });
      }
    });
  }

  // Méthode pour afficher le menu contextuel
  void _showContextMenu(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final double screenHeight = MediaQuery.of(context).size.height;

    // Calculer si le menu doit s'afficher en dessous ou au-dessus du message
    final bool showBelow = offset.dy + renderBox.size.height + 160 < screenHeight;

    // Faire défiler automatiquement jusqu'à la fin du message
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent, // Défiler jusqu'à la fin
      duration: const Duration(milliseconds: 300), // Durée du défilement
      curve: Curves.easeInOut, // Courbe d'animation
    ).then((_) {
      // Afficher le menu contextuel après le défilement
      showDialog(
        context: context,
        barrierColor: Colors.transparent, // Fond transparent pour le flou
        barrierDismissible: true, // Permettre la fermeture en cliquant en dehors
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              // Fermer le menu contextuel lorsque l'utilisateur clique en dehors
              Navigator.pop(context);
            },
            child: Stack(
              children: [
                // Effet de flou sur l'arrière-plan
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                // Positionnement du MessageBubble au-dessus du flou
                Positioned(
                  top: offset.dy,
                  left: widget.isMe ? null : offset.dx, // Ajuster la position horizontale
                  right: widget.isMe ? offset.dx : null,
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment:
                          widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        // Bulle de message
                        BubbleSpecialThree(
                          text: widget.text,
                          isSender: widget.isMe,
                          color: widget.isMe ? AppColors.primaryColor : Colors.grey[800]!,
                          tail: true,
                          textStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          sent: true,
                          seen: true,
                        ),
                        // Horodatage
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            widget.time,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Positionnement du menu contextuel
                Positioned(
                  top: showBelow ? offset.dy + renderBox.size.height : offset.dy - 160, // Ajuster la position verticale
                  right: widget.isMe ? offset.dx : null, // Ajuster la position horizontale
                  left: widget.isMe ? null : offset.dx,
                  child: GestureDetector(
                    onTap: () {
                      // Empêcher la fermeture du menu lorsque l'utilisateur clique sur le menu
                    },
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 160, // Largeur fixe pour le menu
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildMenuOption(
                              icon: Icons.copy,
                              label: "Copier",
                              onTap: () {
                                Navigator.pop(context); // Fermer le menu
                                widget.onCopy(); // Appeler la fonction de copie
                              },
                            ),
                            // Option pour épingler
                            _buildMenuOption(
                              icon: Icons.push_pin,
                              label: "Épingler",
                              onTap: () {
                                Navigator.pop(context); // Fermer le menu
                                widget.onPin(); // Appeler la fonction d'épinglage
                              },
                            ),
                            // Option pour transférer
                            _buildMenuOption(
                              icon: Icons.forward,
                              label: "Transférer",
                              onTap: () {
                                Navigator.pop(context); // Fermer le menu
                                widget.onForward(); // Appeler la fonction de transfert
                              },
                            ),
                            // Option pour supprimer
                            _buildMenuOption(
                              icon: Icons.delete,
                              label: "Supprimer",
                              onTap: () {
                                Navigator.pop(context); // Fermer le menu
                                widget.onDelete(); // Appeler la fonction de suppression
                              },
                            ),
                            // Option pour sélectionner
                         
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  // Méthode pour construire une option du menu
  Widget _buildMenuOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      trailing: Icon(icon, color: Colors.white, size: 20), // Icône à droite
      title: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 14), // Texte plus petit
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      child: Align(
        alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: GestureDetector(
          onLongPress: () => _showContextMenu(context), // Détecter un appui long
          child: SingleChildScrollView(
            controller: _scrollController, // Utiliser le contrôleur de défilement
            child: Column(
              crossAxisAlignment:
                  widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Bulle de message
                BubbleSpecialThree(
                  text: widget.text,
                  isSender: widget.isMe,
                  color: widget.isMe ? AppColors.primaryColor : Colors.grey[800]!,
                  tail: true,
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  sent: true,
                  seen: true,
                ),
                // Horodatage
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.time,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}