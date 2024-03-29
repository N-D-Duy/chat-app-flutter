import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/data/datasources/auth/auth_local.dart';
import 'package:chat_app_flutter/features/data/datasources/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService();
  final FirebaseAuth _auth = FirebaseService.auth;
  final _authLocalDataSource = di<AuthLocalDataSource>();
  /* final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TwitterLogin _twitterLogin = TwitterLogin(
    consumerKey: 'your_consumer_key',
    consumerSecret: 'your_consumer_secret',
  );
  

  final FacebookLogin _facebookLogin = FacebookLogin(); */

  Future<UserCredential> signInWithEmail(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    //save to local
    await _authLocalDataSource.setUserId(userCredential.user!.uid);
    return userCredential;
  }

  Future<UserCredential> signUpWithEmail(String email, String password) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      //remove from local
      await _authLocalDataSource.removeUserId();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isSignedIn() async {
    final currentUser = _auth.currentUser;
    return currentUser != null;
  }

  Future<User?> getCurrentUser() async {
    final currentUser = _auth.currentUser;
    return currentUser;
  }

  Future<String> getCurrentUserId() async {
    final currentUser = _auth.currentUser;
    return currentUser!.uid;
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isUserLoggedIn() async {
    if (await _authLocalDataSource.isUserLoggedIn()) {
      return true;
    }
    return _auth.currentUser != null;
  }

  /* Future<UserCredential> signInWithGoogle() async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      throw e;
    }
  }

  Future<UserCredential> signInWithTwitter() async {
    try {
      final TwitterLoginResult result = await _twitterLogin.authorize();
      switch (result.status) {
        case TwitterLoginStatus.loggedIn:
          final credential = TwitterAuthProvider.credential(
            accessToken: result.session.token,
            secret: result.session.secret,
          );
          UserCredential userCredential = await _auth.signInWithCredential(credential);
          return userCredential;
        case TwitterLoginStatus.cancelledByUser:
          throw Exception('Login cancelled by user.');
        case TwitterLoginStatus.error:
          throw Exception('Login error: ${result.errorMessage}');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    try {
      final FacebookLoginResult result = await _facebookLogin.logIn(['email']);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final credential = FacebookAuthProvider.credential(
            result.accessToken.token,
          );
          UserCredential userCredential = await _auth.signInWithCredential(credential);
          return userCredential;
        case FacebookLoginStatus.cancelledByUser:
          throw Exception('Login cancelled by user.');
        case FacebookLoginStatus.error:
          throw Exception('Login error: ${result.errorMessage}');
      }
    } catch (e) {
      throw e;
    }
  } */
}
