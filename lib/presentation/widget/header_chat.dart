import 'package:flutter/material.dart';

import '../../core/theme.dart';

class HeaderChat extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String userProfilePicture;

  const HeaderChat({
    super.key,
    required this.userName,
    required this.userProfilePicture,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(userProfilePicture),
          ),
          const SizedBox(width: 10),
          Text(
            userName,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: AppColors.bottomBackColor,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}