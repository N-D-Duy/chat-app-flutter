import 'dart:io';

import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/domain/models/group_model.dart';
import 'package:chat_app_flutter/features/domain/usecases/app_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_group_state.dart';

class ChatGroupCubit extends Cubit<ChatGroupState> {
  ChatGroupCubit() : super(ChatGroupInitial());
  final usecase = di<AppUseCases>;
  List<String> selectedContactUid = [];

  Future<void> selectContact(String uidContact) async {
    selectedContactUid.add(uidContact);
    // ignore: avoid_print
    print("selectedContactUId $selectedContactUid");
    emit(ChooseContactSuccess());
  }

  Future<void> createGroup(
      String name, File profilePicture, List<String> selectedUidContact) async {
    final result = await usecase()
        .chatGroup
        .createGroup(name, profilePicture, selectedUidContact);
    result.fold(
      (l) => emit(ChatGroupError(l.message)),
      (r) {
        selectedContactUid = [];
        emit(ChatGroupCreated());
      },
    );
  }

  Stream<List<GroupModel>> getChatGroups() {
    return usecase().chatGroup.getChatGroups();
  }

  Stream<int> getNumOfMessageNotSeen(String senderId) =>
      usecase().chatGroup.getNumOfMessageNotSeen(senderId);
}
