import 'dart:io';

import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:chat_app_flutter/core/utils/error/exception/my_exception.dart';
import 'package:chat_app_flutter/features/data/datasources/groups/groups_remote_data_source.dart';
import 'package:chat_app_flutter/features/data/repositories/chat_group_repository.dart';
import 'package:chat_app_flutter/features/domain/models/group_model.dart';
import 'package:either_dart/either.dart';

class ChatGroupRepositoryImpl implements ChatGroupRepository {
  final GroupsRemoteDataSource _chatGroupDataSource;
  ChatGroupRepositoryImpl(this._chatGroupDataSource);

  @override
  Future<Either<Failure, void>> createGroup(
      String name, File profilePicture, List<String> selectedUidContact) async {
    try {
      final result = await _chatGroupDataSource.createGroup(
          name, profilePicture, selectedUidContact);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Stream<List<GroupModel>> getChatGroups() {
    return _chatGroupDataSource.getChatGroups();
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    return _chatGroupDataSource.getNumOfMessageNotSeen(senderId);
  }
}
