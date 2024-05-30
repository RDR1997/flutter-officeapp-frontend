import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:officeapp/Models/Environment.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Models/Supervisor.dart';
import '../Models/User.dart';
import '../Views/NavBar.dart';
import '../services/firebase_api.dart';
import 'LoginController.dart';
import 'TasksController.dart';

class NavBarController extends GetxController {
  final PageController pageController = PageController();
  var selectedIndex = 0.obs;
  var appBarHeight = 100.obs;

  var userName = RxString('');
  var fullName = RxString('');
  var designation = RxString('');
  var email = RxString('');
  var phoneNo = RxString('');
  var proPicUrl = RxString('');
  var supervisorListCount = 0.obs;
  var auth_level = 1.obs;
  var user_id = 1.obs;

  var isLoading = true.obs;

  var supervisorList = <SupervisorElement>[].obs;

  final loginController = Get.put(LoginController());
  final tasksController = Get.put(TasksController());

  @override
  void onInit() async {
    getUser();
    getSupervisor();
    tasksController.getUserTasksInProgress();
    tasksController.getUserTasksPending();
    await storeFcmToken();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  getUser() async {
    var userData = await fetchUser();
    userName.value = userData.user.name;
    email.value = userData.user.email;

    fullName.value = userData.user.fullName;
    designation.value = userData.user.designation;
    phoneNo.value = userData.user.phoneNo;

    if (userData.user.profilePicUrl != null) {
      proPicUrl.value = userData.user.profilePicUrl;
    } else {
      print('+++++++++++++++++++++++++++++++++++++++++');
      proPicUrl.value = 'https://via.placeholder.com/150';
    }
    auth_level.value = userData.user.auth_level;
    isLoading.value = false;
  }

  void getSupervisor() async {
    var supervisorData = await fetchSupervisor();
    supervisorListCount.value = supervisorData.supervisors.length;
    List<SupervisorElement> supervisorDataList = supervisorData.supervisors;

    supervisorList.value = supervisorDataList;
  }

  Future<User> fetchUser() async {
    final url = "${Environment().api}/user";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    return User.fromJson(result);
  }

  Future<Supervisor> fetchSupervisor() async {
    final url = "${Environment().api}/view-supervisors";
    final response = await http.get(Uri.parse(url), headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    return Supervisor.fromJson(result);
  }

  // Function to retrieve FCM token from local storage

  // Function to store FCM token in the database
  Future<void> storeFcmToken() async {
    // Retrieve FCM token
    final fcmToken = await FirebaseApi().getFCMToken();
    if (fcmToken == null || fcmToken.isEmpty) {
      // Handle case where FCM token is not available
      Fluttertoast.showToast(
        msg: "FCM token is not available",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
      );
    }

    // Store FCM token in database
    final url = "${Environment().api}/store-fcm-token";
    final response = await http.post(
      Uri.parse(url),
      body: {
        "fcm_token": fcmToken,
      },
      headers: {
        'Accept': 'application/json',
        'Cookie': loginController.cookie.value,
      },
    );
    var result = jsonDecode(response.body);
    print(result['status_code']);

    if (result['status_code'] != 200) {
      Fluttertoast.showToast(
        msg: "There will be getting Notifications",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
      );
    }
  }
}
