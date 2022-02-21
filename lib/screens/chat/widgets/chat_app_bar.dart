import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/assets/colors/app_colors.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function() onRefreshTap;
  final TextEditingController nicknameController;
  final double barHeight;

  @override
  Size get preferredSize => Size.fromHeight(barHeight);

  const ChatAppBar({
    Key? key,
    required this.onRefreshTap,
    required this.nicknameController,
    required this.barHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.four,
      actions: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            child: const Icon(Icons.refresh),
            onTap: onRefreshTap,
          ),
        ),
      ],
      title: Container(
        width: 300,
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
        child: TextField(
          style: const TextStyle(
            fontSize: 16.0,
            color: Color.fromARGB(255, 206, 205, 205),
          ),
          controller: nicknameController,
          decoration: const InputDecoration(
            hintText: 'Write a name',
            fillColor: AppColors.blueMagentaViolet,
            hintStyle: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 206, 205, 205),
            ),
          ),
        ),
      ),
    );
  }
}
