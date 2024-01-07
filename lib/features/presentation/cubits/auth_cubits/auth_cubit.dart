import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/core/utils/hash_password.dart';
import 'package:chat_app_flutter/features/data/datasources/local/sharedpref/shared_preferences_helper.dart';
import 'package:chat_app_flutter/features/data/models/account.dart';
import 'package:chat_app_flutter/features/data/models/profile.dart';
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
    bool isSignIn = await SharedPreferencesHelper.isUserLoggedIn();
    User? user = await usecase().auth.getCurrentUser();
    if (user != null || isSignIn) {
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
        // Save user, account, profile to firestore
        usecase().user.insertAccount(
            Account(uid: user.uid, email: email, password: hashedPassword),
            user.uid);
        usecase().user.insertUser(
            model_user.User(uid: user.uid, userName: userName, chats: []));
        usecase().user.insertProfile(
            Profile(uid: user.uid, userName: userName), user.uid);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthErrorState(message: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthErrorState(
            message: 'The account already exists for that email.'));
      } else {
        emit(AuthErrorState(message: e.message!));
      }
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    emit(AuthLoadingState());
    try {
      final userCredential = await usecase().auth.signIn(email, password);
      if (userCredential.user != null) {
        model_user.User user = model_user.User(
            uid: userCredential.user!.uid,
            userName: userCredential.user!.displayName ?? '',
            chats: []);
        SharedPreferencesHelper.saveUser(user);
        emit(AuthSignInSuccess(user: userCredential.user!));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthErrorState(message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthErrorState(message: 'Wrong password provided for that user.'));
      } else {
        emit(AuthErrorState(message: e.message!));
      }
    }
  }

  Future<void> signOut() async {
    emit(AuthLoadingState());
    try {
      await usecase().auth.signOut();
      await SharedPreferencesHelper.removeUser();
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

  Future<User?> getCurrentUser() async {
    return await usecase().auth.getCurrentUser();
  }
}
