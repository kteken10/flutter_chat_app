import 'package:flutter/material.dart';

import '../../core/theme.dart';

class SectionTab extends StatefulWidget {
  final List<String> tabs;
  final Function(int) onTabSelected;

  const SectionTab({
    super.key,
    required this.tabs,
    required this.onTabSelected,
  });

  @override
  State<SectionTab> createState() => _SectionTabState();
}

class _SectionTabState extends State<SectionTab> {
  int _selectedIndex = 0; 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8), 
      width: double.infinity, 
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, 
        child: Row(
          children: widget.tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tabLabel = entry.value;
            final isSelected = index == _selectedIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onTabSelected(index); 
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.inputBackground.withOpacity(0.7) : Colors.grey[200], 
                  borderRadius: BorderRadius.circular(20.0), 
                ),
                child: Center(
                  child: Text(
                    tabLabel,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}