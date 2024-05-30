import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:officeapp/Views/Notifications.dart';
import 'package:officeapp/Views/Project.dart';

import '../Controllers/NavBarController.dart';
import '../Controllers/TasksController.dart';
import 'Components/SidePanel.dart';
import 'Popup.dart';
import 'Home.dart';
import 'Profile.dart';

class AdminPanel extends StatelessWidget {
  final navBarController = Get.put(NavBarController());
  final tasksController = Get.put(TasksController());

  AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        drawer: SidePanel(),
        appBar: AppBar(
          flexibleSpace: Container(
            color: HexColor("#30a6d6"),
          ),
        ),
        body: Container(
            height: Height,
            width: Width,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.task_rounded,
                  size: 100,
                  color: HexColor("#30a6d6"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Admin Dashboard',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: HexColor('#4d4d4d')),
                ),
                // const SizedBox(height: 20,),
                Text(
                  'OfficeAPP',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 50,
                      fontWeight: FontWeight.w800,
                      color: HexColor('#4d4d4d')),
                )
              ],
            )));
  }
}
