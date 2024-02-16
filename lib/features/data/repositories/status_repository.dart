import 'dart:io';

import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:chat_app_flutter/features/domain/models/status_model.dart';
import 'package:either_dart/either.dart';

abstract class StatusRepository {
  Future<Either<Failure, void>> uploadStatus(
      {required String username,
      required String profilePicture,
      required File statusImage,
      required List<String> uidOnAppContact,
      required String caption});

  Stream<List<StatusModel>> getStatus();
}
