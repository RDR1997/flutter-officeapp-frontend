// To parse this JSON data, do
//
//     final tasks = tasksFromJson(jsonString);

import 'dart:convert';

Tasks tasksFromJson(String str) => Tasks.fromJson(json.decode(str));

String tasksToJson(Tasks data) => json.encode(data.toJson());

class Tasks {
  String msg;
  int statusCode;
  List<Task> tasks;

  Tasks({
    required this.msg,
    required this.statusCode,
    required this.tasks,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
        msg: json["msg"],
        statusCode: json["status_code"],
        tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "status_code": statusCode,
        "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
      };
}

class Task {
  int assignedTo;
  int createdBy;
  String? created_by_name;
  String createdDate;
  String description;
  String dueDate;
  int id;
  dynamic modifiedDate;
  int projectId;
  String? projectTitle;
  String category;
  String startDate;
  String status;
  String taskTopic;

  Task({
    required this.assignedTo,
    required this.createdBy,
    required this.created_by_name,
    required this.createdDate,
    required this.description,
    required this.dueDate,
    required this.id,
    required this.modifiedDate,
    required this.projectId,
    required this.projectTitle,
    required this.category,
    required this.startDate,
    required this.status,
    required this.taskTopic,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        assignedTo: json["assigned_to"],
        createdBy: json["created_by"],
        created_by_name: json["created_by_name"],
        createdDate: json["created_date"],
        description: json["description"],
        dueDate: json["due_date"],
        id: json["id"],
        modifiedDate: json["modified_date"],
        projectId: json["project_id"],
        projectTitle: json["project_title"],
        category: json["category"],
        startDate: json["start_date"],
        status: json["status"],
        taskTopic: json["task_topic"],
      );

  Map<String, dynamic> toJson() => {
        "assigned_to": assignedTo,
        "created_by": createdBy,
        "created_by_name": created_by_name,
        "created_date": createdDate,
        "description": description,
        "due_date": dueDate,
        "id": id,
        "modified_date": modifiedDate,
        "project_id": projectId,
        "project_title": projectTitle,
        "category": category,
        "start_date": startDate,
        "status": status,
        "task_topic": taskTopic,
      };
}
