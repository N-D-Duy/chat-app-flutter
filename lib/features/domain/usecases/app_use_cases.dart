// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app_flutter/features/domain/usecases/auth/auth_cases.dart';
import 'package:chat_app_flutter/features/domain/usecases/call/call_usecase.dart';
import 'package:chat_app_flutter/features/domain/usecases/chat/chat_cases.dart';
import 'package:chat_app_flutter/features/domain/usecases/chat_contacts/message_contact_cases.dart';
import 'package:chat_app_flutter/features/domain/usecases/chat_group/chat_group_usecase.dart';
import 'package:chat_app_flutter/features/domain/usecases/contacts/contacts_use_case.dart';
import 'package:chat_app_flutter/features/domain/usecases/status/status_cases.dart';
import 'package:chat_app_flutter/features/domain/usecases/user/user_cases.dart';

class AppUseCases {
  final ChatUseCase chat;
  final UserUseCase user;
  final AuthUseCase auth;
  final StatusUseCases status;
  final ChatContactsUseCase chatContacts;
  final ContactsUseCase contacts;
  final ChatGroupUseCase chatGroup;
  final CallUseCase call;
  AppUseCases({
    required this.chat,
    required this.user,
    required this.auth,
    required this.status,
    required this.chatContacts,
    required this.contacts,
    required this.chatGroup,
    required this.call,
  });
}
