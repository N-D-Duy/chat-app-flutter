import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/domain/usecases/app_use_cases.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/status_model.dart';

part 'status_state.dart';

class StatusCubit extends Cubit<StatusState> {
  final repository = di<AppUseCases>().status;

  StatusCubit() : super(StatusInitial());

  Future<void> addStatus(
      {required String username,
      required String profilePicture,
      required String phoneNumber,
      required File statusImage,
      required List<String> uidOnAppContact,
      required String caption}) async {
    emit(StatusLoadingState());
    final result = await repository.uploadStatus(
        username: username,
        profilePicture: profilePicture,
        phoneNumber: phoneNumber,
        statusImage: statusImage,
        uidOnAppContact: uidOnAppContact,
        caption: caption);
    result.fold(
      (error) => emit(StatusErrorState(error.message)),
      (success) => emit(UploadStatusSuccess()),
    );
  }

  Stream<List<StatusModel>> getStatus() {
    return repository.getStatus();
  }
}
