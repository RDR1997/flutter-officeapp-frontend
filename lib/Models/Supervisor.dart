
// To parse this JSON data, do
//
//     final supervisor = supervisorFromJson(jsonString);

import 'dart:convert';

Supervisor supervisorFromJson(String str) => Supervisor.fromJson(json.decode(str));

String supervisorToJson(Supervisor data) => json.encode(data.toJson());

class Supervisor {
    String msg;
    int statusCode;
    List<SupervisorElement> supervisors;

    Supervisor({
        required this.msg,
        required this.statusCode,
        required this.supervisors,
    });

    factory Supervisor.fromJson(Map<String, dynamic> json) => Supervisor(
        msg: json["msg"],
        statusCode: json["status_code"],
        supervisors: List<SupervisorElement>.from(json["supervisors"].map((x) => SupervisorElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "status_code": statusCode,
        "supervisors": List<dynamic>.from(supervisors.map((x) => x.toJson())),
    };
}

class SupervisorElement {
    String designation;
    String email;
    String? fcmToken;
    String fullName;
    int id;
    String name;
    String password;
    String phoneNo;
    dynamic profilePicUrl;

    SupervisorElement({
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

    factory SupervisorElement.fromJson(Map<String, dynamic> json) => SupervisorElement(
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
