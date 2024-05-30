// To parse this JSON data, do
//
//     final subordinates = subordinatesFromJson(jsonString);

import 'dart:convert';

Subordinates subordinatesFromJson(String str) => Subordinates.fromJson(json.decode(str));

String subordinatesToJson(Subordinates data) => json.encode(data.toJson());

class Subordinates {
    String msg;
    int statusCode;
    List<Subordinate> subordinates;

    Subordinates({
        required this.msg,
        required this.statusCode,
        required this.subordinates,
    });

    factory Subordinates.fromJson(Map<String, dynamic> json) => Subordinates(
        msg: json["msg"],
        statusCode: json["status_code"],
        subordinates: List<Subordinate>.from(json["subordinates"].map((x) => Subordinate.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "status_code": statusCode,
        "subordinates": List<dynamic>.from(subordinates.map((x) => x.toJson())),
    };
}

class Subordinate {
    String designation;
    String email;
    String? fcmToken;
    String fullName;
    int id;
    String name;
    String password;
    String phoneNo;
    dynamic profilePicUrl;

    Subordinate({
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

    factory Subordinate.fromJson(Map<String, dynamic> json) => Subordinate(
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
