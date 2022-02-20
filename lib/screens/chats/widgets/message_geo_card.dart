import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';

class MessageGeoCard extends StatelessWidget {
  final ChatMessageGeolocationDto message;
  final bool isAuthor;

  const MessageGeoCard({
    Key? key,
    required this.message,
    required this.isAuthor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Text(message.location.latitude.toString()),
        Text(message.location.longitude.toString()),
      ]),
    );
  }
}
