import 'package:flutter/material.dart';

import '../../core/theme.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final double? height;
  final Widget? icon; // Nouvelle propriété pour l'icône
  final Color? backgroundColor; // Nouvelle propriété pour la couleur de fond

  const InputField({
    super.key,
    required this.controller,
    required this.label,
    required this.keyboardType,
    required this.obscureText,
    this.height,
    this.icon, // Initialisation de la nouvelle propriété
    this.backgroundColor, // Initialisation de la nouvelle propriété
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          labelText: label, // Ajout du label ici
          labelStyle: const TextStyle(color: Colors.white, fontSize: 11), // Style du label
          fillColor: backgroundColor ?? AppColors.backgroundColor, // Utilisation de la couleur de fond personnalisée ou de la couleur par défaut
          hoverColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.backgroundColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusColor: Colors.white,
          suffixIcon: icon, // Ajout de l'icône à l'extrémité droite du champ de saisie
        ),
      ),
    );
  }
}