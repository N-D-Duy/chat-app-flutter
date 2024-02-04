import 'package:chat_app_flutter/features/data/datasources/auth/auth_local.dart';
import 'package:chat_app_flutter/features/data/datasources/auth/auth_service.dart';
import 'package:chat_app_flutter/features/data/datasources/chats/chat_data_source.dart';
import 'package:chat_app_flutter/features/data/datasources/chat_contacts/chat_contacts.dart';
import 'package:chat_app_flutter/features/data/datasources/contacts/contacts_data_source.dart';
import 'package:chat_app_flutter/features/data/datasources/status/status_data_source.dart';
import 'package:chat_app_flutter/features/data/datasources/user/user_data_source.dart';
import 'package:chat_app_flutter/features/data/repositories/auth_repository.dart';
import 'package:chat_app_flutter/features/data/repositories/chat_repository.dart';
import 'package:chat_app_flutter/features/data/repositories/contacts_repository.dart';
import 'package:chat_app_flutter/features/data/repositories/message_contact_repository.dart';
import 'package:chat_app_flutter/features/data/repositories/status_repository.dart';
import 'package:chat_app_flutter/features/data/repositories/user_repository.dart';
import 'package:chat_app_flutter/features/domain/repositories/auth_repository_impl.dart';
import 'package:chat_app_flutter/features/domain/repositories/chat_repository_impl.dart';
import 'package:chat_app_flutter/features/domain/repositories/contacts_repository_impl.dart';
import 'package:chat_app_flutter/features/domain/repositories/message_contact_repository_impl.dart';
import 'package:chat_app_flutter/features/domain/repositories/status_repository_impl.dart';
import 'package:chat_app_flutter/features/domain/repositories/user_repository_impl.dart';
import 'package:chat_app_flutter/features/domain/usecases/app_use_cases.dart';
import 'package:chat_app_flutter/features/domain/usecases/auth/auth_cases.dart';
import 'package:chat_app_flutter/features/domain/usecases/chat/chat_cases.dart';
import 'package:chat_app_flutter/features/domain/usecases/chat_contacts/message_contact_cases.dart';
import 'package:chat_app_flutter/features/domain/usecases/contacts/contacts_use_case.dart';
import 'package:chat_app_flutter/features/domain/usecases/status/status_cases.dart';
import 'package:chat_app_flutter/features/domain/usecases/user/user_cases.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

Future<void> initialDependencies() async {
  //DataSources
  di.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl());
  di.registerLazySingleton<AuthService>(() => AuthService());
  di.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl());
  di.registerLazySingleton<StatusRemoteDataSource>(
      () => StatusRemoteDataSourceImpl());
  di.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl());
  di.registerLazySingleton<ChatContactsRemoteDataSource>(
      () => MessageContactsRemoteDataSourceImpl());
  di.registerLazySingleton<ContactsRemoteDataSource>(
      () => ContactsRemoteDataSourceImpl());

  //Repository
  di.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(di()));
  di.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(di()));
  di.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(di()));
  di.registerLazySingleton<MessageContactRepository>(
      () => MessageContactRepositoryImpl(di()));
  di.registerLazySingleton<StatusRepository>(() => StatusRepositoryImpl(di()));
  di.registerLazySingleton<ContactsRepository>(
      () => ContactsRepositoryImpl(di()));

  //UseCases
  di.registerLazySingleton<AuthUseCase>(() => AuthUseCase(di()));
  di.registerLazySingleton<UserUseCase>(() => UserUseCase(di()));
  di.registerLazySingleton<ChatUseCase>(() => ChatUseCase(di()));
  di.registerLazySingleton<ChatContactsUseCase>(
      () => ChatContactsUseCase(di()));
  di.registerLazySingleton<StatusUseCases>(() => StatusUseCases(di()));
  di.registerLazySingleton<ContactsUseCase>(() => ContactsUseCase(di()));
  di.registerLazySingleton<AppUseCases>(() => AppUseCases(
        auth: di(),
        user: di(),
        chat: di(),
        status: di(),
        chatContacts: di(),
        contacts: di(),
      ));
}
