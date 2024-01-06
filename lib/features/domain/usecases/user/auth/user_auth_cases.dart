
import 'package:chat_app_flutter/features/data/repositories/repository.dart';
import 'package:chat_app_flutter/core/error/exception/my_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuth{
  final Repository _repository;

  UserAuth(this._repository);

  Future<UserCredential> signIn(String email, String password) async{
    if(email.isEmpty || password.isEmpty){
      throw MyException('SignIn: email or password is empty');
    } else{
      return _repository.signIn(email, password);
    }
  }
  Future<UserCredential> signUp(String email, String password) async{
    if(email.isEmpty || password.isEmpty){
      throw MyException('SignUp: email or password is empty');
    } else{
      return _repository.signUp(email, password);
    }
  }
  Future<void> signOut() async{
    await _repository.signOut();
  }
  Future<bool> isSignedIn() async{
    return await _repository.isSignedIn();
  }
  Future<User?> getCurrentUser() async{
    return await _repository.getCurrentUser();
  }
}