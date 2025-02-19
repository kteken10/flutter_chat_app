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
            backgroundColor: AppColors.inputBackground,
            controller: controller,
            label: '',
            keyboardType: TextInputType.text,
            obscureText: false,
            prefixIcon: const Icon(Icons.search, color: Colors.grey,size: 26), // Icône de recherche à gauche
          ),
        ),
        const SizedBox(width: 10), // Espacement entre l'input et l'icône "+"
        InkWell(
          onTap: () {
            // Action pour l'icône "+"
          },
          borderRadius: BorderRadius.circular(30),
          splashColor: const Color.fromARGB(255, 202, 207, 217),
          highlightColor: Colors.blue.withOpacity(0.7),
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
