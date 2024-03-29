import 'package:chat_app_flutter/core/utils/constants/app_color.dart';
import 'package:chat_app_flutter/core/utils/functions/image_griphy_picker.dart';
import 'package:chat_app_flutter/features/presentation/bloc/chat/bottom_chat/bottom_chat_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/chat/in_chat/in_chat_cubit.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/bottom_field/bottom_chat_field.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/bottom_field/custom_emoji_gif_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// ignore: must_be_immutable
class BottomChatFieldIcon extends StatelessWidget {
  final String receiverId;
  final bool isGroupChat;

  BottomChatFieldIcon(
      {Key? key, required this.receiverId, required this.isGroupChat})
      : super(key: key);

  final TextEditingController messageController =
      TextEditingController(text: "");
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomChatCubit, BottomChatState>(
      builder: (context, state) {
        final cubitRead = context.read<BottomChatCubit>();
        return PopScope(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Row(
                  children: [
                    BottomChatField(
                      isGroupChat: isGroupChat,
                      receiverId: receiverId,
                      isShowEmoji: cubitRead.isShowEmojiContainer,
                      focusNode: focusNode,
                      messageController: messageController,
                      onTapTextField: () => cubitRead.hideEmojiContainer(),
                      toggleEmojiKeyboard: () =>
                          cubitRead.toggleEmojiKeyboard(focusNode),
                      onTextFieldValueChanged: (value) =>
                          cubitRead.showSendButton(value),
                    ),
                    if (cubitRead.isShowSendButton)
                      buildButtonSend(context, cubitRead.isShowSendButton)
                  ],
                ),
              ),

              //Offstage is being used to show or hide a CustomEmojiGifPicker widget based on the value of cubitRead.isShowEmojiContainer.
              // If isShowEmojiContainer is true, the CustomEmojiGifPicker widget will be visible, otherwise it will be hidden.
              Offstage(
                offstage: !cubitRead.isShowEmojiContainer,
                child: CustomEmojiGifPicker(
                  isShowSendButton: cubitRead.isShowSendButton,
                  messageController: messageController,
                  onGifButtonTap: () {
                    selectGif(context);
                  },
                ),
              )
            ],
          ),

          //onWillPop property is set to a callback function that handles the behavior when the back button is pressed. Inside the callback function,
          // it first checks if the isShowEmojiContainer property  is true, which means that the emoji container is currently visible. If it is, it calls
          // the hideEmojiContainer() method to hide the emoji container. Otherwise, it calls Navigator.pop(context) to navigate back to the previous screen.
          onPopInvoked: (bool isShowEmojiContainer) {
            if (isShowEmojiContainer) {
              cubitRead.hideEmojiContainer();
            } else {
              Navigator.pop(context);
            }
            //the callback function returns a Future.value(false), which means that it prevents the back button press from leaving the current screen.
            return;
          },
        );
      },
    );
  }

  Widget buildButtonSend(BuildContext context, bool isShowSendButton) {
    return GestureDetector(
      onTap: () {
        context.read<InChatCubit>().sendTextMessage(
            text: messageController.text.trim(),
            receiverId: receiverId,
            isGroupChat: isGroupChat);
        messageController.clear();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.blue,
        ),
        width: 50,
        height: 50,
        child: Icon(Icons.send, color: AppColor.primaryColor),
      ),
    );
  }

  void selectGif(BuildContext context) async {
    final gif = await pickGif(context);
    if (gif != null) {
      // ignore: use_build_context_synchronously
      final inChatCubit = context.read<InChatCubit>();
      inChatCubit.sendGIFMessage(
        gifUrl: gif.url!,
        receiverId: receiverId,
        isGroupChat: isGroupChat,
      );
    }
  }
}
