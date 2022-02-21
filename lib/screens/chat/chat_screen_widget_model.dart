import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_practice_chat_flutter/app/di/app_component.dart';
import 'package:surf_practice_chat_flutter/assets/res/app_icons.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/geolocation.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/user.dart';
import 'package:surf_practice_chat_flutter/data/chat/repository/repository.dart';

ChatScreenWidgetModel createChatScreenWidgetModel(BuildContext context) {
  return ChatScreenWidgetModel(
    navigator:
        Injector.of<AppComponent>(context).component.navigator.currentState!,
    scaffoldKey: Injector.of<AppComponent>(context).component.scaffoldKey,
    chatRepository: Injector.of<AppComponent>(context).component.chatRepository,
  );
}

const _mockUser = ChatUserDto(
  name: 'Afganistan',
);
final _mockUserMe = ChatUserLocalDto(
  name: 'Myselft',
);
final _mockLocation = ChatGeolocationDto(
  latitude: 55.0,
  longitude: 106.442,
);
final _mockDateTime = DateTime.now();

final _mockShortMessage = 'Short message';
final _mockLongMessage =
    'Very very very very very very very very very very very  very very very very very very very very very very  very very very very very very very very very very long message';

/// [WidgetModel] для начального экрана
class ChatScreenWidgetModel extends WidgetModel {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final NavigatorState navigator;
  final ChatRepository chatRepository;
  final String logoPath = AppIcons.splashIcon;

  final double loginFieldHeight = 45;
  final double loginFieldWidth = double.infinity;
  final double passwordFieldHeight = 45;
  final double passwordFieldWidth = double.infinity;
  final double bottomBarHeight = 60;

  final nicknameController = TextEditingController();
  final textController = TextEditingController();
  final messages = StreamedState<List<ChatMessageDto>>([]);
  final _messages = StreamedState<List<ChatMessageDto>>([
    ChatMessageDto(
      author: _mockUser,
      message: _mockLongMessage,
      createdDateTime: _mockDateTime,
    ),
    ChatMessageDto(
      author: _mockUserMe,
      message: _mockShortMessage,
      createdDateTime: _mockDateTime,
    ),
    ChatMessageDto(
      author: _mockUserMe,
      message: _mockLongMessage,
      createdDateTime: _mockDateTime,
    ),
    ChatMessageGeolocationDto(
      author: _mockUser,
      location: _mockLocation,
      message: _mockLongMessage,
      createdDate: _mockDateTime,
    ),
    ChatMessageGeolocationDto(
      author: _mockUserMe,
      location: _mockLocation,
      message: _mockShortMessage,
      createdDate: _mockDateTime,
    ),
  ]);

  ChatScreenWidgetModel({
    required this.navigator,
    required this.scaffoldKey,
    required this.chatRepository,
  }) : super(const WidgetModelDependencies());

  Future<void> onRefreshTap() async {
    await _fetchMessages();
  }

  Future<void> onLocationTap() async {
    final response = await _determinePosition();

    final nickname = _getNickname();
    final location = ChatGeolocationDto(
      latitude: response.latitude,
      longitude: response.longitude,
    );
    await chatRepository.sendGeolocationMessage(
      nickname: nickname,
      location: location,
    );
    await _fetchMessages();
  }

  Future<void> onSendTap() async {
    final nickname = _getNickname();
    final message = _getMessage();
    if (message.isNotEmpty) {
      await chatRepository.sendMessage(nickname, message);
      textController.clear();
      await _fetchMessages();
    }
  }

  String _getNickname() {
    return nicknameController.text.isEmpty
        ? 'Unknown'
        : nicknameController.text;
  }

  String _getMessage() {
    return textController.text;
  }

  // ignore: member-ordering-extended
  @override
  void onLoad() {
    super.onLoad();
    _fetchMessages();
  }

  // ignore: member-ordering-extended
  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  Future<void> _fetchMessages() async {
    final response = await chatRepository.messages;
    await messages.accept(response.reversed.toList());
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }
}
