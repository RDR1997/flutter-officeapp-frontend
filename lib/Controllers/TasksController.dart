import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:officeapp/Models/Environment.dart';
import 'package:http/http.dart' as http;
import 'package:officeapp/Models/Subordinates.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Models/Tasks.dart';
import '../Models/User.dart';
import '../Views/Components/TaskAddFaild.dart';
import '../Views/Components/TaskAddSuccsess.dart';
import '../Views/NavBar.dart';
import 'LoginController.dart';

class TasksController extends GetxController {
  final loginController = Get.put(LoginController());

  final categoryController = TextEditingController();
  final topicController = TextEditingController();
  final descriptionController = TextEditingController();

  var allTaskList = <Task>[].obs;
  var myListPending = <Task>[].obs;
  var myListInProgess = <Task>[].obs;
  var tasksByProjectList = <Task>[].obs;

  var singleTaskList = <Task>[].obs;
  var subordinateList = <Subordinate>[].obs;

  var userTaskCount = 0.obs;
  var userTaskPendingCount = 0.obs;
  var selectedSubordinateValue = ''.obs;
  var startDateTime = DateTime.now().obs;
  var dueDateTime = DateTime.now().obs;

  var isPendingLoading = true.obs;

  final editCategoryController = TextEditingController();
  final editTopicController = TextEditingController();
  final editDescriptionController = TextEditingController();
  var editStartDateTime = DateTime.now().obs;
  var editDueDateTime = DateTime.now().obs;
  var editSelectedSubordinateValue = ''.obs;
  var editStatus = ''.obs;
  var statusAction = ''.obs;
  var viewStatus = ''.obs;

  // for add task

  @override
  void onInit() {
    getAllTasks();
    getUserTasksInProgress();
    getUserTasksPending();
    getSubordinates();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  addTask(
      String project_id,
      String task_topic,
      String categroy,
      String description,
      String start_date,
      String due_date,
      String assigned_to,
      context) async {
    final url = "${Environment().api}/add-task";

    final response = await http.post(Uri.parse(url), body: {
      "project_id": project_id,
      "task_topic": task_topic,
      "category": categroy,
      "description": description,
      "start_date": start_date,
      "due_date": due_date,
      "assigned_to": assigned_to,
    }, headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });

    categoryController.clear();
    topicController.clear();
    descriptionController.clear();
  }

    editTask(
      String task_id,
      String task_topic,
      String categroy,
      String description,
      String start_date,
      String due_date,
      String assigned_to,
      context) async {


        print(task_topic);
        
    final url = "${Environment().api}/edit-task";

    final response = await http.post(Uri.parse(url), body: {
      "task_id" : task_id,
      "task_topic": task_topic,
      "category": categroy,
      "description": description,
      "start_date": start_date,
      "due_date": due_date,
      "assigned_to": assigned_to,
    }, headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });

    editCategoryController.clear();
    editTopicController.clear();
    editDescriptionController.clear();
  }

  void getAllTasks() async {
    var tasksData = await fetchAllTasks();
    List<Task> allTaskListData = tasksData.tasks;

    allTaskList.value = allTaskListData;
  }

  getUserTasksInProgress() async {
    var tasksData = await fetchUserTasksInProgress();
    userTaskCount.value = tasksData.tasks.length;
    List<Task> taskList = tasksData.tasks;

    myListInProgess.value = taskList;
  }

    getTasksByProject(project_id) async {
    var tasksData = await fetchTasksByProject(project_id);
    List<Task> taskList = tasksData.tasks;

    tasksByProjectList.value = taskList;
  }

  getUserTasksPending() async {
    var tasksData = await fetchUserTasksPending();
    userTaskPendingCount.value = tasksData.tasks.length;
    List<Task> taskList = tasksData.tasks;

    myListPending.value = taskList;
    isPendingLoading.value = false;
  }

  toggleStatusAction() async {
    if(statusAction.value=="Mark as completed"){
      viewStatus.value = "Complete";
      statusAction.value = "Mark as in progress"; 
      editStatus.value = "complete";
    }else if(statusAction.value=="Mark as in progress"){
      viewStatus.value = "In Progress";
      statusAction.value = "Mark as completed"; 
      editStatus.value = "in_progress";

    }
    final url = "${Environment().api}/edit-task-status";

    final response = await http.post(Uri.parse(url), body: {
      "task_id" : singleTaskList[0].id.toString(),
      "status" : editStatus.value,
      }, headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    // if (result['status_code'] == 200) {}

 }  

  getSingleTask(id) async {
    var singleTaskData = await fetchSingleTask(id);
    List<Task> singleTaskDataList = singleTaskData.tasks;

    singleTaskList.value = singleTaskDataList;

  if (singleTaskList[0].status == 'in_progress'){
    statusAction.value = "Mark as completed"; 
    viewStatus.value = "In Progress";
  }else{
    statusAction.value = "Mark as in progress"; 
    viewStatus.value = "Complete";

  }

  editCategoryController.text =singleTaskList[0].category;
  editTopicController.text = singleTaskList[0].taskTopic;
  editDescriptionController.text = singleTaskList[0].description;
  editStartDateTime.value = DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz').parseUTC(singleTaskList[0].startDate);
  editDueDateTime.value = DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz').parseUTC(singleTaskList[0].dueDate);
  editSelectedSubordinateValue.value = (singleTaskList[0].assignedTo).toString();


  }

  getSubordinates() async {
    var subordinateData = await fetchSubordinates();
    List<Subordinate> subordinateDataList = subordinateData.subordinates;

    subordinateList.value = subordinateDataList;
  }

  void selectSubordinateValue(String value) {
    selectedSubordinateValue.value = value;
  }

  Future<Subordinates> fetchSubordinates() async {
    ('-----------------------------');
    final url = "${Environment().api}/view-subordinates";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    (result);
    ('-----------------------------');

    return Subordinates.fromJson(result);
  }

  Future<Tasks> fetchAllTasks() async {
    final url = "${Environment().api}/view-all-tasks";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    return Tasks.fromJson(result);
  }

  Future<Tasks> fetchUserTasksInProgress() async {
    final url = "${Environment().api}/view-tasks-assigned-to-user-in-progress";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    return Tasks.fromJson(result);
  }

  Future<Tasks> fetchTasksByProject(project_id) async {
    final url = "${Environment().api}/view-tasks-by-project/$project_id";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    return Tasks.fromJson(result);
  }

  Future<Tasks> fetchUserTasksPending() async {
    final url = "${Environment().api}/view-tasks-assigned-to-user-pending";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    return Tasks.fromJson(result);
  }

  Future<Tasks> fetchSingleTask(id) async {
    (id);
    final url = "${Environment().api}/single-task/$id";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    return Tasks.fromJson(result);
  }
}
