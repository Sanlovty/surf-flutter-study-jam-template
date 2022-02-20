import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_practice_chat_flutter/app/di/app_component.dart';
import 'package:surf_practice_chat_flutter/assets/res/app_icons.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/geolocation.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';
import 'package:surf_practice_chat_flutter/data/chat/repository/repository.dart';

ChatsScreenWidgetModel createChatsScreenWidgetModel(BuildContext context) {
  return ChatsScreenWidgetModel(
    navigator:
        Injector.of<AppComponent>(context).component.navigator.currentState!,
    scaffoldKey: Injector.of<AppComponent>(context).component.scaffoldKey,
    chatRepository: Injector.of<AppComponent>(context).component.chatRepository,
  );
}

/// [WidgetModel] для начального экрана
class ChatsScreenWidgetModel extends WidgetModel {
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

  ChatsScreenWidgetModel({
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
