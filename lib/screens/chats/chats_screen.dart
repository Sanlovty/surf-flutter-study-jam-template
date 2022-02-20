import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:surf_practice_chat_flutter/assets/colors/app_colors.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';
import 'package:surf_practice_chat_flutter/screens/chats/chats_screen_widget_model.dart';
import 'package:surf_practice_chat_flutter/screens/chats/widgets/message_card.dart';

/// Splash screen
class ChatsScreen extends CoreMwwmWidget<ChatsScreenWidgetModel> {
  const ChatsScreen({
    Key? key,
  }) : super(
          key: key,
          widgetModelBuilder: createChatsScreenWidgetModel,
        );

  @override
  WidgetState<ChatsScreen, ChatsScreenWidgetModel> createWidgetState() =>
      _ChatsScreenState();
}

class _ChatsScreenState
    extends WidgetState<ChatsScreen, ChatsScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          GestureDetector(
            child: const Icon(Icons.refresh),
            onTap: wm.onRefreshTap,
          ),
        ],
        title: TextField(
          controller: wm.nicknameController,
          decoration: const InputDecoration(
            hintText: 'Введите ник',
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: wm.bottomBarHeight,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 30,
                    child: TextField(
                      controller: wm.textController,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Сообщение',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Flexible(
                    child: GestureDetector(
                      child: const Icon(
                        Icons.send,
                      ),
                      onTap: wm.onSendTap,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: AppColors.brightGray,
        child: StreamedStateBuilder<List<ChatMessageDto>>(
          streamedState: wm.messages,
          builder: (context, message) {
            return ListView.builder(
              reverse: true,
              itemCount: wm.messages.value.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MessageCard(
                    message: wm.messages.value[index],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
