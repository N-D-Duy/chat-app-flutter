// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Account {
  final String uid;
  final String email;
  final String password;
  Account({
    required this.uid,
    required this.email,
    required this.password,
  });
  Account.defaultConstructorMethod()
      : uid = '',
        email = '',
        password = '';

  Account copyWith({
    String? uid,
    String? email,
    String? password,
  }) {
    return Account(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'password': password,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      uid: map['uid'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Account(uid: $uid, email: $email, password: $password)';

  @override
  bool operator ==(covariant Account other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode ^ password.hashCode;

  static defaultConstructor() {}
}
