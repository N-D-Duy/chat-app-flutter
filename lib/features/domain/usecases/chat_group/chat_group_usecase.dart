import 'dart:io';

import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:chat_app_flutter/features/data/repositories/chat_group_repository.dart';
import 'package:chat_app_flutter/features/domain/models/group_model.dart';
import 'package:either_dart/either.dart';

class ChatGroupUseCase implements ChatGroupRepository {
  final ChatGroupRepository _chatGroupRepository;
  ChatGroupUseCase(this._chatGroupRepository);

  @override
  Future<Either<Failure, void>> createGroup(
      String name, File profilePicture, List<String> selectedUidContact) {
    if (name.isEmpty || selectedUidContact.isEmpty) {
      throw Exception('Please fill all the fields');
    } else {
      return _chatGroupRepository.createGroup(
          name, profilePicture, selectedUidContact);
    }
  }

  @override
  Stream<List<GroupModel>> getChatGroups() {
    return _chatGroupRepository.getChatGroups();
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    if (senderId.isEmpty) {
      throw Exception('Please fill all the fields');
    } else {
      return _chatGroupRepository.getNumOfMessageNotSeen(senderId);
    }
  }
}
