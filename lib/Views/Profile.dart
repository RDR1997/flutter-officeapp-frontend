import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:officeapp/Controllers/LoginController.dart';
import 'package:officeapp/Views/Login.dart';
import 'package:officeapp/Views/SingleProject.dart';
import '../Controllers/HomeController.dart';
import '../Controllers/ProjectController.dart';
import '../Controllers/TasksController.dart';
import '../Controllers/NavBarController.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'package:carousel_slider/carousel_slider.dart';

class Profile extends StatelessWidget {
  final projectsController = Get.put(ProjectController());
  final tasksController = Get.put(TasksController());
  final userController = Get.put(NavBarController());
  final loginController = Get.put(LoginController());

  Profile({super.key});

  Future selectImage() async {
    final ImagePicker _picker = ImagePicker();

    final pickedImage = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedImage != null) {
      // adminController.thumbnail_url.value = XFile(pickedImage.path);
    } else {
      print("There is no any selected image");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;

    return GetX<TasksController>(
        builder: (controller) => Scaffold(
            extendBody: true,
            body: SingleChildScrollView(
              child: userController.isLoading.value
                  ? const Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30, bottom: 20, top: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Width * 0.6,
                            height: Width * 0.6,
                            child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Stack(children: [
                                  Container(
                                    // width: Width * 0.45,
                                    // height: Width * 0.45,
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      radius: 80,
                                      backgroundImage: NetworkImage(userController
                                          .proPicUrl
                                          .value), // Replace with your image URL
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: () async {
                                        selectImage();
                                      },
                                      icon: const Icon(Icons.edit),
                                      iconSize: 25,
                                      color: HexColor('#30a6d6'),
                                    ),
                                  )
                                ])),
                          ),
                          Text(
                            userController.userName.value,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: HexColor('#4d4d4d')),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Name: ',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: HexColor('#4d4d4d')),
                                ),
                                Text(
                                  userController.fullName.value,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor('#4d4d4d')),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Designation: ',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: HexColor('#4d4d4d')),
                                ),
                                Text(
                                  userController.designation.value,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor('#4d4d4d')),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Email: ',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: HexColor('#4d4d4d')),
                                ),
                                Text(
                                  userController.email.value,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor('#4d4d4d')),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Phone Number: ',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: HexColor('#4d4d4d')),
                                ),
                                Text(
                                  userController.phoneNo.value,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor('#4d4d4d')),
                                ),
                              ],
                            ),
                          ),
                          if (userController.supervisorList.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Supervisours: ',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: HexColor('#4d4d4d')),
                                  ),
                                  SizedBox(
                                    width: Width * 0.5,
                                    height: 45,
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: userController
                                          .supervisorListCount.value,
                                      itemBuilder: (context, index) {
                                        return Text(
                                            userController
                                                .supervisorList[index].fullName,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: HexColor('#4d4d4d')));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            // padding: const EdgeInsets.only(top: 5),
                            child: 
                            loginController.isLoading.value
                                ? const SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(),
                                  )
                                : 
                                SizedBox(
                                    width: Width * 0.3,
                                    height: Height * 0.06,
                                    child: MaterialButton(
                                      onPressed: () async {
                                        loginController.toggleLoading();
                                        await loginController.logout();
                                        Get.off(Login());
                                      },
                                      color: HexColor('#30a6d6'),
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Text(
                                        'Logout',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            color: HexColor('#f5f5f5')),
                                      ),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
            )));
  }
}
