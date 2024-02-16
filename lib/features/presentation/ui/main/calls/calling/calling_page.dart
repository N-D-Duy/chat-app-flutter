import 'package:agora_uikit/agora_uikit.dart';
import 'package:chat_app_flutter/config/agora_config.dart';
import 'package:chat_app_flutter/core/utils/constants/app_color.dart';
import 'package:chat_app_flutter/features/domain/models/call_model.dart';
import 'package:chat_app_flutter/features/presentation/bloc/call/call_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CallingPage extends StatefulWidget {
  static const routeName = 'call-pickup';

  final String channelId;
  final CallModel call;
  final bool isGroupChat;

  const CallingPage(
      {Key? key,
      required this.channelId,
      required this.call,
      required this.isGroupChat})
      : super(key: key);

  @override
  State<CallingPage> createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage> {
  AgoraClient? client;
  String baseUrl = 'https://whatsapp-clone-rrr.herokuapp.com';

  @override
  void initState() {
    super.initState();
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConfig.appId,
        channelName: widget.channelId,
        tokenUrl: baseUrl,
      ),
    );
    initAgora();
  }

  void initAgora() async {
    await client!.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: client == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Stack(
                children: [
                  AgoraVideoViewer(client: client!),
                  AgoraVideoButtons(
                      client: client!,
                      disconnectButtonChild: GestureDetector(
                        onTap: () async {
                          await client!.engine.leaveChannel();
                          if (!mounted) return;
                          context.read<CallCubit>().endCall(
                                callerId: widget.call.callerId,
                                receiverId: widget.call.receiverId,
                              );
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColor.red,
                          radius: 25,
                          child: Icon(Icons.call_end,
                              color: AppColor.primaryColor),
                        ),
                      )),
                ],
              ),
            ),
    );
  }
}
