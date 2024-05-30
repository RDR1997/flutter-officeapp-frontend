import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:officeapp/Models/Environment.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Views/AdminPanel.dart';
import '../Views/NavBar.dart';
import '../services/firebase_api.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isObscure = true.obs;
  var isLoading = false.obs;
  var tostmsg = RxString('');
  var cookie = RxString('');
  var auth_level = 0.obs;
  var user_id = 1.obs;

  @override
  void onInit() {}

  @override
  void onReady() {
    super.onReady();
  }

  // @override
  // void onClose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  // }

  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  login(String name, String password) async {
    final url = "${Environment().api}/login";

    // await http.get(Uri.parse("${Environment().api_server}sanctum/csrf-cookie"),
    //     headers: {
    //       'Accept': 'application/json',
    //     });
    (url);
    (name);
    (password);

    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String appVersion = packageInfo.version;

    final response = await http.post(Uri.parse(url), body: {
      "name": name,
      "password": password,
    }, headers: {
      // 'App-Version': appVersion,
      'Accept': 'application/json',
    });
    String? cookies = response.headers['set-cookie'];
    List<String>? parts = cookies?.split(';');
    String? firstPart = parts?.first.trim();
    print(cookies);
    cookie.value = firstPart!;
    var result = jsonDecode(response.body);
    Fluttertoast.showToast(
        msg: result['msg'],
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54);

    auth_level.value = result['auth_level'];
    user_id.value = result['user_id'];
    if (result['status_code'] == 200) {
      isLoading.value = false;
      tostmsg.value = result['msg'];

      if (result['auth_level'] == 3) {
        Get.off(AdminPanel());
      } else {
        Get.off(NavBar());
      }
      emailController.clear();
      passwordController.clear();
    } else if (result['status_code'] == 401) {
      isLoading.value = false;
      tostmsg.value = result['msg'];
    } else {
      isLoading.value = false;
      tostmsg.value = result['msg'];
    }
  }

  logout() async {
    final url = "${Environment().api}/logout";

    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Cookie': cookie.value,
    });
    var result = jsonDecode(response.body);
    (result['msg']);
    (result['status_code']);
    isLoading.value = false;
  }
}
