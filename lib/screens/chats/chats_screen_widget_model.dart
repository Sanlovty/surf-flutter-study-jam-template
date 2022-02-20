import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_practice_chat_flutter/app/di/app_component.dart';
import 'package:surf_practice_chat_flutter/assets/res/app_icons.dart';
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

  Future<void> onRefresh() async {
    await _fetchMessages();
  }

  Future<void> onSendTap() async {
    final nickname =
        nicknameController.text.isEmpty ? 'Unknown' : nicknameController.text;
    final message = textController.text;
    if (message.isNotEmpty) {
      await chatRepository.sendMessage(nickname, message);
      textController.clear();
      await _fetchMessages();
    }
  }

  // ignore: member-ordering-extended
  @override
  void onLoad() {
    super.onLoad();
    _fetchMessages();
  }

  Future<void> _fetchMessages() async {
    final response = await chatRepository.messages;
    await messages.accept(response.reversed.toList());
  }
}
