// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  String msg;
  int statusCode;
  List<AllUser> users;

  Users({
    required this.msg,
    required this.statusCode,
    required this.users,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        msg: json["msg"],
        statusCode: json["status_code"],
        users: List<AllUser>.from(json["users"].map((x) => AllUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "status_code": statusCode,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class AllUser {
  int authLevel;
  String designation;
  String email;
  String? fcmToken;
  String fullName;
  int id;
  String name;
  String password;
  String phoneNo;
  String? profilePicUrl;

  AllUser({
    required this.authLevel,
    required this.designation,
    required this.email,
    required this.fcmToken,
    required this.fullName,
    required this.id,
    required this.name,
    required this.password,
    required this.phoneNo,
    required this.profilePicUrl,
  });

  factory AllUser.fromJson(Map<String, dynamic> json) => AllUser(
        authLevel: json["auth_level"],
        designation: json["designation"],
        email: json["email"],
        fcmToken: json["fcm_token"],
        fullName: json["full_name"],
        id: json["id"],
        name: json["name"],
        password: json["password"],
        phoneNo: json["phone_no"],
        profilePicUrl: json["profile_pic_url"],
      );

  Map<String, dynamic> toJson() => {
        "auth_level": authLevel,
        "designation": designation,
        "email": email,
        "fcm_token": fcmToken,
        "full_name": fullName,
        "id": id,
        "name": name,
        "password": password,
        "phone_no": phoneNo,
        "profile_pic_url": profilePicUrl,
      };
}
