import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/assets/themes/app_theme.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';

class MessageCard extends StatelessWidget {
  final ChatMessageDto message;

  const MessageCard({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: defaultTheme.bottomAppBarColor,
        child: const Icon(Icons.person),
      ),
      title: Text(message.author.name),
      subtitle: Text(message.message),
      isThreeLine: true,
      trailing: Text(_dateTimeToString(message.createdDateTime)),
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
