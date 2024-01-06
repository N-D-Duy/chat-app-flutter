import 'package:chat_app_flutter/features/data/repositories/repository.dart';
import 'package:chat_app_flutter/features/domain/repositories/repository_impl.dart';
import 'package:chat_app_flutter/features/domain/usecases/use_cases.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

Future<void> initialDependencies() async {
  di.registerLazySingleton<Repository>(() => RepositoryImpl());
  di.registerLazySingleton<UseCases>(() => UseCases(di()));
}
