import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/core/utils/hash_password.dart';
import 'package:chat_app_flutter/features/data/models/account.dart';
import 'package:chat_app_flutter/features/data/models/user.dart' as model_user;
import 'package:chat_app_flutter/features/domain/usecases/use_cases.dart';
import 'package:chat_app_flutter/features/presentation/cubits/auth_cubits/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final usecase = di<UseCases>;
  AuthCubit() : super(AuthInitialState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    User? user = await usecase().auth.getCurrentUser();
    if (user != null) {
      emit(AuthLoggedInState());
    } else {
      emit(AuthLoggedOutState());
    }
  }

  Future<void> signUpWithEmail(
      String email, String password, String userName) async {
    emit(AuthLoadingState());
    try {
      final userCredential = await usecase().auth.signUp(email, password);
      User? user = userCredential.user;
      if (user != null) {
        emit(AuthSignUpSuccess(user: user));
        String hashedPassword = hashPassword(password);
        usecase().user.insertAccount(
            Account(uid: user.uid, email: email, password: hashedPassword),
            user.uid);
        usecase().user.insertUser(
            model_user.User(uid: user.uid, userName: userName, chats: []));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(message: e.message!));
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    emit(AuthLoadingState());
    try {
      final userCredential = await usecase().auth.signIn(email, password);
      if (userCredential.user != null) {
        emit(AuthSignInSuccess(user: userCredential.user!));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(message: e.message!));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoadingState());
    try {
      await usecase().auth.signOut();
      emit(AuthLoggedOutState());
    } catch (e) {
      emit(AuthErrorState(message: e.toString()));
      rethrow;
    }
  }

  Future<void> isSignedIn() async {
    emit(AuthLoadingState());
    try {
      final isSignedIn = await usecase().auth.isSignedIn();
      if (isSignedIn) {
        emit(AuthLoggedInState());
      } else {
        emit(AuthLoggedOutState());
      }
    } catch (e) {
      emit(AuthErrorState(message: e.toString()));
      rethrow;
    }
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoadingState());
    try {
      await usecase().auth.getCurrentUser();
      emit(AuthLoggedInState());
    } catch (e) {
      emit(AuthErrorState(message: e.toString()));
      rethrow;
    }
  }
}
