import 'package:flutter/material.dart';

import '../../core/theme.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final double? height;

  const InputField({
    super.key,
    required this.controller,
    required this.label,
    required this.keyboardType,
    required this.obscureText,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.black),
        textAlignVertical: TextAlignVertical.center,  // Ceci aligne verticalement le texte au centre
        decoration: InputDecoration(
          fillColor: AppColors.inputBackground,
          hoverColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),  // Ajustez cette valeur pour centrer le curseur
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.secondaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.grayFineColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusColor: Colors.white,
        ),
      ),
    );
  }
}