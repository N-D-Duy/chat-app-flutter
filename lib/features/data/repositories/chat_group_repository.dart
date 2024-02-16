import 'dart:io';

import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:chat_app_flutter/features/domain/models/group_model.dart';
import 'package:either_dart/either.dart';

abstract class ChatGroupRepository {
  Future<Either<Failure, void>> createGroup(
      String name, File profilePicture, List<String> selectedUidContact);
  Stream<List<GroupModel>> getChatGroups();
  Stream<int> getNumOfMessageNotSeen(String senderId);
}
