import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/assets/colors/app_colors.dart';
import 'package:surf_practice_chat_flutter/assets/themes/app_typography.dart';

class ChatBottomBar extends StatelessWidget {
  final TextEditingController textController;
  final double bottomBarHeight;
  final void Function() onLocationTap;
  final void Function() onSendTap;

  const ChatBottomBar({
    Key? key,
    required this.textController,
    required this.bottomBarHeight,
    required this.onLocationTap,
    required this.onSendTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: bottomBarHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.my_location_rounded,
                      size: 26,
                      color: AppColors.blueMagentaViolet,
                    ),
                    onTap: onLocationTap,
                  ),
                ),
              ),
              Flexible(
                flex: 75,
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                    bottom: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: const Color.fromARGB(255, 70, 66, 80),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: TextField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    controller: textController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write a message...',
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 206, 205, 205),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.send,
                      size: 26,
                      color: AppColors.blueMagentaViolet,
                    ),
                    onTap: onSendTap,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
