import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:officeapp/Models/Environment.dart';
import 'package:http/http.dart' as http;
import 'package:officeapp/Models/Projects.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Models/Tasks.dart';
import '../Models/User.dart';
import '../Models/Users.dart';
import '../Views/NavBar.dart';
import 'LoginController.dart';

class ProjectController extends GetxController {
  final loginController = Get.put(LoginController());
  var projectList = <Project>[].obs;
  var singleProjectList = <Project>[].obs;
  var userProjectList = <Project>[].obs;

  var projectListCount = 0.obs;
  var isProjectLoading = true.obs;
  var isExpanded = false.obs;
  var tasksByProjectList = <Task>[].obs;
  var taskByProjectCount = 0.obs;
  var project_id = 0.obs;
  var selected_project_id = 0.obs;
  var selectedProjectValue = ''.obs;

  var editProjectTitleController = TextEditingController();
  var editProjectDescriptionController = TextEditingController();
  var editUsersList = <MultiSelectItem<AllUser>>[].obs;

  @override
  void onInit() {
    getProjects();
    // getTasksByProject(project_id);
    getProjectsByUser();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void selectProjectValue(String value) {
    selectedProjectValue.value = value;
  }

  void toggleIsEpanded(){
    isExpanded.value = !isExpanded.value;
  }

  getProjects() async {
    var projectData = await fetchProjects();
    projectListCount.value = projectData.projects.length;
    List<Project> projectDataList = projectData.projects;

    projectList.value = projectDataList;
  }

  getSingleProject(id) async {
    var singleProjectData = await fetchSingleProject(id);
    List<Project> singleProjectDataList = singleProjectData.projects;

    singleProjectList.value = singleProjectDataList;
    editProjectTitleController.text = singleProjectList[0].title;
    editProjectDescriptionController.text = singleProjectList[0].description;
    
  }

  void getProjectsByUser() async {
    var projectData = await fetchProjectsByUser();
    List<Project> userProjectDataList = projectData.projects;

    userProjectList.value = userProjectDataList;
  }

  getTasksByProject(project_id) async {
    var tasksData = await fetchTasksByProject(project_id);
    taskByProjectCount.value = tasksData.tasks.length;
    List<Task> taskByProjectListData = tasksData.tasks;

    tasksByProjectList.value = taskByProjectListData;
  }

  

  Future<Projects> fetchProjects() async {
    final url = "${Environment().api}/view-projects";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    return Projects.fromJson(result);
  }

  Future<Projects> fetchSingleProject(id) async {
    final url = "${Environment().api}/view-single-project/$id";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    return Projects.fromJson(result);
  }

  Future<Tasks> fetchTasksByProject(project_id) async {
    final url = "${Environment().api}/view-tasks-by-project/$project_id";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        // 'App-Version': appVersion,
        'Accept': 'application/json',
        'Cookie': loginController.cookie.value,
      },
    );
    var result = jsonDecode(response.body);

    return Tasks.fromJson(result);
  }

  Future<Projects> fetchProjectsByUser() async {
    final url = "${Environment().api}/view-projects-by-user";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    return Projects.fromJson(result);
  }
}
