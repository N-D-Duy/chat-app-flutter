import 'dart:io';

import 'package:chat_app_flutter/core/utils/enum/message_type.dart';
import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:chat_app_flutter/features/data/models/message_model.dart';
import 'package:chat_app_flutter/features/data/models/message_reply_model.dart';
import 'package:either_dart/either.dart';

abstract class ChatRepository {
  Stream<List<Message>> getChatStream(String receiverId);

  Stream<List<Message>> getGroupChatStream(String groupId);

  Future<Either<Failure, void>> sendTextMessage(
      {required String text,
      required String receiverId,
      required MessageReplyModel? messageReply,
      required bool isGroupChat});

  Future<Either<Failure, void>> sendGIFMessage(
      {required String gifUrl,
      required String receiverId,
      required MessageReplyModel? messageReply,
      required bool isGroupChat});

  Future<Either<Failure, void>> sendFileMessage(
      {required File file,
      required String receiverId,
      required MessageType messageType,
      required MessageReplyModel? messageReply,
      required bool isGroupChat});

  Future<Either<Failure, void>> setMessageSeen(
      String receiverId, String messageId);
}
