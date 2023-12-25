// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Profile {
  String userName;
  String? phone;
  String? address;
  String? birthday;
  String avatar;
  String? gender;
  Profile({
    required this.userName,
    this.phone,
    this.address,
    this.birthday,
    required this.avatar,
    this.gender,
  });


  Profile copyWith({
    String? userName,
    String? phone,
    String? address,
    String? birthday,
    String? avatar,
    String? gender,
  }) {
    return Profile(
      userName: userName ?? this.userName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      birthday: birthday ?? this.birthday,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'phone': phone,
      'address': address,
      'birthday': birthday,
      'avatar': avatar,
      'gender': gender,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      userName: map['userName'] as String,
      phone: map['phone'] != null ? map['phone'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      birthday: map['birthday'] != null ? map['birthday'] as String : null,
      avatar: map['avatar'] as String,
      gender: map['gender'] != null ? map['gender'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) => Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profile(userName: $userName, phone: $phone, address: $address, birthday: $birthday, avatar: $avatar, gender: $gender)';
  }

  @override
  bool operator ==(covariant Profile other) {
    if (identical(this, other)) return true;
  
    return 
      other.userName == userName &&
      other.phone == phone &&
      other.address == address &&
      other.birthday == birthday &&
      other.avatar == avatar &&
      other.gender == gender;
  }

  @override
  int get hashCode {
    return userName.hashCode ^
      phone.hashCode ^
      address.hashCode ^
      birthday.hashCode ^
      avatar.hashCode ^
      gender.hashCode;
  }
}
