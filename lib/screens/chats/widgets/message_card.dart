import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/assets/colors/app_colors.dart';
import 'package:surf_practice_chat_flutter/assets/themes/app_typography.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/geolocation.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/user.dart';

class MessageCard extends StatelessWidget {
  static const double _avatarRadius = 18.0;

  final double rightPadding;
  late final bool _isAuthor;
  late final String _message;
  late final String _authorName;
  late final DateTime _dateTime;
  late final ChatGeolocationDto? _geolocationDto;
  late final TextStyle _textStyle;
  late final Color _backgroundColor;
  late final List<Widget> _widgetList;

  MessageCard({
    Key? key,
    required ChatMessageDto message,
    this.rightPadding = 50.0,
  }) : super(key: key) {
    _message = message.message;
    _authorName = message.author.name;
    _isAuthor = message.author is ChatUserLocalDto;
    _textStyle = _isAuthor
        ? AppTypography.textAuthorMessage
        : AppTypography.textStrangerMessage;
    _backgroundColor =
        _isAuthor ? AppColors.blueMagentaViolet : AppColors.darkJungleGreen;
    _dateTime = message.createdDateTime;
    if (message is ChatMessageGeolocationDto) {
      _geolocationDto = message.location;
    }

    _widgetList = [
      CircleAvatar(
        backgroundColor: Colors.white,
        radius: _avatarRadius,
        child: Text(_authorName[0]),
      ),
      Flexible(
        child: Container(
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              _message,
              style: _textStyle,
            ),
          ),
        ),
      ),
      const SizedBox(
        width: 15,
      ),
      SizedBox(
        width: rightPadding,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: _isAuthor
            ? [
                _widgetList[0],
                _widgetList[2],
                _widgetList[1],
                _widgetList[3],
              ]
            : [
                _widgetList[3],
                _widgetList[1],
                _widgetList[2],
                _widgetList[0],
              ],
      ),
    );
  }

  String _dateTimeToString(DateTime time) {
    return '${time.hour.toString()}:${time.minute < 10 ? '0${time.minute.toString()}  ' : '${time.minute.toString()}  '}';
  }
}
