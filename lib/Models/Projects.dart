// To parse this JSON data, do
//
//     final projects = projectsFromJson(jsonString);

import 'dart:convert';

Projects projectsFromJson(String str) => Projects.fromJson(json.decode(str));

String projectsToJson(Projects data) => json.encode(data.toJson());

class Projects {
  String msg;
  List<Project> projects;
  int statusCode;

  Projects({
    required this.msg,
    required this.projects,
    required this.statusCode,
  });

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
        msg: json["msg"],
        projects: List<Project>.from(
            json["projects"].map((x) => Project.fromJson(x))),
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "projects": List<dynamic>.from(projects.map((x) => x.toJson())),
        "status_code": statusCode,
      };
}

class Project {
  int createdBy;
  String createdDate;
  String description;
  int id;
  String status;
  dynamic thumbnailUrl;
  String title;

  Project({
    required this.createdBy,
    required this.createdDate,
    required this.description,
    required this.id,
    required this.status,
    required this.thumbnailUrl,
    required this.title,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        description: json["description"],
        id: json["id"],
        status: json["status"],
        thumbnailUrl: json["thumbnail_url"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "created_by": createdBy,
        "created_date": createdDate,
        "description": description,
        "id": id,
        "status": status,
        "thumbnail_url": thumbnailUrl,
        "title": title,
      };
}
