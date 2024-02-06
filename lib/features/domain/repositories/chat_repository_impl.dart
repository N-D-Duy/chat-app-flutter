import 'dart:io';

// ignore: implementation_imports
import 'package:either_dart/src/either.dart';

import 'package:chat_app_flutter/core/utils/enum/message_type.dart';
import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:chat_app_flutter/features/data/datasources/chats/chat_data_source.dart';
import 'package:chat_app_flutter/features/domain/models/message_model.dart';
import 'package:chat_app_flutter/features/domain/models/message_reply_model.dart';
import 'package:chat_app_flutter/features/data/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _chatRemoteDataSource;
  ChatRepositoryImpl(this._chatRemoteDataSource);
  @override
  Stream<List<Message>> getChatStream(String receiverId) {
    return _chatRemoteDataSource.getChatStream(receiverId);
  }

  @override
  Stream<List<Message>> getGroupChatStream(String groupId) {
    return _chatRemoteDataSource.getGroupChatStream(groupId);
  }

  @override
  Future<Either<Failure, void>> sendFileMessage(
      {required File file,
      required String receiverId,
      required MessageType messageType,
      required MessageReplyModel? messageReply,
      required bool isGroupChat}) async {
    try {
      final result = await _chatRemoteDataSource.sendFileMessage(
          file: file,
          receiverId: receiverId,
          messageType: messageType,
          messageReply: messageReply,
          isGroupChat: isGroupChat);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendGIFMessage(
      {required String gifUrl,
      required String receiverId,
      required MessageReplyModel? messageReply,
      required bool isGroupChat}) async {
    try {
      final result = await _chatRemoteDataSource.sendGIFMessage(
          gifUrl: gifUrl,
          receiverId: receiverId,
          messageReply: messageReply,
          isGroupChat: isGroupChat);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendTextMessage(
      {required String text,
      required String receiverId,
      required MessageReplyModel? messageReply,
      required bool isGroupChat}) async {
    try {
      final result = await _chatRemoteDataSource.sendTextMessage(
          text: text,
          receiverId: receiverId,
          messageReply: messageReply,
          isGroupChat: isGroupChat);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setMessageSeen(
      String receiverId, String messageId) async {
    try {
      final result =
          await _chatRemoteDataSource.setMessageSeen(receiverId, messageId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
