import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:officeapp/Controllers/LoginController.dart';
import 'package:officeapp/Models/Environment.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import '../Views/NavBar.dart';
import 'NavBarController.dart';

class SingUpController extends GetxController {
  final navBarController = Get.put(NavBarController());
  final loginController = Get.put(LoginController());

  final nameController = TextEditingController();
  final fullNameController = TextEditingController();
  final designationController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNoController = TextEditingController();
  final passwordController = TextEditingController();
  final re_passwordController = TextEditingController();

  var profile_pic = Rxn<XFile>();

  var isObscure = true.obs;
  var isLoading = false.obs;
  var tostmsg = RxString('');

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

  register(String name, String fullName, String designation, String password,
      String email, String phone_no, XFile profile_pic) async {
    final url = "${Environment().api}/register";

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;

    var request = http.MultipartRequest("POST", Uri.parse(url));

    request.fields["name"] = name;
    request.fields["full_name"] = fullName;
    request.fields["designation"] = designation;
    request.fields["password"] = password;
    request.fields["email"] = email;
    request.fields["phone_no"] = phone_no;

    request.headers.addAll({
      'App-Version': appVersion,
      'Accept': 'application/json',
    });

    if (profile_pic != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        await profile_pic.readAsBytes().then((value) {
          return value.cast();
        }),
        filename: profile_pic.path.toString() + profile_pic.name,
      ));
    }
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    var result = jsonDecode(responseBody);
    String? cookies = response.headers['set-cookie'];
    List<String>? parts = cookies?.split(';');
    String? firstPart = parts?.first.trim();
    loginController.cookie.value = firstPart!;

    // final response = await http.post(Uri.parse(url), body: {
    //   "name": name,
    //   "full_name": fullName,
    //   "designation": designation,
    //   "password": password,
    //   "email": email,
    //   "phone_no": phone_no
    // }, headers: {
    //   'App-Version': appVersion,
    //   'Accept': 'application/json',
    // });

    // var result = jsonDecode(response);
    Fluttertoast.showToast(
        msg: result['msg'],
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54);
    if (result['status_code'] == 200) {
      isLoading.value = false;
      tostmsg.value = result['msg'];
      await navBarController.getUser();

      // clear controllers singup
      nameController.clear();
      fullNameController.clear();
      designationController.clear();
      emailController.clear();
      phoneNoController.clear();
      passwordController.clear();
      re_passwordController.clear();

      Get.off(NavBar());
    } else if (result['status_code'] == 401) {
      isLoading.value = false;
      tostmsg.value = result['msg'];
    } else {
      isLoading.value = false;
      tostmsg.value = result['msg'];
    }
  }
}
