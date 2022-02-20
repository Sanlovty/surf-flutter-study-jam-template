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
    return Card(
        child: Container(
      decoration: BoxDecoration(
        color: defaultTheme.cardColor,
      ),
    ));
  }

  String _dateTimeToString(DateTime time) {
    var result = '${time.hour.toString()}:';
    time.minute < 10
        ? result += '0${time.minute.toString()}  '
        : result += '${time.minute.toString()}  ';

    return result;
  }
}
