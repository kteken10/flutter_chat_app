import 'package:flutter/material.dart';
import '../../core/theme.dart';
import 'input.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;

  const SearchInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: InputField(
            height: 30,
            borderRadius: 8,
            backgroundColor: AppColors.inputBackground,
            controller: controller,
            label: '',
            keyboardType: TextInputType.text,
            obscureText: false,
            prefixIcon: const Icon(Icons.search, color: Colors.grey,size: 26), // Icône de recherche à gauche
          ),
        ),
       
        
      ],
    );
  }
}
