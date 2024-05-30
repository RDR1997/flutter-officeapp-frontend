import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:officeapp/Models/Environment.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Models/Comments.dart';
import '../Models/Tasks.dart';
import '../Models/User.dart';
import '../Views/NavBar.dart';
import 'LoginController.dart';

class CommentController extends GetxController {
  final commentTextController = TextEditingController();
  final loginController = Get.put(LoginController());
  var commentList = <Comment>[].obs;

  late StreamController<List<Comment>> _commentStreamController;

  Stream<List<Comment>> get commentStream {
    _commentStreamController ??= StreamController<List<Comment>>.broadcast();
    return _commentStreamController.stream;
  }

  @override
  void onInit() {
    _commentStreamController = StreamController<List<Comment>>.broadcast();
    super.onInit();
  }

  @override
  void dispose() {
    _commentStreamController.close();
    super.dispose();
  }

  @override
  void onClose() {
    _commentStreamController.close();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  addComment(String taskid, String comment) async {
    (taskid);
    (comment);

    final url = "${Environment().api}/add-task-comment";

    final response = await http.post(Uri.parse(url), body: {
      "taskId": taskid,
      "comment": comment,
    }, headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
  }

  getComments(task_id) async {
    var commentData = await fetchcommentsByTask(task_id);
    List<Comment> commentDataList = commentData.comments;
    commentList.value = commentDataList;
    _commentStreamController.add(commentDataList);
  }

  Future<Comments> fetchcommentsByTask(task_id) async {
    final url = "${Environment().api}/view-task-comments/$task_id";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    return Comments.fromJson(result);
  }
}
