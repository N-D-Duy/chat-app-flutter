import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final _profileRepository = di<UserRepository>();

  ProfileCubit() : super(ProfileInitialState());
}
