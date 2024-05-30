// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int statusCode;
  UserClass user;

  User({
    required this.statusCode,
    required this.user,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        statusCode: json["status_code"],
        user: UserClass.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "user": user.toJson(),
      };
}

class UserClass {
  String designation;
  String email;
  String fullName;
  int id;
  int auth_level;
  String name;
  String password;
  String phoneNo;
  dynamic profilePicUrl;

  UserClass({
    required this.designation,
    required this.email,
    required this.fullName,
    required this.id,
    required this.auth_level,
    required this.name,
    required this.password,
    required this.phoneNo,
    required this.profilePicUrl,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        designation: json["designation"],
        email: json["email"],
        fullName: json["full_name"],
        id: json["id"],
        auth_level: json["auth_level"],
        name: json["name"],
        password: json["password"],
        phoneNo: json["phone_no"],
        profilePicUrl: json["profile_pic_url"],
      );

  Map<String, dynamic> toJson() => {
        "designation": designation,
        "email": email,
        "full_name": fullName,
        "id": id,
        "auth_level": auth_level,
        "name": name,
        "password": password,
        "phone_no": phoneNo,
        "profile_pic_url": profilePicUrl,
      };
}
