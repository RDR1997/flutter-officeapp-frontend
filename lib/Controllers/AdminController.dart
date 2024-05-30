import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:officeapp/Models/Environment.dart';
import 'package:http/http.dart' as http;
import 'package:officeapp/Models/Supervisor.dart';
import 'package:officeapp/Views/Components/UserEditFaild.dart';
import 'package:officeapp/Views/Components/UserEditSuccsess.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Models/User.dart';
import '../Models/Users.dart';
import '../Views/NavBar.dart';
import 'LoginController.dart';
import 'ProjectController.dart';
import 'TasksController.dart';

class AdminController extends GetxController {
  final loginController = Get.put(LoginController());
  final projectController = Get.put(ProjectController());

  var usersList = <AllUser>[].obs;
  var items = <MultiSelectItem<AllUser>>[].obs;
  var selectedUsers = <MultiSelectItem<AllUser>>[].obs;

  var userName = RxString('');
  var fullName = RxString('');
  var designation = RxString('');
  var email = RxString('');
  var phoneNo = RxString('');
  var proPicUrl = RxString('');
  var thumbnail_url = Rxn<XFile>();

  var supervisorListCount = 0.obs;
  var auth_level = 1.obs;
  var selectedSupervisorId = 0.obs;
  var selectedAuth2UserId = 0.obs;

  var userId = 0.obs;

  var authLevel = [1, 2, 3];
  var supervisorList = <SupervisorElement>[].obs;
  var auth2UserList = <AllUser>[].obs;

  final editUsernameController = TextEditingController();
  final editFullnameController = TextEditingController();
  final editDesignationController = TextEditingController();
  final editEmailnController = TextEditingController();
  final editPhonNoController = TextEditingController();

  var isLoading = true.obs;
  var isAddProjectLoading = false.obs;
  var isEditEnable = false.obs;
  var isChecked = false.obs;

  final projectTitleController = TextEditingController();
  final projectDescriptionController = TextEditingController();
  final projectTumbnailController = TextEditingController();
  var selectedUsersId = ''.obs;

  @override
  void onInit() {
    getAllusers();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void toggleLoading() {
    isAddProjectLoading.value = !isAddProjectLoading.value;
  }

  void toggleChecked() {
    isChecked.value = !isChecked.value;
  }
  // addProject(
  //     String project_id,
  //     String task_topic,
  //     String categroy,
  //     String description,
  //     String start_date,
  //     String due_date,
  //     String assigned_to,
  //     context) async {
  //   final url = "${Environment().api}/add-task";

  //   final response = await http.post(Uri.parse(url), body: {
  //     "project_id": project_id,
  //     "task_topic": task_topic,
  //     "category": categroy,
  //     "description": description,
  //     "start_date": start_date,
  //     "due_date": due_date,
  //     "assigned_to": assigned_to,
  //   }, headers: {
  //     // 'App-Version': appVersion,
  //     'Accept': 'application/json',
  //     'Cookie': loginController.cookie.value,
  //   });

  //   categoryController.clear();
  //   topicController.clear();
  //   descriptionController.clear();
  // }

  addProject(String title, String description, XFile thumbnail_url,
      List selectedUsersList) async {
    final url = "${Environment().api}/add-project";

    List<String> userIds =
        selectedUsersList.map((user) => user.value.id.toString()).toList();
    final userListJson = jsonEncode(userIds);
    var request = http.MultipartRequest("POST", Uri.parse(url));
    request.fields["title"] = title;
    request.fields["description"] = description;
    request.fields["user_list"] = userListJson;

    request.headers.addAll({
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });

    //add files to request
    if (thumbnail_url != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        await thumbnail_url.readAsBytes().then((value) {
          return value.cast();
        }),
        filename: thumbnail_url.path.toString() + thumbnail_url.name,
      ));
    }
    var response = await request.send();
    print(response);

    projectTitleController.clear();
    projectDescriptionController.clear();
    selectedUsers.clear();
    toggleLoading();
  }

  editProject(String title, String description, XFile thumbnail_url,
      List selectedUsersList) async {
    final url = "${Environment().api}/edit-project";

    List<String> userIds =
        selectedUsersList.map((user) => user.value.id.toString()).toList();
    final userListJson = jsonEncode(userIds);

    var request = http.MultipartRequest("POST", Uri.parse(url));
    request.fields["project_id"] = projectController.singleProjectList[0].id.toString();
    request.fields["title"] = title;
    request.fields["description"] = description;
    request.fields["user_list"] = userListJson;
    request.headers.addAll({
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });

    if (thumbnail_url != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        await thumbnail_url.readAsBytes().then((value) {
          return value.cast();
        }),
        filename: thumbnail_url.path.toString() + thumbnail_url.name,
      ));
      print(thumbnail_url.path.toString() + thumbnail_url.name);
    }
    var response = await request.send();
    print(response);
    // final response = await http.post(Uri.parse(url), body: {
    //   "title": title,
    //   "description": description,
    //   "thumbnail_url": thumbnail_url,
    //   "user_list": userListJson,
    // }, headers: {
    //   // 'App-Version': appVersion,
    //   'Accept': 'application/json',
    //   'Cookie': loginController.cookie.value,
    // });

    projectController.editProjectTitleController.clear();
    projectController.editProjectDescriptionController.clear();
    projectController.editUsersList.clear();
    toggleLoading();
  }

  toggleEditButton() {
    isEditEnable.value = !isEditEnable.value;
  }

  getAllusers() async {
    var usersData = await fetchAllUsers();
    List<AllUser> usersDataList = usersData.users;

    usersList.value = usersDataList;

    items.value = usersDataList
        .map((users) => MultiSelectItem<AllUser>(users, users.fullName))
        .toList();
  }

  getAuth2users() async {
    print('9999999999999999999999999999');
    var auth2UserData = await fetchAuth2Users();
    List<AllUser> auth2UserDataList = auth2UserData.users;

    auth2UserList.value = auth2UserDataList;
    selectedAuth2UserId.value = auth2UserList[0].id;
  }

  getUser(user_id) async {
    var userData = await fetchUser(user_id);

    userId.value = user_id;
    userName.value = userData.user.name;
    editEmailnController.text = userData.user.email;
    editFullnameController.text = userData.user.fullName;
    editDesignationController.text = userData.user.designation;
    editPhonNoController.text = userData.user.phoneNo;

    if (userData.user.profilePicUrl != null) {
      proPicUrl.value = userData.user.profilePicUrl;
    } else {
      proPicUrl.value = 'https://via.placeholder.com/150';
    }
    auth_level.value = userData.user.auth_level;
    isLoading.value = false;
  }

  getSupervisorById(user_id) async {
    var supervisorData = await fetchSupervisorById(user_id);
    supervisorListCount.value = supervisorData.supervisors.length;
    List<SupervisorElement> supervisorDataList = supervisorData.supervisors;

    supervisorList.value = supervisorDataList;
    selectedSupervisorId.value = supervisorList[0].id;
  }

  editUser(String id, context) async {
    final url = "${Environment().api}/edit-user";

    print(id);
    print(auth_level);
    print(editEmailnController.text);
    print(editFullnameController.text);
    print(editDesignationController.text);
    print(editPhonNoController.text);
    print(selectedSupervisorId);

    final response = await http.post(Uri.parse(url), body: {
      "user_id": id,
      "auth_level": (auth_level.value).toString(),
      "email": editEmailnController.text,
      "full_name": editFullnameController.text,
      "designation": editDesignationController.text,
      "phone_no": editPhonNoController.text,
      "selected_supervisor_id": (selectedSupervisorId.value).toString(),
    }, headers: {
      // 'App-Version': appVersion,
      'Cookie': loginController.cookie.value,
      'Accept': 'application/json',
    });
    var result = jsonDecode(response.body);

    if (result['status_code'] == 200) {
      showDialog<String>(
        context: context,
        builder: (context) => const UserEditSuccsess(),
      );
    } else {
      showDialog<String>(
        context: context,
        builder: (context) => const UserEditFaild(),
      );
    }
  }

  Future<User> fetchUser(user_id) async {
    final url = "${Environment().api}/user-by-id/$user_id";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    return User.fromJson(result);
  }

  Future<Users> fetchAllUsers() async {
    final url = "${Environment().api}/view-all-users";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    return Users.fromJson(result);
  }

  Future<Users> fetchAuth2Users() async {
    final url = "${Environment().api}/view-auth2-users";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    return Users.fromJson(result);
  }

  Future<Supervisor> fetchSupervisorById(user_id) async {
    final url = "${Environment().api}/view-supervisor-id/$user_id";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    return Supervisor.fromJson(result);
  }
}
