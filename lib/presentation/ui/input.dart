import 'package:flutter/material.dart';
import '../../core/theme.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final double? height;
  final Widget? icon;
  final Widget? prefixIcon;
  final Color? backgroundColor;

  const InputField({
    super.key,
    required this.controller,
    required this.label,
    required this.keyboardType,
    required this.obscureText,
    this.height,
    this.icon,
    this.prefixIcon,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 20,
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.white,
        cursorWidth: 1,
        cursorHeight: 10,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
       
        textAlignVertical: TextAlignVertical.center, // Centre le texte et le curseur
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white, fontSize: 11),
          fillColor: backgroundColor ?? AppColors.backgroundColor,
          filled: true,
          isDense: true, // Réduit l’espace vertical interne
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15), // Ajustement vertical
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
            borderRadius: BorderRadius.circular(30.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.backgroundColor, width: 1),
            borderRadius: BorderRadius.circular(30.0),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: icon,
        ),
      ),
    );
  }
}
