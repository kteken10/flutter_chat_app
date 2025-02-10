import 'package:flutter/material.dart';

import '../../core/theme.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;

  const InputField({
    super.key,
    required this.controller,
    required this.label,
    required this.keyboardType,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0), 
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              fillColor: Colors.white,
              hoverColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 1),  // Bordure personnalisée
                borderRadius: BorderRadius.circular(12.0),  // Coins arrondis
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondaryColor.withOpacity(0.5), width: 1),  // Bordure quand le champ est focus
                borderRadius: BorderRadius.circular(12.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.grayFineColor, width: 1),  // Bordure quand le champ est non focus
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusColor: Colors.white
            ),
          ),
        ],
      ),
    );
  }
}
