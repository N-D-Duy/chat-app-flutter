import 'dart:io';

import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:chat_app_flutter/core/utils/error/exception/my_exception.dart';
import 'package:chat_app_flutter/features/domain/models/status_model.dart';
import 'package:chat_app_flutter/features/data/repositories/status_repository.dart';
// ignore: implementation_imports
import 'package:either_dart/src/either.dart';

class StatusUseCases implements StatusRepository {
  final StatusRepository _statusRepository;

  StatusUseCases(this._statusRepository);

  @override
  Future<Either<Failure, void>> uploadStatus(
      {required String username,
      required String profilePicture,
      required File statusImage,
      required List<String> uidOnAppContact,
      required String caption}) {
    if (username.isEmpty ||
        profilePicture.isEmpty ||
        statusImage.path.isEmpty ||
        caption.isEmpty) {
      throw DatabaseException('uploadStatus: some parameter is empty');
    } else {
      return _statusRepository.uploadStatus(
          username: username,
          profilePicture: profilePicture,
          statusImage: statusImage,
          uidOnAppContact: uidOnAppContact,
          caption: caption);
    }
  }

  @override
  Stream<List<StatusModel>> getStatus() {
    return _statusRepository.getStatus();
  }
}
