import 'package:chat_app_flutter/features/data/repositories/auth_repository.dart';
import 'package:chat_app_flutter/core/utils/error/exception/my_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUseCase implements AuthRepository {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  @override
  Future<UserCredential> signIn(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      throw DatabaseException('SignIn: email or password is empty');
    } else {
      return _repository.signIn(email, password);
    }
  }

  @override
  Future<UserCredential> signUp(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      throw DatabaseException('SignUp: email or password is empty');
    } else {
      return _repository.signUp(email, password);
    }
  }

  @override
  Future<void> signOut() {
    return _repository.signOut();
  }

  @override
  Future<bool> isSignedIn() {
    return _repository.isSignedIn();
  }

  @override
  Future<User?> getCurrentUser() {
    return _repository.getCurrentUser();
  }
}
