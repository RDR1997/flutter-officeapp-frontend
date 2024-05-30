// To parse this JSON data, do
//
//     final notifis = notifisFromJson(jsonString);

import 'dart:convert';

Notifis notifisFromJson(String str) => Notifis.fromJson(json.decode(str));

String notifisToJson(Notifis data) => json.encode(data.toJson());

class Notifis {
  String msg;
  List<Notifi> notifications;
  int statusCode;

  Notifis({
    required this.msg,
    required this.notifications,
    required this.statusCode,
  });

  factory Notifis.fromJson(Map<String, dynamic> json) => Notifis(
        msg: json["msg"],
        notifications: List<Notifi>.from(
            json["notifications"].map((x) => Notifi.fromJson(x))),
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
        "status_code": statusCode,
      };
}

class Notifi {
  String createdDate;
  String description;
  int id;
  String title;
  int userId;
  int isRead;

  Notifi({
    required this.createdDate,
    required this.description,
    required this.id,
    required this.title,
    required this.userId,
    required this.isRead,
  });

  factory Notifi.fromJson(Map<String, dynamic> json) => Notifi(
      createdDate: json["created_date"],
      description: json["description"],
      id: json["id"],
      title: json["title"],
      userId: json["user_id"],
      isRead: json["isRead"]);

  Map<String, dynamic> toJson() => {
        "created_date": createdDate,
        "description": description,
        "id": id,
        "title": title,
        "user_id": userId,
        "isRead": isRead,
      };
}
