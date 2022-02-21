import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/assets/colors/app_colors.dart';
import 'package:surf_practice_chat_flutter/assets/themes/app_typography.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/geolocation.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/user.dart';

class ChatMessageCard extends StatelessWidget {
  static const double _avatarRadius = 18.0;

  final double rightPadding;
  late final bool _isAuthor;
  late final String _message;
  late final String _authorName;
  late final DateTime _dateTime;
  late final ChatGeolocationDto? _geolocationDto;
  late final TextStyle _messageStyle;
  late final TextStyle _nicknameStyle;
  late final TextStyle _dateTimeStyle;
  late final Color _backgroundColor;
  late final List<Widget> _widgetList;

  ChatMessageCard({
    Key? key,
    required ChatMessageDto message,
    this.rightPadding = 50.0,
  }) : super(key: key) {
    _message = message.message;
    _authorName = message.author.name;
    _isAuthor = message.author is ChatUserLocalDto;
    _messageStyle = _isAuthor
        ? AppTypography.textAuthorMessage
        : AppTypography.textStrangerMessage;
    _nicknameStyle = _isAuthor
        ? AppTypography.nicknameAuthorMessage
        : AppTypography.nicknameStrangerMessage;
    _dateTimeStyle = _isAuthor
        ? AppTypography.dateTimeAuthorMessage
        : AppTypography.dateTimeStrangerMessage;
    _backgroundColor =
        _isAuthor ? AppColors.blueMagentaViolet : AppColors.darkJungleGreen;
    _dateTime = message.createdDateTime;
    _geolocationDto =
        message is ChatMessageGeolocationDto ? message.location : null;
    _initWidgetList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment:
            _isAuthor ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: _isAuthor
            ? [
                _widgetList[3],
                _widgetList[1],
                _widgetList[2],
                _widgetList[0],
              ]
            : [
                _widgetList[0],
                _widgetList[2],
                _widgetList[1],
                _widgetList[3],
              ],
      ),
    );
  }

  // ignore: long-method
  void _initWidgetList() {
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
          child: Column(
            crossAxisAlignment:
                _isAuthor ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Column(
                  crossAxisAlignment: _isAuthor
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      _authorName,
                      style: _nicknameStyle,
                    ),
                    Text(
                      _message,
                      style: _messageStyle,
                    ),
                    Visibility(
                      // TODO: rebuild geolocation method
                      visible: _geolocationDto != null,
                      child: Text(
                        'lat:${_geolocationDto?.latitude}, lon:${_geolocationDto?.longitude},',
                        style: _messageStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 8,
                  right: _isAuthor ? 0 : 10,
                  left: _isAuthor ? 10 : 0,
                ),
                child: Text(
                  _dateTimeToString(_dateTime),
                  style: _dateTimeStyle,
                ),
              ),
            ],
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

  String _dateTimeToString(DateTime time) {
    final result =
        '${time.hour.toString()}:${time.minute < 10 ? '0${time.minute.toString()}  ' : '${time.minute.toString()}  '}';
    if (time.minute < 10) {
      return result.substring(0, result.length - 2);
    }

    return result;
  }
}
