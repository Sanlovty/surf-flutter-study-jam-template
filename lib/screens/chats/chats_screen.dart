import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:surf_practice_chat_flutter/assets/colors/app_colors.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/user.dart';
import 'package:surf_practice_chat_flutter/screens/chats/chats_screen_widget_model.dart';
import 'package:surf_practice_chat_flutter/screens/chats/widgets/message_card.dart';
import 'package:surf_util/surf_util.dart';

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
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 22, 15, 49),
          actions: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                child: const Icon(Icons.refresh),
                onTap: wm.onRefreshTap,
              ),
            ),
          ],
          title: Container(
            width: 300,
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
            child: TextField(
              style: const TextStyle(
                fontSize: 16.0,
                color: Color.fromARGB(255, 206, 205, 205),
              ),
              controller: wm.nicknameController,
              decoration: const InputDecoration(
                hintText: 'Write a name',
                fillColor: AppColors.blueMagentaViolet,
                hintStyle: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 206, 205, 205),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: wm.bottomBarHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: GestureDetector(
                        child: const Icon(
                          Icons.my_location_rounded,
                          size: 26,
                          color: AppColors.blueMagentaViolet,
                        ),
                        onTap: wm.onLocationTap,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 75,
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                        bottom: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5,
                          color: const Color.fromARGB(255, 70, 66, 80),
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                      ),
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        controller: wm.textController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write a message...',
                          hintStyle: TextStyle(
                            fontSize: 16.0,
                            color: Color.fromARGB(255, 206, 205, 205),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: GestureDetector(
                        child: const Icon(
                          Icons.send,
                          size: 26,
                          color: AppColors.blueMagentaViolet,
                        ),
                        onTap: wm.onSendTap,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                    child: MessageCard(
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
