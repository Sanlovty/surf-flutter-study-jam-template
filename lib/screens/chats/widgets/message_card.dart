import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/assets/themes/app_theme.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';

class MessageCard extends StatelessWidget {
  final ChatMessageDto message;
  final bool isAuthor;

  const MessageCard({
    Key? key,
    required this.message,
    required this.isAuthor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: isAuthor ? Colors.blueAccent : Colors.blue,
      leading: CircleAvatar(
        backgroundColor: defaultTheme.bottomAppBarColor,
        child: const Icon(Icons.person),
      ),
      title: Text(
        message.author.name,
        style: const TextStyle(
          fontSize: 16.0,
          color: Color.fromARGB(255, 198, 184, 223),
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        message.message,
        style: const TextStyle(
          fontSize: 15.0,
          color: Color.fromARGB(255, 113, 105, 138),
          fontWeight: FontWeight.bold,
        ),
      ),
      isThreeLine: true,
      trailing: Text(
        _dateTimeToString(message.createdDateTime),
        style: const TextStyle(
          fontSize: 12.0,
          color: Color.fromARGB(255, 95, 90, 110),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _dateTimeToString(DateTime time) {
    var result = '${time.hour.toString()}:';
    time.minute < 10
        ? result += '0${time.minute.toString()}  '
        : result += '${time.minute.toString()}  ';

    return result;
  }
}
