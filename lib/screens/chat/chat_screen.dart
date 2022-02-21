import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:surf_practice_chat_flutter/assets/colors/app_colors.dart';
import 'package:surf_practice_chat_flutter/screens/chat/chat_screen_widget_model.dart';
import 'package:surf_practice_chat_flutter/screens/chat/widgets/chat_app_bar.dart';
import 'package:surf_practice_chat_flutter/screens/chat/widgets/chat_bottom_bar.dart';
import 'package:surf_practice_chat_flutter/screens/chat/widgets/chat_message_card.dart';
import 'package:surf_util/surf_util.dart';

/// Splash screen
class ChatScreen extends CoreMwwmWidget<ChatScreenWidgetModel> {
  const ChatScreen({
    Key? key,
  }) : super(
          key: key,
          widgetModelBuilder: createChatScreenWidgetModel,
        );

  @override
  WidgetState<ChatScreen, ChatScreenWidgetModel> createWidgetState() =>
      _ChatScreenState();
}

class _ChatScreenState extends WidgetState<ChatScreen, ChatScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 11, 9, 17),
            Color.fromARGB(255, 24, 27, 48),
            Color.fromARGB(255, 37, 31, 65),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: ChatAppBar(
          onRefreshTap: wm.onRefreshTap,
          nicknameController: wm.nicknameController,
          barHeight: 60.0,
        ),
        bottomNavigationBar: ChatBottomBar(
          textController: wm.textController,
          bottomBarHeight: wm.bottomBarHeight,
          onLocationTap: wm.onLocationTap,
          onSendTap: wm.onSendTap,
        ),
        body: StreamedStateBuilder(
          streamedState: wm.messages,
          builder: (context, message) {
            return DisableOverscroll(
              child: ListView.builder(
                reverse: true,
                itemCount: wm.messages.value.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ChatMessageCard(
                      message: wm.messages.value[index],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
