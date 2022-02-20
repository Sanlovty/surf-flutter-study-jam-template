import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/assets/colors/app_colors.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/user.dart';

class MessageCard extends StatelessWidget {
  final ChatMessageDto message;

  const MessageCard({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 228, 230, 231),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              _dateTimeToString(message.createdDateTime),
            ),
            Text('${message.author.name}: '),
            Text(message.message),
          ],
        ),
      ),
    );
  }

  String _dateTimeToString(DateTime time) {
    String result = '${time.hour.toString()}:';
    if (time.minute < 10) {
      result += '0${time.minute.toString()}  ';
    } else {
      result += '${time.minute.toString()}  ';
    }
    return result;
  }
}
