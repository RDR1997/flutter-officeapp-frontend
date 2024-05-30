// To parse this JSON data, do
//
//     final comments = commentsFromJson(jsonString);

import 'dart:convert';

Comments commentsFromJson(String str) => Comments.fromJson(json.decode(str));

String commentsToJson(Comments data) => json.encode(data.toJson());

class Comments {
  List<Comment> comments;
  String msg;
  int statusCode;

  Comments({
    required this.comments,
    required this.msg,
    required this.statusCode,
  });

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        msg: json["msg"],
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "msg": msg,
        "status_code": statusCode,
      };
}

class Comment {
  String comment;
  int?
   createdBy;
  String createdDate;
  int id;
  int taskId;
  String? created_by_name;

  Comment({
    required this.comment,
    required this.createdBy,
    required this.createdDate,
    required this.id,
    required this.taskId,
    required this.created_by_name,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        comment: json["comment"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        id: json["id"],
        taskId: json["taskId"],
        created_by_name: json["created_by_name"],
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "created_by": createdBy,
        "created_date": createdDate,
        "id": id,
        "taskId": taskId,
        "created_by_name": created_by_name,
      };
}
